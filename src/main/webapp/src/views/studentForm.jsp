<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加学生</title>
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
	.layui-input.layui-unselect{
		/* color: grey; */
	}
	/* input::placeholder {
		color: black;
	} */
	label.layui-form-label {
		
	}
</style>
</head>
<body>
	<form class="layui-form" lay-filter="formTest" method="post" enctype="multipart/form-data">
	  <div class="layui-form-item">
	    <label class="layui-form-label">姓名</label>
	    <div class="layui-input-inline">
	      <input type="text" name="name" placeholder="请输入姓名" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">状态</label>
	    <div class="layui-input-inline">
	      <input type="radio" name="status" value="1" title="在学" checked>
	      <input type="radio" name="status" value="2" title="休学">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">性别</label>
	    <div class="layui-input-inline">
	      <input type="radio" name="sex" value="2" title="男" checked>
	      <input type="radio" name="sex" value="1" title="女">
	    </div>
	  </div>
	  <div class="layui-form-item">
	  	<label class="layui-form-label">班级</label>
		<div class="layui-input-inline">
		  <select name="className" id="className">
		    <option value="">请选择班级</option>
		  </select>
		</div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">选择地区</label>
	    <div class="layui-input-inline">
	      <select name="pid" lay-verify="required" id="pid" lay-filter="selPro">
	        <option value="">选择所在省份</option>
	      </select>
	    </div>
	    <div class="layui-input-inline">
	      <select name="cid" lay-verify="required" id="cid"  lay-filter="selCity">
	        <option value="">选择所在城市</option>
	      </select>
	    </div>
	    <div class="layui-input-inline">
	      <select name="aid" lay-verify="required" id="aid"  lay-filter="selArea">
	        <option value="">选择所在区域</option>
	      </select>
	    </div>
	  </div>
	  <div class="layui-form-item layui-upload">
	  	<label class="layui-form-label">上传头像</label>
		<button type="button" class="layui-btn layui-input-inline" id="selectImg"><i class="layui-icon">&#xe67c;</i>选择图片</button>
		<button type="button" class="layui-btn layui-input-inline" id="upload"><i class="layui-icon">&#xe67c;</i>点击上传</button>
	  </div>
	  <div class="layui-upload-list layui-form-item">
	  	  <label class="layui-form-label"> </label>
		  <img class="layui-upload-img" id="preview">
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
		layui.use(['form', 'jquery'], function(){
		  	var form = layui.form, $ = layui.$;
		    // 当进入页面就开始获取省份列表
			function getProvince() {
				$.ajax({
					url: "${pageContext.request.contextPath}/students/getProvince.action",
					data: {},
					type: 'post',
					success: function(data) {
						var html = '';
						for (var i = 0; i < data.data.length; i++) {
							html += "<option value='" 
								+ data.data[i].id
								+ "'>" + data.data[i].name 
								+ "</option>";
						}
						$('#pid').append(html);
						form.render('select') // 数据为动态渲染的时候，需要重新渲染
					}
				})
			}
			getProvince()
			
			// 获取城市列表
			form.on('select(selPro)', function(data){
				$('#cid').html('<option value="" selected>选择所在城市</option>')
				$('#aid').html('<option value="" selected>选择所在区域</option>')
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
				$('#aid').html('<option value="">选择所在区域</option>')
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
							html += '<option value="' + item.id + '">' + item.className + '</option>';
						})
						$('#className').append(html);
						form.render('select');
					}
				})
			}
			getClassNameList()
			
		});
	</script>
</body>
</html>