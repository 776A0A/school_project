<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<title>学校数据管理后台</title>
</head>
<body class="layui-layout-body" layadmin-themealias="default">
  

    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <!-- 头部区域 -->
        <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layadmin-flexible" lay-unselect="">
            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect="">
            <a href="http://www.layui.com/admin/" target="_blank" title="前台">
              <i class="layui-icon layui-icon-website"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect="">
            <a href="javascript:;" layadmin-event="refresh" title="刷新">
              <i class="layui-icon layui-icon-refresh-3"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect="">
            <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords="> 
          </li>
       	  <span class="layui-nav-bar" style="left: 198px; top: 48px; width: 0px; opacity: 0;"></span>
        </ul>
        
      </div>
      
      <!-- 侧边菜单 -->
      <div class="layui-side layui-side-menu">
        <div class="layui-side-scroll">
          <div class="layui-logo">
            <span>学校数据管理后台</span>
          </div>
          
          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
            <li data-name="home" class="layui-nav-item layui-nav-itemed">
              <a href="javascript:;" lay-tips="主页" lay-direction="2">
                <i class="layui-icon layui-icon-home"></i>
                <cite>主页</cite>
              	<span class="layui-nav-more"></span>
              </a>
              
              <dl class="layui-nav-child">
                <dd data-name="console" class="layui-this">
                  <a href="javascript:;" data-url="src/views/students.jsp" data-title="学生信息管理">学生信息管理</a>
                </dd>
                <dd data-name="console">
                  <a href="javascript:;" data-url="src/views/results.jsp" data-title="学生成绩管理">学生成绩管理</a>
                </dd>
                <dd data-name="console">
                  <a href="javascript:;" data-url="src/views/classes.jsp" data-title="班级管理">班级管理</a>
                </dd>
              </dl>
              
            </li>
          <span class="layui-nav-bar" style="top: 382px; height: 0px; opacity: 0;"></span></ul>
        </div>
      </div>     
      
      <!-- 主体内容 -->
      <div class="layui-body">
      	<div class="layui-tab" lay-filter="tabs" lay-allowClose="true">	
      		<ul class="layui-tab-title">
                <li class="layui-this"></li>
            </ul>
      		<div class="layui-tab-content"><div class="layui-tab-item layui-show"></div></div>
      	</div>
      </div>
      
      <!-- 辅助元素，一般用于移动设备下遮罩 -->
      <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>


  <script src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
  <script>
  	layui.use('element', function(){
      var element = layui.element;
      element.on('nav(layadmin-system-side-menu)',function(elem){
    	  var title = elem.context.dataset.title;
          var url = elem.context.dataset.url;
          if (!url) {
        	  return;
          } else {
	          var locationHref = location.href;
	          element.tabAdd('tabs',{
	        	  title: title,
	              content : '<iframe scrolling="auto" frameborder="0"  src="'+ locationHref + url +'" style="width:100%;height:100vh;"></iframe>',
	              id : '0'
	          });
          }
      });
  	})
  </script>
  <style id="LAY_layadmin_theme">.layui-side-menu,.layadmin-pagetabs .layui-tab-title li:after,.layadmin-pagetabs .layui-tab-title li.layui-this:after,.layui-layer-admin .layui-layer-title,.layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child{background-color:#20222A !important;}.layui-nav-tree .layui-this,.layui-nav-tree .layui-this>a,.layui-nav-tree .layui-nav-child dd.layui-this,.layui-nav-tree .layui-nav-child dd.layui-this a{background-color:#009688 !important;}.layui-layout-admin .layui-logo{background-color:#20222A !important;}</style>
</body>
</html>