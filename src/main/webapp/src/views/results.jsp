<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<title>学生成绩</title>
</head>
<body>
	<table id="resultsList" lay-filter="test"></table>
	
	<script type="text/html" id="topToolBar">
		<div class="layui-inline">
			<input class="layui-input" name="classId" id="classId" placeholder="班级ID" autocomplete="off">
		</div>
		<div class="layui-inline">
			<input class="layui-input" name="className" id="className" placeholder="班级名称" autocomplete="off">
		</div>
		<div class="layui-btn-group">
			<button class="layui-btn" lay-event="search">搜索</button>
			<button class="layui-btn" lay-event="add">添加</button>
			<button class="layui-btn" lay-event="multiDelete">删除</button>
		</div>
	</script>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
	
	<script type="text/javascript">
		layui.use(['table', 'jquery', 'layer'], function() {
			var table = layui.table, $ = layui.jquery, layer = layui.layer;
			table.render({
				elem: '#resultsList',
				url: '${pageContext.request.contextPath}/results/selResults.action',
				method: 'post',
				page: true,
				toolbar: '#topToolBar',
				cols: [[
			        {
			        	type: 'checkbox',
			        	fixed: 'left',
			        },
			        {
						field : 'id',
						title : 'id',
						sort : true,
						align: 'center',
					},
					{
						field: 'chinese',
						title: '语文',
						align: 'center'
					},
					{
						field: 'english',
						title: '英语',
						align: 'center'
					},
					{
						field: 'math',
						title: '数学',
						align: 'center'
					},
					{
						field : 'edit',
						title : '操作',
						align : 'center',
						toolbar: '#barDemo',
						fixed: 'right',
					}
		        ]] // cols
			}) // table.render
			
		})
	</script>
</body>
</html>