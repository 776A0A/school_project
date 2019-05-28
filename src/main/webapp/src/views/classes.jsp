<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String path = request.getContextPath();
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<title>班级</title>
</head>
<body>
	<table id="classList" lay-filter="test"></table>
	
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
  		<a class="layui-btn layui-btn-xs" lay-event="update">编辑</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
	<script type="text/javascript">
		<%-- <%=basePath%> 可以获取到含端口号的url--%>
		layui.use(['table', 'jquery', 'layer'], function() {
			var table = layui.table, $ = layui.jquery, layer = layui.layer;
			table.render({
				elem: '#classList',
				url: '${pageContext.request.contextPath}/classes/selClassMap.action',
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
						title : '班级id',
						sort : true,
						align: 'center',
					},
					{
						field: 'className',
						title: '班级名称',
						align: 'center',
						sort: true,
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
			    	if ($('#classId').val() == '' && $('#className').val() == '') {
			    		location.reload()
			    	} else {
				    	table.reload('classList', {
							url: '${pageContext.request.contextPath}/classes/selClassMap.action',
			    		    where: {
								id: $('#classId').val() || 0,
			    			    className: $('#className').val() || null,
			    			    limit: null
			    		    },
			    		    page: { curr: 1  }
						});
			    	} // else
			    } else if (event === 'multiDelete') {
			    	if (ids.length === 0) {
			    		return;
			    	} else {
			    		layer.confirm('确认删除？', {
			    			success: function(layero, index){
								// 点击esc关闭弹出层
							    this.esc = function(event){
							      if(event.keyCode === 27){
							        layer.close(index);
							        return false; //阻止系统默认回车事件
							      }
							    };
							    $(document).on('keydown', this.esc); //监听键盘事件，关闭层
						    },
						    end: function(){
						      $(document).off('keydown', this.esc);	//解除键盘关闭事件
						    }
			    		}, function(index) {
			    			table.reload('classList', {
								url: '${pageContext.request.contextPath}/classes/delClass.action',
				    		    where: { ids: ids },
				    		    page: { curr: 1  }
							});
			    			layer.msg('删除成功！');
						  	$('.layui-table-body').css('display', 'none'); // 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
							setTimeout(function() {
								location.reload();
							}, 500)
			    		})
					}
			    } else if(event === 'add') {
			    	var index = layer.prompt({
			  			formType: 0,
						title : '请添加班级名称：',
						shadeClose: true,
						area : [ '800px', '350px' ],
						success: function(layero) {
							// 点击esc关闭弹出层
						    this.esc = function(event){
						      if(event.keyCode === 27){
						        layer.close(index);
						        return false; //阻止系统默认回车事件
						      }
						    };
						    $(document).on('keydown', this.esc); //监听键盘事件，关闭层
						},
						end: function() {
							$(document).off('keydown', this.esc);	//解除键盘关闭事件
						}
					}, function( value, index, elem) {
							$.ajax({
								url: '${pageContext.request.contextPath}/classes/addClass.action',
								// 添加一个id=0，配合查询语句
								data: { id: 0, className: value },
								method: 'post',
								success: function(data) {
									if (data == 0) {
										alert("班级已存在！")
									} else {
										layer.msg('添加成功！');
									  	$('.layui-table-body').css('display', 'none'); // 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
										setTimeout(function() {
											location.reload();
										}, 500)
									}
								}
							})
						} // function
					); //layer.prompt
			    }
			}); // table.on
			
			// 行内工具栏事件
			table.on('tool(test)', function(obj){ // test是table原始容器的属性 lay-filter="对应的值"
				  var data = obj.data; // 获得当前行数据
				  var event = obj.event; // 获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				  if (event === 'del') {
					  layer.confirm('确认删除？', {
						  success: function(layero, index){
								// 点击esc关闭弹出层
							    this.esc = function(event){
							      if(event.keyCode === 27){
							        layer.close(index);
							        return false; //阻止系统默认回车事件
							      }
							    };
							    $(document).on('keydown', this.esc); //监听键盘事件，关闭层
						    },
						    end: function(){
						      $(document).off('keydown', this.esc);	//解除键盘关闭事件
						    }
					    },
					    function(index){
						  table.reload('classList', {
								url : '${pageContext.request.contextPath}/classes/delClass.action',
								where : { id: data.id }
							});
						  	layer.msg('删除成功！');
						  	$('.layui-table-body').css('display', 'none'); // 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
							setTimeout(function() {
								location.reload();
							}, 500)
				    	});
				  	} else if (event === 'update') {
				  		var index = layer.prompt({
					  			formType: 0,
								value : data.className,
								title : '请编辑：',
								shadeClose: true,
								area : [ '800px', '350px' ],
						  		success: function(layero) {
									// 点击esc关闭弹出层
								    this.esc = function(event){
								      if(event.keyCode === 27){
								        layer.close(index);
								        return false; //阻止系统默认回车事件
								      }
								    };
								    $(document).on('keydown', this.esc); //监听键盘事件，关闭层
								},
								end: function() { 
									$(document).off('keydown', this.esc);	//解除键盘关闭事件
								}
							}, function( value, index, elem) {
									// 当你想返回0时，最好用ajax请求，因为使用table。reload时，会因为返回数据的格式不对而使得表格显示返回值异常
									$.ajax({
										url: '${pageContext.request.contextPath}/classes/updateClass.action',
										data: {
											id : data.id,
											className : value
										},
										method: 'post',
										success: function(data) {
											if (data == 0) {
												alert("班级已存在！")
											} else {
												layer.msg('更新成功！');
											  	$('.layui-table-body').css('display', 'none'); // 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
												setTimeout(function() {
													location.reload();
												}, 500)
											}
										} // success
									}) // ajax
								} // function
							); // layer.prompt
				  	}
			}); // table.on
			
			var ids = '';
			// 复选框事件
			table.on('checkbox(test)', function(obj){ 
				var checkStatus = table.checkStatus('classList'); // 获取所有选中行的相关信息
				var data = checkStatus.data;
				ids = '';
				data.forEach(function(item) {
					ids += item.id + ',';
				})
			});
			
		}) // layui.use
	</script>
</body>
</html>