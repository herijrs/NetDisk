package com.netdisk.controller;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.netdisk.model.User;
import com.netdisk.repository.DiskRepository;
import com.netdisk.repository.UsersRepository;

@Controller
public class RootController {

	@Resource
	UsersRepository usersRepository;
	@Resource
	DiskRepository diskRepository;
	
	@RequestMapping(value= "/")
	public String root() {
		return "login";
	}
	
	@RequestMapping("/doregister")
	public void doregister(HttpServletRequest request, HttpServletResponse response,Model model) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		User user = usersRepository.findUser(username, password);
		System.out.println("------------------------------------------");
		if(user==null) {
			Date d = new Date();
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = s.format(d);
			int id = usersRepository.findid();
			usersRepository.addUser(username, password,email,time);
			diskRepository.adddisk(id, 1048576, 0);
			int disk_id = this.diskRepository.finddisk_id(id);
	
			
			try {
				HttpSession session=request.getSession();
				session.setAttribute("username", username);
				response.getWriter().write("Registered successfully!Now log in...");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	@RequestMapping("/dologin")
	public String login(String name,String pass,HttpSession session,Model model,HttpServletRequest request ) {
		User user= usersRepository.findUser(name, pass);
		String filepath= "assets"+File.separator+"attached"+File.separator+user.getUserName(); //上传文件路径
		String realpath = request.getSession().getServletContext().getRealPath("/")+filepath;
		if(!user.equals(null)) {
			session.setAttribute("user",user);
			//管理员登陆
			if("manager".equals(name)&&"manager".equals(pass))
				return "redirect:disk/manager";
			File fi = new File(realpath);
			System.out.println(realpath);
			if(!fi.exists()) {
				fi.mkdir();
			}
			return "redirect:disk/index";
		} else {
			System.out.println("登陆失败");
			return "login";
		}
	}
	
	//找回密码
	@ResponseBody
	@RequestMapping("/doforget")
	public String doforget(HttpServletRequest request ) {
		String name = request.getParameter("username");
		String email = request.getParameter("email");
		String pass = this.usersRepository.findpass(name,email);
		return pass;
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}
	
	private char[] codeSequence = { '2', '3', '4', '5', '6', '7', '8',
	        '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
	        'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };  
      
    @RequestMapping("/code")  
    public void getCode(HttpServletResponse response,HttpSession session) throws IOException{  
        int width = 63;  
        int height = 37;  
        Random random = new Random();  
        //设置response头信息  
        //禁止缓存  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);  
  
        //生成缓冲区image类  
        BufferedImage image = new BufferedImage(width, height, 1);  
        //产生image类的Graphics用于绘制操作  
        Graphics g = image.getGraphics();  
        //Graphics类的样式  
        g.setColor(this.getColor(200, 250));  
        g.setFont(new Font("Times New Roman",0,28));  
        g.fillRect(0, 0, width, height);  
        //绘制干扰线  
        for(int i=0;i<40;i++){  
            g.setColor(this.getColor(130, 200));  
            int x = random.nextInt(width);  
            int y = random.nextInt(height);  
            int x1 = random.nextInt(12);  
            int y1 = random.nextInt(12);  
            g.drawLine(x, y, x + x1, y + y1);  
        }  
  
        //绘制字符  
        String strCode = "";  
        for(int i=0;i<4;i++){  
            String rand = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);  
            strCode = strCode + rand;  
            g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));  
            g.drawString(rand, 13*i+6, 28);  
        }  
        //将字符保存到session中用于前端的验证  
        session.setAttribute("authCode", strCode.toLowerCase());  
        g.dispose();  
  
        ImageIO.write(image, "JPEG", response.getOutputStream());  
        response.getOutputStream().flush();  
    }  
      
    public  Color getColor(int fc,int bc){  
        Random random = new Random();  
        if(fc>255)  
            fc = 255;  
        if(bc>255)  
            bc = 255;  
        int r = fc + random.nextInt(bc - fc);  
        int g = fc + random.nextInt(bc - fc);  
        int b = fc + random.nextInt(bc - fc);  
        return new Color(r,g,b);  
    }  
}
