<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生成绩</title>
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
	input::placeholder {
		color: black;
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
	      <input type="number" name="chinese" value="${results.chinese}" placeholder="请输入成绩" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">英语</label>
	    <div class="layui-input-inline">
	      <input type="number" name="english" value="${results.english}" placeholder="请输入成绩" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">数学</label>
	    <div class="layui-input-inline">
	      <input type="number" name="math" value="${results.math}" placeholder="请输入成绩" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">总分</label>
	    <div class="layui-input-inline">
	      <input type="number" name="total" placeholder="" autocomplete="off" class="layui-input" disabled id="total">
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
		var total = ${results.chinese + results.english + results.math}
		layui.use(['form', 'jquery'], function(){
		  	var form = layui.form, $ = layui.$;
		  	$('#total').val(total)
		  	
		  	/* 根据分数的变化动态改变总分
		  	window.addEventListener("input", function(e) {
				var total = document.querySelector('#total').value;
				var res = 80 - e.target.value;
				if (res > 0) {
					$('#total').val((total - res));
				} else {
					$('#total').val((total + res));
				} 
				console.log(res)
			}) */
		});
		
		
	</script>
</body>
</html>