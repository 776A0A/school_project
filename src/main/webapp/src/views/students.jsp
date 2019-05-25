<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<style>
	/* 关于图片的显示 
	.layui-table-cell {
	     height: 80px!important;
	     white-space: normal;
	} */
	/* .layui-table-cell img {
		width: 80px;
	} */
</style>
<title>学生信息管理页面</title>
</head>
<body>
	<table id="studentsList" lay-filter="test"></table>
	
	<script type="text/html" id="topToolBar">
		<div class="layui-inline">
			<input class="layui-input" name="classId" id="classId" placeholder="班级ID" autocomplete="off">
		</div>
		<div class="layui-input-inline">
	      <select name="className" id="className">
	        <option value="">请选择班级</option>
	      </select>
	    </div>
		<div class="layui-inline">
			<input class="layui-input" name="stuId" id="stuId" placeholder="学生ID" autocomplete="off">
		</div>
		<div class="layui-inline">
			<input class="layui-input" name="studentName" id="studentName" placeholder="学生名称" autocomplete="off">
		</div>
		<div class="layui-btn-group">
			<button class="layui-btn" lay-event="search">搜索</button>
			<button class="layui-btn" lay-event="add">添加</button>
			<button class="layui-btn" lay-event="multiDelete">删除</button>
		</div>
	</script>
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="scores">成绩</a>
  		<a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
	
	<script type="text/javascript">
	
		layui.use(['table', 'jquery', 'layer', 'form'], function() {
			var table = layui.table, $ = layui.jquery, layer = layui.layer, form = layui.form;
			table.render({
				elem: '#studentsList',
				url: '${pageContext.request.contextPath}/students/selStudents.action',
				method: 'post',
				page: true,
				toolbar: '#topToolBar',
				done: function(res, curr, count) {
					console.log("服务器返回数据: ", res, "数据数量: ", count)
				},
				cols: [[
			        {
			        	type: 'checkbox',
			        	fixed: 'left',
			        },
			        {
						field : 'className',
						title : '班级',
						sort : true,
						align: 'center',
					},
					{
						field : 'name',
						title : '学生',
						sort : true,
						align: 'center',
					},{
						field : 'img',
						title : '头像',
						align : 'center',
						templet: function(data) {
							if (!data.img) { // 用户未上传头像时
								return '<img src="">';
							}
							return '<img src="${pageContext.request.contextPath}/' + data.img + '">';
						},
					},{
						field : 'status',
						title : '学习状态',
						align : 'center',
						templet: function(data) {
							return '<input type="checkbox"' 
									+ (data.status === 1? 'checked' : '') 
									+ ' id=' + data.id
									+ ' lay-filter="switchTest" lay-skin="switch" lay-text="在学|休学">';
						},
					},{
						field : 'detailed',
						title : '详细地址',
						align : 'center',
						sort : true,
						templet: function(data) {
							return (data.pName || '') + (data.cName || '') + (data.aName || '') + (data.detailed || '');
						}
					},{
						field : 'time',
						title : '创建时间',
						align : 'center',
						sort : true
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
			
			// 头部事件处理
			table.on('toolbar(test)', function(obj){
				var event = obj.event;
			    if (event === 'search') {
			    	table.reload('studentsList', {
						url : '${pageContext.request.contextPath}/students/selStudents.action',
						where : {
							classId: $('#classId').val() || $('#className').val() || 0,
							id: $('#stuId').val() || 0,
							name: $('#studentName').val() || null
						}
					});
			    	getClassNameList()
			    } else if (event === 'multiDelete') {
			    	if (ids.length === 0) {
			    		return;
			    	} else {
			    		layer.confirm('确认删除？', function(index) {
			    			table.reload('studentsList', {
								url: '${pageContext.request.contextPath}/students/delStudents.action',
				    		    where: { ids: ids },
				    		    page: { curr: 1  }
							});
			    			layer.close(index);
			    			getClassNameList()
			    		})
					}
			    } else if (event === 'add') {
					layer.open({
						type: 2, 
						content: '${pageContext.request.contextPath}/src/views/studentForm.jsp',
						area: ['100%', '100%'],
						shadeClose: true,
					}); 
			    }
			    
			}); // table.on
			
			// 行内工具栏事件
			table.on('tool(test)', function(obj){ // test是table原始容器的属性 lay-filter="对应的值"
				  var data = obj.data; // 获得当前行数据
				  var event = obj.event; // 获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				  if (event === 'del') {
					  layer.confirm('确认删除？', function(index){
						  table.reload('studentsList', {
								url : '${pageContext.request.contextPath}/students/delStudents.action',
								where : { id: data.id }
							});
					      layer.close(index);
				    	});
				  	} else if (event === 'scores') {
				  		layer.open({
							type: 2, 
							title: data.name + '的成绩',
							content: '${pageContext.request.contextPath}/students/editResults.action?stuId=' + data.id,
							area: ['40%', '60%'],
							shadeClose: true,
						}); 
				  	}
			}); // table.on
			
			// 动态渲染下拉框
			function getClassNameList() {
				$.ajax({
					url: '${pageContext.request.contextPath}/classes/selClass.action',
					method: 'get',
					success: function(data) {
						var data = data.data;
						var html = '';
						data.forEach(function(item) {
							html += '<option value="' + item.id + '">' + item.className + '</option>';
						})
						$('#className').append(html);
						form.render('select');
					}
				})
			}
			getClassNameList()
			
			var ids = '';
			// 复选框事件
			table.on('checkbox(test)', function(obj){ 
				var checkStatus = table.checkStatus('studentsList'); // 获取所有选中行的相关信息
				var data = checkStatus.data;
				ids = '';
				data.forEach(function(item) {
					ids += item.id + ',';
				})
			});
			
			// 监听switch按钮切换学生状态
			form.on('switch(switchTest)', function(data){
				var elem = data.elem;
				var data = {
						status: elem.checked ? 1 : 2,
						id: elem.id
					}
				$.ajax({
					url: "${pageContext.request.contextPath}/students/updateStatus.action",
					data: data,
					type: 'post',
					success: function(data) { console.log('status修改成功！') }
	 			})
				
			}); 
		})
	</script>
</body>
</html>