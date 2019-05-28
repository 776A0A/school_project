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
		<div class="layui-input-inline">
	      <select name="className" id="className" lay-search>
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
  		<a class="layui-btn layui-btn-xs" lay-event="update">编辑</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
	
	<script type="text/javascript">
		layui.use(['table', 'jquery', 'layer', 'form'], function() {
			var table = layui.table, $ = layui.jquery, layer = layui.layer, form = layui.form;
			table.render({
				elem: '#resultsList',
				url: '${pageContext.request.contextPath}/results/selResultsMap.action',
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
						field : 'studentName',
						title : '学生',
						sort : true,
						align: 'center',
					},
					{
						field: 'chinese',
						title: '语文',
						sort : true,
						align: 'center'
					},
					{
						field: 'english',
						title: '英语',
						sort : true,
						align: 'center'
					},
					{
						field: 'math',
						title: '数学',
						sort : true,
						align: 'center'
					},
					{
						field: 'total',
						title: '总分',
						sort : true,
						align: 'center',
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
			    	if ($('#className').val() == '' && 
		    			$('#stuId').val() == '' && 
		    			$('#studentName').val() == '') {
			    		// 未输入任何值点击搜索按钮时，刷新页面，因为如果之前进行过搜索，那么limit为null，刷新以重置limit值
			    		location.reload()
			    	} else {
				    	table.reload('resultsList', {
							url : '${pageContext.request.contextPath}/results/selResultsMap.action',
							where : {
								classId: $('#className').val() || 0,
								stuId: $('#stuId').val() || 0,
								studentName: $('#studentName').val() || null,
								limit: null
							}
						});
				    	getClassNameList()
			    	}
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
			    			table.reload('resultsList', {
								url: '${pageContext.request.contextPath}/results/delResults.action',
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
			    } else if (event === 'add') {
			    	// 弹出层
					layer.open({
						type: 2, 
						content: '${pageContext.request.contextPath}/src/views/addResults.jsp',
						area: ['40%', '80%'],
						shadeClose: true,
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
					}); 
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
			    		}, function(index){
						  table.reload('resultsList', {
								url : '${pageContext.request.contextPath}/results/delResults.action',
								where : { id: data.id }
							});
						  	layer.msg('删除成功！');
						  	$('.layui-table-body').css('display', 'none'); // 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
							setTimeout(function() {
								location.reload();
							}, 500)
				    	});
				  	} else if (event === 'update') {
				  		layer.open({
							type: 2, 
							title: '学生成绩',
							content: '${pageContext.request.contextPath}/students/editResults.action?stuId=' + data.stuId,
							area: ['40%', '60%'],
							shadeClose: true,
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
				var checkStatus = table.checkStatus('resultsList'); // 获取所有选中行的相关信息
				var data = checkStatus.data;
				ids = '';
				data.forEach(function(item) {
					ids += item.id + ',';
				})
			});
		})
	</script>
</body>
</html>