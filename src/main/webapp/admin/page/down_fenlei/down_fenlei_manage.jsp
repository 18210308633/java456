<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title}</title>


<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- JSTL -->

${config.headStr}

${config.layuiStr}

<!-- 加入移动布局 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no"/>

<!-- 引入manage 的基础css -->
<script	src="${pageContext.request.contextPath}/static/js/houtai/manage_base.js"></script>
<link href="${pageContext.request.contextPath}/static/css/houtai/manage_base.css" rel="stylesheet"/>
<!-- 引入manage 的基础css -->

</head>
<style>
body{
	padding-top: 3px;
}
</style>
<body>
<script>

//用户选中的行ids = 1,2,3,5   len=4
var global_ids;
var global_ids_len;
//用户选中的行ids = 1,2,3,5   len=4
var w ;//窗口的宽
var h ;//窗口的高

//子窗口调用 的  关闭窗口方法 
function closeDlg(msg){
	 layer.closeAll();
	 layer.msg(msg);
	 reload_data();
}

//相当前刷新  重新加载
function reload_data(){
	table.reload('table', {
		 where: {
	        }
    });
}

//打开添加窗口
function add(){
	w = 500;
	h = 400;
	checkWindow();
	layer.open({
	  type: 2,
	  title: '添加',
	  shadeClose: true,
	  shade: 0.8,
	  area: [w+'px', h+'px'],
	  content: '/java456/houtai/down/fenlei/add' //iframe的url
	});
}


//打开编辑窗口
function edit(id){
	w = 500;
	h = 400;
	checkWindow();
	layer.open({
	  type: 2,
	  title: '修改',
	  shadeClose: true,
	  shade: 0.8,
	  area: [w+'px', h+'px'],
	  content: '/java456/houtai/down/fenlei/edit?id='+id //iframe的url
	});
}


function del(ids){
	var index = layer.load(1, {
		  shade: [0.1,'#fff'] //0.1透明度的白色背景
	});
	$.post('/java456/admin/down/fenlei/delete',{ids:ids},function(result){
		if(result.success){
			layer.closeAll();
			layer.msg('删除成功');
			reload_data();
		}else{
			layer.closeAll();
			layer.msg(result.msg);
		}
	},'json');
}

function table_edit_update(id,field,value){
	$.post('/java456/admin/down/fenlei/update?'+field+'='+value,{id:id},function(result){
		if(result.success){
			layer.msg('修改成功');
		}else{
			layer.closeAll();
			layer.msg(result.msg);
		}
	},'json');
}

function update_isUse(id,isUse){
	$.post('/java456/admin/down/fenlei/update',{id:id,isUse:isUse},function(result){
		if(result.success){
			layer.msg('修改成功');
		}else{
			layer.msg('修改失败');
		}
	},'json');
}

</script>

<div class="layui-form" style=" ">

<div class="layui-table-toolbar" style="margin-bottom: 3px;">
	<div class="layui-btn-group">
	 	<button onclick="add()" class="layui-btn   layui-btn-sm"><i class="layui-icon">&#xe654;</i>增加</button>
	  	<button class="layui-btn layui-btn-sm" onclick="delSelected()"><i class="layui-icon">&#xe640;</i>删除选中项</button>
	    <button onclick="reload_data()" class="layui-btn layui-btn-sm"><i class="layui-icon">&#x1002;</i>刷新</button>
 	 </div>
</div>

<table class="layui-hide"   id="table" lay-filter="table"></table> 
<script type="text/html" id="table_bar">
<div class="layui-btn-group">
	<a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
</div>
</script>


<script type="text/html" id="format_isUse">
  <input type="checkbox" name="content" value="{{d.id}}" lay-skin="switch" lay-text="是|否" lay-filter="tp_isUse" {{ d.isUse == 1 ? 'checked' : '' }}>
</script>


<script>
		layui.use([ 'laydate', 'laypage', 'layer', 'table', 'carousel',
				'upload', 'element' ], function() {
			var laydate = layui.laydate //日期
			, laypage = layui.laypage //分页
			,form= layui.form 
			layer = layui.layer //弹层
			, table = layui.table //表格
			, carousel = layui.carousel //轮播
			, upload = layui.upload //上传
			, element = layui.element; //元素操作
			  table.render({
			    elem: '#table'
			    ,url: '/java456/admin/down/fenlei/list',
			    height: 'full-60',
			   cols: [[
			      {checkbox: true, fixed: true}
			      ,{field:'name', title: '分类名称', width:180, edit: 'text',style:'font-size: 12px;'}
			      ,{field:'orderNo', title: '排序号', width:60, edit: 'text',style:'font-size: 12px;'}
			      ,{field:'isUse', title: '是否展示', width:60, templet: '#format_isUse'  }
			      ,{field:'createDateTime', title: '创建时间', width:115,style:'font-size: 12px;'}
			      ,{field:'updateDateTime', title: '更新时间', width:115,style:'font-size: 12px;'}
			      
			      ,{field:'remark', title: '备注', width:200, edit: 'text',style:'font-size: 12px;'}
			      
			      ,{fixed:'right', width:60,title: '操作', align:'center', toolbar: '#table_bar'}
			    ]]
			    ,id: 'table'
			    ,page: true
			    ,limits:[100,200,500,1000],
			   limit:100
			  });
			    
			
			//监听工具条 table_bar
				table.on('tool(table)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					var data = obj.data //获得当前行数据
					, layEvent = obj.event; //获得 lay-event 对应的值
					if (layEvent === 'del') {
						//layer.msg('查看操作' + data.id);
						opend_del_dlg(data.id);
					} else if (layEvent === 'set_ps') {
						set_ps(data.id);
					} else if (layEvent === 'edit') {
						//layer.msg('编辑操作' + data.id);
						edit(data.id);
					} else if (layEvent === 'set_persm'){
						set_persm(data.id);
					}
				});
			
			
				//监听单元格编辑
				  table.on('edit(table)', function(obj){
				    var value = obj.value //得到修改后的值
				    ,data = obj.data //得到所在行所有键值
				    ,field = obj.field; //得到字段
				    //layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
				    table_edit_update(data.id,field,value);
				  });
					
				  //是否关注 
				  form.on('switch(tp_isUse)', function(obj){
				    //layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
				    if(obj.elem.checked){
				    	update_isUse(this.value,1);
				    }else{
				    	update_isUse(this.value,0);
				    }
				  });
				
		});
</script>


</body>
</html>
