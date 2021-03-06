<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- JSTL -->

<!-- 强制  高速模式 渲染网页    -->
<meta NAME=”renderer” content=”webkit”>
<!-- 强制  高速模式 渲染网页    -->

<link href="http://localhost:8080/java456/static/favicon.ico" rel="shortcut icon" />
<link rel="stylesheet"	href="http://localhost:8080/java456/static/layui-v2.2.5/layui/css/layui.css">
<!--添加  jq  支持加载-->
<script	src="http://localhost:8080/java456/static/easy-ui/jquery.min.js"></script>
<!--添加  jq  支持加载-->


<!--添加 layui  支持加载-->

<script	src="http://localhost:8080/java456/static/layui-v2.2.5/layui/layui.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>

<style>
body {
	background: #ebebeb;
}

*{
	padding: 0px;
	margin: 0px;
}

.top_div {
	background: #008ead;
	width: 100%;
	height: 400px;
}

.content {
 	box-shadow: 0px 0px 66px 2px rgba(0,0,0,0.4);
	margin-bottom:50px;
	background: rgb(255, 255, 255);
	margin: -100px auto auto;
	border: 1px solid rgb(231, 231, 231);
	border-image: none;
	width: 450px;
	height: 200px;
	padding-top: 20px;
	padding-right: 20px;
	border-radius: 3px;
}


.layui-form-item {
	margin-bottom: 2px;
	clear: both;
}

.layui-form-label {
	width: 38px;
}

.layui-input-block {
	margin-left: 70px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#name").focus();
	});
	
	function go_login() {
		var index = layer.load(1, {
			shade : [ 0.1, '#fff' ]
		//0.1透明度的白色背景
		});
		
		var name = $("#name").val();
		var password = $("#password").val();
		
		if (name == null || name == "") {
			layer.closeAll();
			layer.alert('请输入帐号!');
			return;
		}
		
		if (password == null || password == "") {
			layer.closeAll();
			layer.alert('请输入密码!');
			return;
		}
		
		$.post('/java456/user/login', {
			name : name,
			password : password
		}, function(result) {
			if (result.success) {
				layer.closeAll();
				//document.location.href = "/admin/main";
				//window.open("/admin/main");
				//window.location.href = "/admin/main";
				$("#name").val("");
				$("#password").val("");
				window.location.href = "/java456/admin/main";
			} else {
				layer.closeAll();
				layer.alert(result.msg);
				$("#error").html(result.msg);
			}
		}, 'json');

	}
</script>
</head>
<body>

	<div class="top_div"></div>
	<div class="content">
		<div id="fm" class="layui-form" style="margin-bottom: 26px;" >
			<div class="layui-form-item">
				<label class="layui-form-label">帐号</label>
				<div class="layui-input-block">
					<input type="text" id="name"   lay-verify="title"
						autocomplete="off" placeholder="请输入帐号" onkeydown="if(event.keyCode==13) go_login()" class="layui-input">
				</div>
			</div>
			
			<div class="layui-form-item">
				<label class="layui-form-label">密码</label>
				<div class="layui-input-block">
					<input type="password" id="password"   lay-verify="title"
						autocomplete="off" placeholder="请输入密码" onkeydown="if(event.keyCode==13) go_login()"  class="layui-input">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="go_login()" lay-submit="" lay-filter="demo1">登陆</button>
				<button type="reset" onclick="clearData()" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</div>
	
	<div style="text-align: center; font-size: 13px; color: #525252; padding-top: 30px; "></div>
	
<script>
layui.use([ 'laydate', 'laypage', 'layer', 'table', 'carousel',
			'upload', 'element' ], function() {
		var laydate = layui.laydate //日期
		, laypage = layui.laypage //分页
		layer = layui.layer //弹层
		, table = layui.table //表格
		, carousel = layui.carousel //轮播
		, upload = layui.upload //上传
		, element = layui.element; //元素操作
});
</script>
</body>
</html>