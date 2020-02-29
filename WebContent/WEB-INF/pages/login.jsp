<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>百度网盘，让美好永远陪伴</title>
    <!-- <script>
        addEventListener("load", function () { setTimeout(hideURLbar, 0); }, false); function hideURLbar() { window.scrollTo(0, 1); }
    </script> -->
    <script src="<%=request.getContextPath() %>/assets/js/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/assets/bootstrap-4.3.1-dist/js/bootstrap.js"></script>
    <link href="<%=request.getContextPath() %>/assets/css/font-awesome.min.css" type='text/css' rel="stylesheet">
    <link href="<%=request.getContextPath() %>/assets/css/style.css" rel='stylesheet' type='text/css' media="all">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/bootstrap-4.3.1-dist/css/bootstrap.css">

 
    
    <link href="//fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
</head>
<body>
    <h1 class="error"></h1>
	<!---728x90--->
    <div class="w3layouts-two-grids">
	<!---728x90--->
        <div class="mid-class">
            <div class="img-right-side">
                <h3>“安全存储，在线预览，好友分享,多端并用”</h3>
                <img src="${pageContext.request.contextPath}/assets/images/b11.png" class="img-fluid" id="img" alt="">
            </div>
            <div class="txt-left-side" id="login_div">
                <h2>账号密码登录</h2>
                <!-- 登陆表单 -->
                <form action="${pageContext.request.contextPath}/dologin" method="post" id="login">
                    <div class="form-left-to-w3l">
                        <span class="fa fa-user" aria-hidden="true"></span>
                        <input type="text" name="name" id="login_username" placeholder=" Name">
                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l ">
                        <span class="fa fa-lock" aria-hidden="true"></span>
                        <input type="password" name="pass" id="login_password" placeholder="Password">
                        <div class="clear"></div>
                    </div>
                   <%--  <div class="form-left-to-w3l ">
                    	<span class="fa fa-paper-plane" aria-hidden="true"></span>
                        <input type="text" name="text" id="code" placeholder="validate code" required="" onkeyup="validateCode()">
                         <label><img type="image" src="${pageContext.request.contextPath}/code" id="codeImage"  style="cursor:pointer"/></label>
                        <div class="clear"></div>
                    </div> --%>
                    <div class="main-two-w3ls">
                        <div class="left-side-forget">
                            <input type="checkbox" class="checked" id="re">
                            <label class="remenber-me" for="re">下次自动登录</label>
                        </div>
                        <div class="right-side-forget">
                            <a href="#" class="for" data-toggle="modal" data-target="#forget">忘记密码？</a>
                        </div>
                    </div>
                    <div class="btnn">
                        <button type="submit">登录</button>
                    </div>
                </form>
                <div class="w3layouts_more-buttn">
                    <h3>Don't have an account
                        <a href="#" onclick="return_register()">立即注册</a>
                    </h3>
                </div>
                <div class="clear"></div>
            </div>
            
            <div class="txt-left-side" id="register_div" style ="display:none">
                <h2>账号注册</h2>
                <!-- 注册表单 -->
                <form  id="register" onsubmit="return false">
                    <div class="form-left-to-w3l">
                        <span class="fa fa-user" aria-hidden="true"></span>
                        <input type="text" name="username" id="username" placeholder=" Name" required="" >
                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l ">
                        <span class="fa fa-lock" aria-hidden="true"></span>
                        <input type="password" name="password" id="password" placeholder="Password" required="" >
                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l">
                        <span class="fa fa-envelope-o" aria-hidden="true"></span>
                        <input type="email" name="email" id="email" placeholder="Email address" required="" >
                        <div class="clear"></div>
                    </div> 
                   <!--  <div class="main-two-w3ls">
                    	<div class="left-side-forget">
                        </div>
                        <div class="right-side-forget ">
                        	<span class="fa fa-refresh fa-spin"></span>
                            <input type="reset" class="for" value="重写" >
                        </div>
                    </div> -->
                    <div class="btnn">
                       <button type="submit">注册</button>
                    </div>
                </form>
                <div class="w3layouts_more-buttn">
                    <h3>I have an account
                        <a href="#" onclick="return_login()">返回登录</a>
                    </h3>
                </div>
                <div class="clear"></div>
            </div>
            
        </div>
    </div>
    
    <!--找回密码模态框-->
	<div class="modal fade" id="forget" role="dialog" tabindex="-1" aria-labelledby="PersonalCenterLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
               		<h4 class="modal-title" id="myModalLabel">找回密码</h4>
                	<button type="button" class="close" data-dismiss="modal">
                    	<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                	</button>

            	</div>
            	<!-- form表单提交 -->
            	<form class="form-horizontal" role="form" method="post" id="forgetform">
                	<div class="modal-body">
                    	<!-- 表格 -->
                    	<div class="form-group">
                        	<div class="col-sm-6">
                            	用&nbsp;户&nbsp;名:<input type="text" class="form-control" id="username" name="username" value="">
                        	</div>
                    	</div>
                    	
                    	<div class="form-group">
                        	<div class="col-sm-6">
                            	注&nbsp;册&nbsp;邮&nbsp;箱:<input type="email" class="form-control" id="email" name="email" value="">
                        	</div>
                    	</div>
                	</div>
                	<div class="modal-footer">
                    	<button type="submit" class="btn btn-primary">确认</button>
                	</div>
            	</form>
        	</div>
    	</div>
	</div>
 
	
    <script>

      //显示注册
        function return_register(){
       	 	//获取显示和隐藏的div
       	 	var register = document.getElementById("register_div");
            var login = document.getElementById("login_div");
            document.getElementById("img").src="${pageContext.request.contextPath}/assets/images/b110.png";
            register.style.display = "block";
            login.style.display = "none";
       };
       
        //显示登录
		function return_login(){
        	 //获取显示和隐藏的div
        	var register = document.getElementById("register_div");
            var login = document.getElementById("login_div");
            document.getElementById("img").src="${pageContext.request.contextPath}/assets/images/b11.png";
        	register.style.display = "none";
            login.style.display = "block";
        };
        
        //找回密码
        function find_pass(){
        	alert("我也不知道");
        };
        
        //注册
        $("#register").submit(function(){
        	$.ajax({
    			type:"post",
    			url:"${pageContext.request.contextPath}/doregister",
    			data:$("#register").serialize(),
    			success:function(data){
    				alert(data);
    				return_login();
    				$("#login_username").val("<%=request.getSession().getAttribute("username")%>");
    				<%-- $("#login_password").val("<%=request.getSession().getAttribute("password")%>"); --%>
    			},
    			error:function(){
    				alert("fail to register！");
    				return_register();
    			},
    		});	
        });
        
      //找回密码
        $("#forgetform").submit(function(){
        	$.ajax({
    			type:"post",
    			url:"${pageContext.request.contextPath}/doforget",
    			data:$("#forgetform").serialize(),
    			success:function(data){
    				confirm(data);
    			},
    			error:function(){
    				alert("ddd")
    				return_login();
    			},
    		});	
        });
      
      //修改密码
      function changepass(){
    	  var filename=prompt("请输入新密码","新建文件夹")
    	  if(filename){
    		  
    	  }
      };
        
       //更新验证码
       $("#codeImage").click(function(){
    	   $("#codeImage").attr("src","${pageContext.request.contextPath}/code?timestamp=" + (new Date()).valueOf());
       });
       
       //找回密码
      
    </script>
</body>
</body>
</html>