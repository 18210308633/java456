<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- JSTL -->

${config.headStr}

${config.layuiStr}


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title} - ${config.web_name}</title>
<meta name="keywords" content="${blog.keywords }" />
<meta name="description" content="${blog.description_}"/>


<!--添加 公共css -->
<link rel="stylesheet"	href="/static/css/pc/base.css?version=${config.banben}">
<!--添加 公共css -->

<!--添加 本页css -->
<link rel="stylesheet"	href="/static/css/pc/down_fenlei_list.css?version=${config.banben}">
<!--添加 本页css -->


<!--显示代码 模块 -->
<script type="text/javascript" src="/static/ueditor/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="/static/ueditor/third-party/SyntaxHighlighter/shCoreDefault.css">
<script type="text/javascript">
SyntaxHighlighter.all();
</script>
<!--显示代码 模块 -->

<script>

$(function(){
	if("${downFenLeiId}"!=""){
		$("#fenlei_${downFenLeiId}").addClass("down_fenlei_on");
	}else{
		$("#all").addClass("down_fenlei_on");
	}
});


</script>

</head>
<body>

<div class="wrap">
	
	<!-- 加载导航 -->
	<jsp:include page="/pc/component/daohang.jsp"/>
	<!-- 加载导航   -->
	
	<div class="model" style="background-color: white;">
		<div class="content">
			<div class="blog_fenlei">
				<div class="blog_fenlei_title">
					分类 ：
				</div>
				
				<div class="blog_fenlei_content">
					<a id="all" href="/java456/a/down/list">全部</a>
					
					<c:forEach var="downFenLei" items="${downFenLeiList}" varStatus="status">
						<a id="fenlei_${downFenLei.id}" href="/java456/a/down/list?id=${downFenLei.id}">${downFenLei.name}</a>
					</c:forEach>
					
				</div>
			</div>
			
			<!--content 内部   清除浮动 -->
			<div style=" clear:both;"></div>
		</div>
	</div>
	
	
	<div class="model" style="background-color: #e0e0e0;">
		<div class="content">
			
			<div style="padding: 23px 10px 10px 10px; overflow: hidden; min-height: 500px;">
				
				<c:forEach var="down" items="${downList}" varStatus="status">
					<div class="down_item">
						<div class="down_item_inner">
							<div style="overflow: hidden;">
								<div class="down_item_num">
									<c:if test="${down.thumbnail_image!=null}">
										<img style="width: 100%; height: 100%;" src="${down.thumbnail_image}" />
									</c:if>
								</div>
								
								<div class="down_item_info">
									<div style="height:27px; overflow:hidden; line-height: 27px; font-size: 17px; font-weight: bold; border-bottom: 1px solid  #d6d6d6; margin-bottom: 5px;">
										${down.title }
									</div>
									<div style="height:27px; line-height: 27px; overflow:hidden;">
										${down.summary}
									</div>
								</div>
							</div>
							<div style="text-align: right;">
								 <a href="/a/down/get?id=${down.id }" class="layui-btn layui-btn-xs">进入下载</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			
			
			<!--content 内部   清除浮动 -->
			<div style=" clear:both;"></div>
		</div>
	</div>
	
	
	
	
	
	
	
	<!-- 临时模块 -->
	<jsp:include page="/pc/component/temp.jsp"/>
	<!-- 临时模块 -->
	
	<!-- 加载底部 模块 -->
	<jsp:include page="/pc/component/food.jsp"/>
	<!-- 加载底部 模块 -->
	
</div>


</body>
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
		
		
		//调用示例
        layer.photos({
          photos: '.blog_content'
          ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
        }); 
		
		
		
});
</script>
</html>