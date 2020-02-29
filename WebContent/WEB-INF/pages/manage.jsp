<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>百度网盘-管理界面</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="<%=request.getContextPath() %>/assets/css/font-awesome.min.css" type='text/css' rel="stylesheet">
</head>

<body>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                                <ul class="navbar-nav " >
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle-o" style="font-size:24px"></i>  ${user.userName}</a>
                                            <div class="dropdown-menu dropdown-menu-right">
                                                 <a class="dropdown-item" onclick="help()">帮助中心</a>
                                                 <div class="dropdown-divider"></div> 
                                                 <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">退出</a>
                                            </div>
                                        </li>
                                    </ul>
                            </div>
                        </nav>
                        <br>
                        <table class="table" name="users">
                            <thead>
                                <tr>
                                    <th>用户id</th>
                                    <th>用户名</th><th>网盘序号</th><th></th><th></th><th></th>
                                    <th>总空间</th>
                                    <th></th><th>使用空间</th>
                                    <th>注册日期</th>
                                    <th></th>
                                </tr>
                            </thead>
                            
                            <tbody id="filelist">
                            	<c:forEach items="${userlist}" var="user" varStatus="st">
                            		<tr class="table-success">
                            			<td>${user.id}</td>
                                    	<td>
                                    		<span class="fa fa-user-circle-o"></span>  ${user.userName }
                                    	</td>
                                    	<td>${user.disk.id}</td><td></td><td></td><td></td>
                                    	<td>${user.disk.total_size}</td>
                                    	<td></td><td>${user.disk.used_size}</td>
                                    	<td>${user.regTime }</td>
                                    	<td>
                                    		<a href="#" onclick="rename(${user.id})"><span class="fa fa-pencil-square-o popover-hide" title="修改"></span>&nbsp;</a>
                                    		&nbsp;
                                    		<a href="#" onclick="delfile(${user.id})"><span class="fa fa-trash-o popover-hide" title="删除"></span>&nbsp;</a>
                                    	</td>
                                	</tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    

	
  	<script >
  	
  		$(function(){$('.popover-hide').popover('hide');});
  		
  		//删除用户
  		function delfile(id){
  			if(confirm("确认删除该用户"))
  			$.ajax({
  				type:"get",
  				url:"${pageContext.request.contextPath}/disk/deluser",
  				data:{
  					"id":id
  				},
  				success:function(data){
  					window.location.reload();
  				},
  				error:function(){
  				},
  			});	
  		};
  		
  		//修改文件
  		function rename(id){
  			var filename=prompt("修改用户名称")
  			if(filename)
  				alert("修改成功")
  		};
  		
  		//帮助中心
  		function help(){
  			alert("管理员不需要帮助")
  		}
    </script>

</body>

</html>