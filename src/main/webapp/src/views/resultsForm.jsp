<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加学生成绩</title>
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
	label.layui-form-label {
		
	}
</style>
</head>
<body>
	<form class="layui-form" lay-filter="formTest" method="post" enctype="multipart/form-data">
	  <div class="layui-form-item">
	    <label class="layui-form-label">语文</label>
	    <div class="layui-input-inline">
	      <input type="number" name="chinese" placeholder="请输入成绩" autocomplete="off" class="layui-input" lay-verify="required">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">英语</label>
	    <div class="layui-input-inline">
	      <input type="number" name="english" placeholder="请输入成绩" autocomplete="off" class="layui-input" lay-verify="required">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">数学</label>
	    <div class="layui-input-inline">
	      <input type="number" name="math" placeholder="请输入成绩" autocomplete="off" class="layui-input" lay-verify="required">
	    </div>
	  </div>
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
		  	console.log(window.top.myData)
			// 监听提交
			form.on('submit(submit)', function(data){
				data.field.stuId = window.top.myData.id;
				data.field.classId = window.top.myData.classId;
				console.log("添加admin上传数据：", data.field) //当前容器的全部表单字段，名值对形式：{name: value}
				$.ajax({
					url: "${pageContext.request.contextPath}/results/addResults.action",
					data: data.field,
					type: 'post',
					success: function(data) {
						layer.msg('添加成功！');
						setTimeout(function() {
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭   
							parent.location.reload();
						}, 1000)
					},
					error: function(err) { console.log("error: ", err); }
				}) 
				return false;
			});
		});
	</script>
</body>
</html>