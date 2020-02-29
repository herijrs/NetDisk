<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>百度网盘</title>
    <!-- <link rel="stylesheet" href="bootstrap.css"> -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="<%=request.getContextPath() %>/assets/css/font-awesome.min.css" type='text/css' rel="stylesheet">
     
    <%--  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
  	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
  	<link href="<%=request.getContextPath() %>/assets/css/font-awesome.min.css" type='text/css' rel="stylesheet"> --%>
  	
  
    <style>
        .upload {
            position: relative;
            display: inline-block;
            overflow: hidden;
        }
        .upload input{
            position:absolute;
            opacity: 0;
            -ms-filter: 'alpha(opacity=0)';
            font-size: 50px;
        }
        .aa:hover {
        	class:fa fa-eercast;
        }
        a:hover{
        	text-decoration:none;
        }
        #myImg img{
            width: 300px;
            height: 200px;
        }
    </style>
</head>

<body>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-2">
                        <div class="btn-group btn-group-md btn-group-vertical " role="group">
                            <button class="btn btn-secondary">
                                <div>
                                    <a href="${pageContext.request.contextPath}/disk/index">
                                    <img src="${pageContext.request.contextPath}/assets/images/1.gif" style="width: 80%; height: 25%;">
                                    </a>
                                </div>
                            </button>
                            <button class="btn btn-secondary" type="button">
                             <a href="${pageContext.request.contextPath}/disk/index">
                            <i class="fa fa-folder-open-o" style="font-size:24px"></i>
                                	&nbsp;全部文件</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="${pageContext.request.contextPath}/disk/classify?type=image" style="color:white"><i></i>&nbsp;图片</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="${pageContext.request.contextPath}/disk/classify?type=text" style="color:white"><i></i>&nbsp;文档</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="#"  style="color:white"><i></i>&nbsp;视频</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="#" style="color:white"><i></i>&nbsp;种子</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="#" style="color:white"><i></i>&nbsp;音乐</a>
                            </button>
                            <button class="btn btn-secondary" type="button">
                            	<a href="#" style="color:white"><i></i>&nbsp;其他</a>
                            </button>
                        </div>
                        <br><br><br><br>

                        <div class="progress progress-striped active">
                            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="60"
                                aria-valuemin="0" aria-valuemax="100" style="width: 80%" id="bar">${user.disk.used_size/1024}K/1024K
                            </div> 
                        </div>
                    </div>
                    
                    
                    <div class="col-md-10">
                        <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-dark bg-dark">

                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            	<%-- <%
									long token = System.currentTimeMillis(); //产生时间戳的token  
									session.setAttribute("token", token);
								%> --%>
                                <ul class="nav nav-pills">
                                
                                    <li class="nav-item" align="center">
                                       <%--  <form id="upload" method="post" action="${pageContext.request.contextPath}/disk/upload" enctype="multipart/form-data" class="nav-link active btn btn-sucess btn-sm upload">
                                        	<input type="file" id="file" name="file">上传
                                        	<input type="submit"> <i class="fa fa-send-o"></i>
                                        	<input type="hidden" value="<%=token%>" name="Reqtoken" />
                                        </form> --%>
                                        <a class="nav-link active btn btn-sucess btn-sm upload" href="#" data-target="#myModal" data-toggle="modal" id="upload">上传 <i class="fa fa-send-o"></i></a>
                                    </li>
                                    
                                    
                                    <li class="nav-item u">
                                        <a class="nav-link" href="#" onclick="addfolder()">新建文件夹 <i class="fa fa-plus-square-o"></i></a>
                                    </li>
                                    <li class="nav-item u"> 
                                        <a class="nav-link" href="#" data-target="#share" data-toggle="modal">分享 <i class="fa fa-check-square-o"></i></a>
                                    </li>
                                </ul>
                                
                                <form class="form-inline ml-md-auto" action="${pageContext.request.contextPath}/disk/search" id="search">
                                    <input class="form-control mr-sm-2" type="text" name="search" />
                                    <button class="btn btn-primary my-2 my-sm-0" type="submit">
                                        Search
                                    </button>
                                </form>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                
                                <ul class="navbar-nav ">
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle-o" style="font-size:24px"></i>  ${user.userName}</a>
                                            <div class="dropdown-menu dropdown-menu-right">
                                            	 <a class="dropdown-item" href="#" data-toggle="modal" data-target="#pdata">个人资料</a> 
                                                 <a class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-container-65327">二级密码</a>
                                                 <a class="dropdown-item" onclick="help()">帮助中心</a>
                                                 <div class="dropdown-divider"></div> 
                                                 <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">退出</a>
                                            </div>
                                        </li>
                                    </ul>
                            </div>
                        </nav>
                        <br>
                        <table class="table" name="files">
                            <thead>
                                <tr>
                                    <th>文件名</th>
                                    <th></th><th></th><th></th><th></th><th></th><th></th><th></th>
                                    <th>大小</th>
                                    <th></th><th></th>
                                    <th>修改日期</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="filelist">
                            	<c:forEach items="${filelist}" var="file" varStatus="st">
                            		<c:if test="${file.file_size == 0}">
                            		<tr class="table-success">
                                    	<td>
                                    		<a href="${pageContext.request.contextPath}/disk/enter?id=${file.id}">
                                    		<span class="fa fa-folder-open-o popover-hide" title="预览" aria-hidden="true"></span>  ${file.filename }
                                    		</a>
                                    	</td>
                                    	<td></td><td></td><td></td><td></td><td></td>
                                    	<span class="aa"></span><td></td><td></td>
                                    	<td>-</td>
                                    	<td></td><td></td>
                                    	<td>${file.time }</td>
                                    	<td>
                                    		<a href="#" onclick="rename(${file.id})"><span class="fa fa-pencil-square-o popover-hide" title="修改"></span>&nbsp;</a>
                                    		<a href="#" onclick="delfile(${file.id})"><span class="fa fa-trash-o popover-hide" title="删除"></span>&nbsp;</a>
                                    		<a href="#" onclick="share(${file.id})"><span class="fa fa-superscript popover-hide" title="分享"></span>&nbsp;</a>
                                    		<a href="#"><span class="fa fa-cloud-download popover-hide" title="下载"></span></a>
                                    	</td>
                                	</tr>
                                	</c:if>
                                	
                                	<c:if test="${file.file_size !=0 }">
                            		<tr class="table-success">
                                    	<td>
                                    		<a href="#" onclick="preview(${file.id})" data-toggle="modal"><span class="fa fa-eercast" aria-hidden="true"></a></span>&nbsp;${file.filename }
                                    	</td>
                                    	<td></td><td></td><td></td><td></td><td></td>
                                    	<span class="aa"></span><td></td><td></td>
                                    	<td>${file.file_size/1024 }</td>
                                    	<td></td><td></td>
                                    	<td>${file.time }</td>
                                    	<td>
                                    		<a href="#" onclick="rename(${file.id})"><span class="fa fa-pencil-square-o popover-hide" title="修改"></span>&nbsp;</a>
                                    		<a href="#" onclick="delfile(${file.id})"><span class="fa fa-trash-o popover-hide" title="删除"></span>&nbsp;</a>
                                    		<a href="#" onclick="share(${file.id})"><span class="fa fa-superscript popover-hide" title="分享"></span>&nbsp;</a>
                                    		<a href="${pageContext.request.contextPath}/disk/download?id=${file.id}"><span class="fa fa-cloud-download popover-hide"title="下载"></span></a>
                                    		
                                    	</td>
                                	</tr>
                                	</c:if>
                                	
                            	</c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 上传模态框 -->
    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
    
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">上传文件</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
    
                <!-- 模态框主体 -->
                <form class="form-horizontal" role="form"
                    action="${pageContext.request.contextPath}/disk/upload"
                    method="post" id="form" enctype="multipart/form-data">
                    <div class="modal-body">
                        <!-- 表格 -->
                        <div class="custom-file">
                            <input type="file" class="custom-file-input file-loading" id="fileinput" name="file"
                                onchange="loadFile(this.files[0]) " accept="image/* ,text/*"> <label id="filename"
                                class="custom-file-label" for="fileinput">请上传文件</label>
								<%-- <input type="hidden" value="<%=token%>" name="Reqtoken" /> --%>
                        </div>
                    </div>
                    <!-- 模态框底部 -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="save">上传</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
     <!-- 分享模态框 -->
    <div class="modal fade" id="share">
        <div class="modal-dialog">
            <div class="modal-content">
    			
    			<form id="saveform" onsubmit="return false">
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">保存分享文件</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
    			
                <!-- 模态框主体 -->
                <div class="modal-body">
                	<label for="sharelink" class="control-label">分享链接:</label>
                    <input type="text" class="form-control" id="sharelink" name="sharelink">
                    <label for="sharecode" class="control-label">提取码:</label>
                    <input type="text" class="form-control" id="sharecode" name="sharecode">
                	<!-- 分享链接&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="sharelink"> -->
           	 	</div>
           	 	<!-- 模态框底部 -->
                <div class="modal-footer">
                	<button type="submit" class="btn btn-primary" id="sharebutton">保存</button>
                	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	</div>
            	</form>
            </div>
        </div>
    </div>
     
     <!-- 个人资料模态框 -->
     <div class="modal fade" id="modal-container-65327" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
     	<div class="modal-dialog" role="document">
     		<div class="modal-content">
     			<div class="modal-header">
     				<h4 class="modal-title" id="myModalLabel"> ${user.userName}</h4>
                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	</div>
            	<div class="modal-body text-center">
                	<span id="myImg">
                    	<img src="${pageContext.request.contextPath}/assets/images/1.gif" class="img-circle">
                	</span>
            	</div>
     			<div class="modal-footer">
     				<button type="button" class="btn btn-secondary" data-dismiss="modal">很棒</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 文件预览模态框 -->
	<div class="modal fade" id="preview" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
           		<div class="modal-header">
           			<h4 class="modal-title" id="myModalLabel"> 文件预览</h4>
                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	</div>
            	<div class="modal-body text-center">
                	<span id="myImg">
                    	<img id="img" src="#" class="img-circle" style ="display:none">
                    	<iframe id="text" src="#" width='100%' height='500' frameborder='1' style ="display:block"></iframe>
                	</span>
            	</div>
            	<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	</div>
        	</div> 
    	</div> 
	</div>
	
	<!--个人资料模态框-->
	<div class="modal fade" id="pdata" role="dialog" tabindex="-1" aria-labelledby="PersonalCenterLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
               		<h4 class="modal-title" id="myModalLabel">个人资料</h4>
                	<button type="button" class="close" data-dismiss="modal">
                    	<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                	</button>

            	</div>
            	<!-- form表单提交注册示例 -->
            	<form class="form-horizontal" role="form"action="${pageContext.request.contextPath}/disk/personcenter"method="post" id="form">
                	<div class="modal-body">
                    	<!-- 表格 -->
                    	<div class="form-group">
                        	<label for="inputusername" class="col-sm-3 control-label">用&nbsp;户&nbsp;名: </label>
                        	<input type="text" class="form-control" id="oldusername"name="oldusername" value="${user.userName }" hidden>
                        	<div class="col-sm-6">
                            	<input type="text" class="form-control" id="newusername" name="newusername" value="${user.userName }" disabled>
                        	</div>
                    	</div>
                    	
                    	<div class="form-group">
                        	<label for="inputPassword" class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;码:</label>
                        	<div class="col-sm-6">
                            	<input type="text" class="form-control" id="password" name="password" value="${user.password }" disabled>
                        	</div>
                    	</div>
                    
                    	<div class="form-group">
                        	<label for="inputemail" class="col-sm-3 control-label">注&nbsp;册&nbsp;邮&nbsp;箱:</label>
                        	<div class="col-sm-6">
                            	<input type="email" class="form-control" id="email" name="email" value="${user.email }" disabled>
                        	</div>
                    	</div>
                	</div>
                	<div class="modal-footer">
                    	<button type="button" class="btn btn-primary" id="fix">修改</button>
                    	<button type="submit" class="btn btn-primary" id="fixx" hidden=true>保存</button>
                    	<button type="button" class="btn btn-default" id="qx" data-dismiss="modal" hidden=true>关闭</button>
                	</div>
            	</form>
        	</div>
    	</div>
	</div>
	
	
  	<script >
  	
  	$(function(){$('.popover-hide').popover('hide');});
  	
	$(document).ready(function(){
		var error='<%=session.getAttribute("error")%>';
		if(error!='null'){
			alert(error);
			<%request.getSession(true).removeAttribute("error");%>;
		}
	}); 
	
  	
	//新建文件夹
	function addfolder(){
		var filename=prompt("请输入文件夹名称","新建文件夹")
		if(filename)
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/disk/addfolder",
			data:{
				"filename":filename
				},
			success:function(data){
				if(data==0)
					alert("创建失败(存在同名文件夹)");
				window.location.reload();
			},
			error:function(){
				alert("dddddd");
			},
		});	
	};
	
	//删除文件
	function delfile(id){
		if(confirm("确认删除该文件"))
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/disk/delfile",
			data:{
				"id":id
			},
			success:function(data){
				window.location.reload();
			},
			error:function(){
				alert("dddddd");
			},
		});	
	};
	
	//修改文件
	function rename(id){
		var filename=prompt("修改文件(夹)名称")
		if(filename)
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/disk/rename",
			data:{
				"id":id,
				"filename":filename
			},
			success:function(data){
				window.location.reload();
			},
			error:function(){
				alert("dddddd");
			},
		});	
	};
	
	//分享文件
	function share(id){
		if(confirm("确认分享该文件"))
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/disk/sharepath",
			scriptCharset: 'utf-8', 
			data:{
				"id":id
			},
			success:function(data){
				alert(data);
			},
			error:function(){
				alert("dddddd");
			},
		});	
	};
	
	//预览文件
	function preview(id){
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/disk/preview",
			data:{
				"id":id
			},
			success:function(data){
				$("#img").attr("src",data);
				$("#text").attr("src",data);
				$("#preview").modal({backdrop:false});
			},
			error:function(){
				alert("dddddd");
			},
		});
	}; 
	
	//保存链接文件
	$("#saveform").submit(function(){
    	$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/disk/saveshare",
			scriptCharset: 'utf-8', 
			data:$("#saveform").serialize(),
			success:function(data){
				if("1"==data)
					alert("保存成功");
				window.location.reload();
			},
			error:function(){
				alert("dddddd");
			},
		});	
    });
	
	//上传文件
	function loadFile(file) {
		var type = file.type;
		if(type.startsWith("text/")||type.startsWith("image/")){
			$("#filename").html(file.name);
		}
		else {
			alert(type+"不允许类型");
		}
	};
	
	//修改个人资料
	$("#fix").click(function(){
		$("#newusername").attr("disabled",null)
		$("#password").attr("disabled",null)
		$("#fix").attr("hidden",true)
		$("#fixx").attr("hidden",false)
		$("#qx").attr("hidden",false)
	});
	
	//帮助中心
	function help(){
		alert("你不需要帮助")
	}
	  
    </script>

</body>

</html>