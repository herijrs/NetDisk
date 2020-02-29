package com.netdisk.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.netdisk.model.Files;
import com.netdisk.model.Share;
import com.netdisk.model.User;
import com.netdisk.repository.DiskRepository;
import com.netdisk.repository.FileRepository;
import com.netdisk.repository.ShareRepository;
import com.netdisk.repository.UsersRepository;

@Controller
@RequestMapping("/disk")
public class DiskController {
	@Resource
	FileRepository fileRepository;
	@Resource
	DiskRepository diskRepository;
	@Resource
	ShareRepository shareRepository;
	@Resource
	UsersRepository userRepository;
	
	//主页面
	@RequestMapping("/index")
	public String home(HttpServletRequest request,Model model,HttpSession session) {
		User user=(User)session.getAttribute("user");
		String fileparent = 0+"";
		List<Files> files=fileRepository.findAllfile(user.getId(),fileparent);
		session.setAttribute("filelist", files);
		System.out.println("**********************************");
		System.out.println(request.getRequestURL());
		session.setAttribute("parent",fileparent);
		return "home";
	}
	
	//进入文件夹
	@RequestMapping("/enter")
	public String enter(@RequestParam("id")int id,Model model,HttpSession session) {
		User user=(User)session.getAttribute("user");
		List<Files> files=fileRepository.findfolder(user.getId(), id+"");
		session.setAttribute("filelist", files);
		session.setAttribute("parent",id);
		return "home";
	}
	
	//下载文件
	@RequestMapping("/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request,@RequestParam("id")int id,Model model)throws Exception {
    	//下载文件路径
    	String realpath = this.fileRepository.findpath(id); //上传文件路径
		String path = request.getSession().getServletContext().getRealPath("/")+realpath;
		String filename = this.fileRepository.findname(id);
		File file = new File(path);
		HttpHeaders headers = new HttpHeaders();  
		//下载显示的文件名，解决中文名称乱码问题  
		String downloadFielName = new String(filename.getBytes("UTF-8"),"iso-8859-1");
		//通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName); 
		//application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
			headers, HttpStatus.CREATED);  
    }

	
	//删除文件
	@ResponseBody
	@RequestMapping("/delfile")
	public String delfile(@RequestParam("id")int id,HttpServletRequest request,HttpSession session) {
		User user=(User)session.getAttribute("user");
		String realpath = this.fileRepository.findpath(id); //上传文件路径
		String path = request.getSession().getServletContext().getRealPath("/")+realpath;
		System.out.println(path);
		List<Files> allfile = fileRepository.findchild(user.getId(),realpath);
		System.out.println("*******查找到"+allfile.size()+"条记录*******");
		for(Files f:allfile) {
			new File(path).delete();
			fileRepository.delfile(f.getId());
		}
		
		diskRepository.updatedisk(fileRepository.findsize(user.getId()), user.getId());
		return "";
	}
	
	private char[] codeSequence = { '2', '3', '4', '5', '6', '7', '8',
	        '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
	        'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };  
	
	//获得分享连接
	@ResponseBody
	@RequestMapping(value="/sharepath",produces="text/html;charset=UTF-8")
	public String sharepath(HttpServletRequest request, @RequestParam("id")int id,HttpSession session) throws IOException {
		User user=(User)session.getAttribute("user");
		//获取提取码
		Random random = new Random();  
		String sharecode = "";
		 for(int i=0;i<4;i++) {
			 String rand = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);
			 sharecode = sharecode + rand;  
		 }
		//创建时间
		Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = s.format(d);
		
		String name = this.fileRepository.findname(id);
		String path = fileRepository.findpath(id);
		this.shareRepository.addlink(user.getId(), path, sharecode,name,time);
	
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("sharelink",path);
		map.put("sharecode",sharecode);
		//map集合转换为JSON对象
		String data =  new ObjectMapper().writeValueAsString(map);
		return data;
	}
	
	//保存分享文件(只能分享文件)
	@ResponseBody
	@RequestMapping("/saveshare")
	public String saveshare(HttpServletRequest request,HttpSession session) throws IOException {
		String sharelink = request.getParameter("sharelink");
		String sharecode = request.getParameter("sharecode");
		
		String fileparent = ""+session.getAttribute("parent");
	    User user=(User)session.getAttribute("user");
		System.out.println(fileparent);
		List<Share> linklist = this.shareRepository.findlink(sharelink, sharecode);
		if(linklist.isEmpty()) {
			System.out.println("保存失败");
			session.setAttribute("error", "保存失败");
			return "0";
		}
		
		String filepath = request.getSession().getServletContext().getRealPath("/")+sharelink;//文件保存位置
		String filename = this.shareRepository.findname(sharelink, sharecode);
		File file = new File(filepath);
		long file_size =file.length();//字节
		
//		BigInteger used_size = user.getDisk().getUsed_size();
//	    BigInteger total_size = user.getDisk().getTotal_size();
//
//	    System.out.println(used_size+"=============="+"total_size");
//	    //当前文件夹下文件重名或网盘空间不足
//		if(BigInteger.valueOf(file_size).compareTo(total_size.subtract(used_size))==1) {
//			session.setAttribute("error", "用户空间超过网盘大小");
//			return "0";
//		}
//		if(this.fileRepository.findfile(user.getId(), filename, sharelink, fileparent).size()>0) {
//			session.setAttribute("error", "当前文件夹下存在相同文件");
//			return "0";
//		}
		
		Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = s.format(d);
		String filetype = this.fileRepository.findtypebyname(filename);
		fileRepository.addfile(user.getId(), sharelink, filename,time, file_size,fileparent,filetype);
		diskRepository.updatedisk(fileRepository.findsize(user.getId()), user.getId());
		List<Files> files=fileRepository.findAllfile(user.getId(),fileparent);
		session.setAttribute("filelist", files);
		return "1";
	}
	
	//修改文件名
	@ResponseBody
	@RequestMapping("/rename")
	public String rename(HttpServletRequest request,HttpSession session) {
		int id =Integer.parseInt(request.getParameter("id"));
		String filename = request.getParameter("filename");
		String filepath = fileRepository.findpath(id);
//		String newpath = filepath.substring(0,filepath.lastIndexOf(File.separator))+File.separator+filename;
		fileRepository.rename(filename,id);
//		fileRepository.repath(newpath , id);
//		System.out.println(newpath);
		return "";
	}
	
	//上传文件
    @RequestMapping("/upload")
    public String upload(HttpServletRequest request,HttpServletResponse response,HttpSession session,MultipartFile file)throws IOException{
//    	String tokenSession =  ""+session.getAttribute("token");  
//    	session.removeAttribute("token");
//	    String token = request.getParameter("Reqtoken");
	    String fileparent = ""+session.getAttribute("parent");
	    System.out.println("当前文件上一个文件夹为："+fileparent);
	    User user=(User)session.getAttribute("user");
		String filetype = file.getContentType();
		
		System.out.println(user.getUserName()+"         "+user.getDisk().getDisk_userid());
	    BigInteger used_size = user.getDisk().getUsed_size();
	    BigInteger total_size = user.getDisk().getTotal_size();
	    
	    System.out.println(file.getSize()+"****************************");
	    System.out.println(total_size.subtract(used_size));
	    //用户空间限制
		if( BigInteger.valueOf(file.getSize()).compareTo(total_size.subtract(used_size))==1) { 
			System.out.println("用户使用空间超过网盘大小");
			session.setAttribute("error", "用户空间超过网盘大小");
	        return "home";
		}
	    
		long file_size =file.getSize();//字节
	    String filename = file.getOriginalFilename();
	    Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = s.format(d);
		
		String pa = "";
		String ty = fileparent;
		while(!"0".equals(ty)){
			pa = fileRepository.findname(Integer.parseInt(fileparent))+File.separator +pa;
			ty = fileRepository.findparent(user.getId(),Integer.parseInt(ty));
		};

		String filepath = "assets"+File.separator+"attached"+File.separator+user.getUserName()+File.separator+pa+filename; //上传文件路径
		String realpath = request.getSession().getServletContext().getRealPath("/")+filepath;
		System.out.println(realpath);
		System.out.println(filepath);
		if(fileRepository.findfile(user.getId(),filename,filepath,fileparent).isEmpty()) {
			fileRepository.addfile(user.getId(),filepath,filename,time, file_size,fileparent,filetype);
			diskRepository.updatedisk(fileRepository.findsize(user.getId()), user.getId());
			File fi = new File(realpath);
			if(!fi.exists()) {
				fi.mkdir();
				fi.createNewFile();
				file.transferTo(fi);
			}
		}
		else {
			System.out.println("文件上传失败(文件已存在或同名)");
			session.setAttribute("error", "文件上传失败(文件已存在或同名)");
		}
		List<Files> files=fileRepository.findAllfile(user.getId(),fileparent);
		session.setAttribute("filelist", files);
        return "home";
    }
    
    //添加文件夹
    @ResponseBody
    @RequestMapping("addfolder")
    public String addfolder(HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
	    User user=(User)session.getAttribute("user");
	    String filename = request.getParameter("filename");
	    String fileparent =  ""+session.getAttribute("parent");
	    long file_size = 0;//k
	    Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = s.format(d);
		String pa = "";
		String ty = fileparent;
		while(!"0".equals(ty)){
			pa = fileRepository.findname(Integer.parseInt(fileparent))+File.separator +pa;
			ty = fileRepository.findparent(user.getId(),Integer.parseInt(ty));
		};
		String filepath = "assets"+File.separator+"attached"+File.separator+user.getUserName()+File.separator+pa+filename; //上传文件路径
		String realpath = request.getSession().getServletContext().getRealPath("/")+filepath;
		
//		String filepath = "d:\\桌面\\0\\"+user.getUserName()+File.separator+pa+filename;
		System.out.println(filepath);
		if(fileRepository.findfile(user.getId(), filename, filepath,fileparent).isEmpty()) {
			fileRepository.addfile(user.getId(), filepath, filename, time, file_size,fileparent,"folder");
			File fi = new File(realpath);
			if(!fi.exists()) {
				fi.mkdir();
				fi.createNewFile();
			}
		    List<Files> files=fileRepository.findAllfile(user.getId(),fileparent);
			session.setAttribute("filelist", files);
			return "1";
		}
		else {
			List<Files> files=fileRepository.findAllfile(user.getId(),fileparent);
			session.setAttribute("filelist", files);
			System.out.println("文件已存在");
			return "0";
		}
    }
    
    //查找文件
	@RequestMapping("/search")
	public String search(HttpServletRequest request,HttpSession session) {
		User use = (User) session.getAttribute("user");
		String search = request.getParameter("search");
		List<Files> files=fileRepository.searchfile(use.getId(),search);
		session.setAttribute("filelist", files);
		return "home";
	}
	
	//预览文件
	@ResponseBody
	@RequestMapping(value="/preview",produces="text/html;charset=UTF-8")
	public String preview(HttpServletRequest request,HttpSession session) throws IOException{
		String id = request.getParameter("id");
		String filepath = this.fileRepository.findpath(Integer.parseInt(id));
		String previewurl = request.getContextPath()+File.separator+filepath;
		System.out.println(previewurl);
		return previewurl;
	}
	
	//文件分类
	@RequestMapping(value="/classify")
	public String classify(HttpServletRequest request,HttpSession session, @RequestParam("type")String type) {
		User use = (User) session.getAttribute("user");
		List<Files> files=fileRepository.findfilebytype(use.getId(),type);
		session.setAttribute("filelist", files);
		return "home";
	}
	
	//个人资料修改
	@RequestMapping(value="/personcenter")
	public String personcenter(HttpSession session,String oldusername,String newusername,String password,String email) {
		int flag  = this.userRepository.updateUser(newusername,password, email, oldusername);
		User user=this.userRepository.findbyname(newusername);
		if(flag==1) {
			session.setAttribute("user", user);
			session.setAttribute("fixmsg", "修改成功");
		}else {
			session.setAttribute("fixmsg", "修改失败");
		}
		return "redirect:/disk/index";
	}
	
	//管理员界面
	@RequestMapping(value="/manager")
	public String maneger(HttpSession session,HttpServletRequest request) {
		List<User> userlist = this.userRepository.findalluser();
		session.setAttribute("userlist", userlist);
		return "manage";
		
	}
	
	//管理员删除用户
	public String deluser(@RequestParam("id")int id,HttpSession session,HttpServletRequest request) {
		List<User> userlist = this.userRepository.findalluser();
		session.setAttribute("userlist", userlist);
		return "";
		
	}	
	
	
}
