<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生详情页</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<style>
	.layui-form {
		margin: 10px;
		margin-right: 20px;
	}
	.layui-upload-img {
		width: 30%;
	}
	#preview {
		display: none;
	}
</style>
</head>
<body>
	<form class="layui-form" lay-filter="formTest" method="post" enctype="multipart/form-data">
	  <div class="layui-form-item">
	    <label class="layui-form-label">姓名</label>
	    <div class="layui-input-inline">
	      <input type="text" name="name" value="${student.name}"placeholder="请输入姓名" autocomplete="off" class="layui-input" lay-verify="required">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">状态</label>
	    <div class="layui-input-inline">
	      <input type="radio" name="status" value="1" title="在学" ${student.status == 1 ? 'checked' : ''}>
	      <input type="radio" name="status" value="2" title="休学" ${student.status == 2 ? 'checked' : ''}>
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">性别</label>
	    <div class="layui-input-inline">
	      <input type="radio" name="sex" value="2" title="男" ${student.sex == 2 ? 'checked' : ''}>
	      <input type="radio" name="sex" value="1" title="女" ${student.sex == 1 ? 'checked' : ''}>
	    </div>
	  </div>
	  <div class="layui-form-item">
	  	<label class="layui-form-label">班级</label>
		<div class="layui-input-inline">
		  <select name="classId" id="classId" lay-verify="required">
		    <option value="">请选择班级</option>
		  </select>
		</div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">选择地区</label>
	    <div class="layui-input-inline">
	      <select name="pid" id="pid" lay-filter="selPro">
	        <option value="">选择所在省份</option>
	      </select>
	    </div>
	    <div class="layui-input-inline">
	      <select name="cid" id="cid"  lay-filter="selCity">
	        <option value="">选择所在城市</option>
	      </select>
	    </div>
	    <div class="layui-input-inline">
	      <select name="aid" id="aid"  lay-filter="selArea">
	        <option value="">选择所在区域</option>
	      </select>
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">详细地址</label>
	    <div class="layui-input-inline">
	      <input type="text" name="detailed" value="${student.detailed}" placeholder="请输入详细地址" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item layui-upload">
	  	<label class="layui-form-label">上传头像</label>
		<button type="button" class="layui-btn layui-input-inline" id="selectImg"><i class="layui-icon">&#xe67c;</i>选择图片</button>
		<button type="button" class="layui-btn layui-input-inline" id="upload"><i class="layui-icon">&#xe67c;</i>点击上传</button>
	  </div>
	  <div class="layui-upload-list layui-form-item">
	  	  <label class="layui-form-label"> </label>
		  <img class="layui-upload-img" id="preview" src="${pageContext.request.contextPath}/${student.img}">
	  </div>
	  <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" lay-submit lay-filter="submit" id="submit">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	  </div>
	</form>
	
	<script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
	
	<script>
		var pid = "${student.pid}";
		var cid = "${student.cid}";
		var aid = "${student.aid}";
		var idOfClass = "${student.classId}";
		var address = '${pageContext.request.contextPath}/${student.img}';
		
		layui.use(['form', 'jquery', 'upload', 'layer'], function(){
		  	var form = layui.form, $ = layui.$, upload = layui.upload, layer = layui.layer;
		  	if (address == '/SchoolProject/') {
				// 当用户之前未上传头像时，不设置display：none时，会显示一个地址错误的图片，因此将其设置为不显示
				$('#preview').css('display', 'none')
			} else {
				$('#preview').css('display', 'block');
			}
		    // 当进入页面就开始获取省份列表
			function getProvince() {
				$.ajax({
					url: "${pageContext.request.contextPath}/students/getProvince.action",
					data: {},
					type: 'post',
					success: function(data) {
						var data = data.data;
						var html = '';
						data.forEach(function(item, index) {
							html += '<option value="' + item.id + '"' 
								+  (pid == item.id ? ' selected>' : '>')
								+ item.name + '</option>';
						});
						$('#pid').append(html);
						form.render('select')
						
						if (pid) {
							$.ajax({
								url: '${pageContext.request.contextPath}/students/getCity.action',
								data: { pid: pid },
								type: 'get',
								success: function(data) {
									var data = data.data;
									var html = '';
									data.forEach(function(item, index) {
										html += '<option value="' + item.id + '"'
											+ (cid == item.id ? ' selected>' : '>')
											+ item.name + '</option>';
									});
									$('#cid').append(html);
									form.render('select')
									
									if (cid) {
										$.ajax({
											url: '${pageContext.request.contextPath}/students/getArea.action',
											data: { cid: cid },
											type: 'get',
											success: function(data) {
												var data = data.data;
												var html = '';
												data.forEach(function(item, index) {
													html += '<option value="' + item.id + '"'
														+ (aid == item.id ? ' selected>' : '>')
														+ item.name + '</option>';
												});
												$('#aid').append(html);
												form.render('select')
											} // success
										}) // ajax
									} // if(cid)
								} // success
							}) // ajax
						} // if(pid)
					} // success
				}) // ajax
			}
			getProvince()
			
			// 获取城市列表
			form.on('select(selPro)', function(data){
				$('#cid').html('')
				$('#cid').append('<option value="">选择所在城市</option>')
				$('#aid').html('')
				$('#aid').append('<option value="">选择所在区域</option>')
				form.render('select') // 清空后要刷新
				var pid = data.value;
				if (!pid) return;
				else {
					$.ajax({
						url: "${pageContext.request.contextPath}/students/getCity.action",
						data: { pid: pid },
						type: 'post',
						success: function(data) {
							var html = '';
							for (var i = 0; i < data.data.length; i++) {
								html += "<option value='" 
									+ data.data[i].id
									+ "'>" + data.data[i].name 
									+ "</option>";
							}
							$('#cid').append(html);
							form.render('select') // 数据为动态渲染的时候，需要重新渲染
						}
					})
				}
			});
			  
			// 获取区域列表
			form.on('select(selCity)', function(data){
				$('#aid').html('')
				$('#aid').append('<option value="">选择所在区域</option>')
				form.render('select')
				var cid = data.value;
				if (!cid) return;
				else {
					$.ajax({
						url: "${pageContext.request.contextPath}/students/getArea.action",
						data: { cid: cid },
						type: 'post',
						success: function(data) {
							var html = '';
							for (var i = 0; i < data.data.length; i++) {
								html += "<option value='" 
									+ data.data[i].id
									+ "'>" + data.data[i].name 
									+ "</option>";
							}
							$('#aid').append(html);
							form.render('select') // 数据为动态渲染的时候，需要重新渲染
						}
					})  
				}
			});
			
			
			// 动态渲染下拉框
			function getClassNameList() {
				$.ajax({
					url: '${pageContext.request.contextPath}/classes/selClass.action',
					method: 'get',
					success: function(data) {
						var data = data.data;
						var html = '';
						data.forEach(function(item) {
							html += '<option value="' + item.id + '"' + 
								(idOfClass == item.id ? 'selected' : '') + 
								'>' + item.className + '</option>';
						})
						$('#classId').append(html);
						form.render('select');
					}
				})
			}
			getClassNameList()
			
			var imagePath = "";
			// 上传图片
			upload.render({
			  elem: '#selectImg' //绑定元素
			  ,url: '${pageContext.request.contextPath}/UploadController/upload.action' //上传接口
			  ,accept: 'images'
			  ,exts: 'jpg|png|jpeg'
			  ,auto: false
			  ,bindAction: '#upload'
			  ,choose: function(obj) {
			  	  // 显示预览，此时尚未上传
			      obj.preview(function(index, file, result){
			        $('#preview').attr('src', result).css('display', 'block'); //图片链接（base64）
			      });
			  }
			  ,done: function(res){
			  	imagePath = res.data[0];
			  	console.log("上传图片成功！")
			  }
			  ,error: function(){ console.log('图片上传失败！') }
			});
			
			// 监听提交
			form.on('submit(submit)', function(data){
			  data.field.id = ${student.id};
			  data.field.img = "${student.img}";
			  if (imagePath) {
				  data.field.img =  imagePath;
			  }
			  console.log("添加admin上传数据：", data.field) 
			  console.log(data.field)
			  $.ajax({
					url: "${pageContext.request.contextPath}/students/updateStudent.action",
					data: data.field,
					type: 'post',
					success: function(data) {
						layer.msg('提交成功！');
						setTimeout(function() {
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭   
							parent.location.reload();
						}, 1000)
					},
					error: function(err) { 
						console.log("error: ", err);
						layer.msg('提交失败！');
					}
				})
			  return false;
			});
			
		});
	</script>
</body>
</html>