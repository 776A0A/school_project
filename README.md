### school_project
---
- 关于*文件命名* 问题：跟一个页面相关的其他页面，使用关联名称命名，例如student页面，那么相应的编辑和添加页面应该为studentEdit、studentAdd。这样，在页面很多时就能快速定位相关页面。
- *一些文件的意思*：最外层的`pom.xml`文件中配置需要的依赖、插件以及jar包等。  
`web.xml`中配置入口页、监听器、Spring容器加载配置文件的路径等等。  
`resources`文件夹下的五个文件是ssm中最重要的配置文件。
- *目录结构及各种文件*：`views`文件夹在主要是项目的jsp文件，相当于html，在其中使用Java语句，另外使用layui需要引入js和css文件。
```html
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/src/layuiadmin/layui/css/layui.css"
	media="all">
<script 
    src="${pageContext.request.contextPath}/src/layuiadmin/layui/layui.js"></script>
```
在`java`文件夹下创建几个package，一般为反着写的域名，`controller`、`mapper`、`mapping`、`service`、`serviceImp`、`model`。 

`controller`中是控制器，书写前端请求后的逻辑处理问题，`mapper`主要是`mapping`中写的MySQL语句的接口，`mapping`中语句的`id`即为`mapper`中的方法名。  
`service`中主要是`serviceImp`的接口，`serviceImp`中是通过操控`mapper`来控制MySQL语句。  
`model`负责实体类。
- *layui规定的返回数据格式*：
```java
public class DataGridView {
	private Integer	code = 0;
	private String msg = "";
	private Integer count;
	private List<Object> data;
}
```
- 除了查询操作，其他操作都可以不用返回值，前端可以直接刷新页面。

---

- [一些layui的小问题](#layui)
- [其他零碎处理](#其他零碎处理)
- [分页问题](#分页问题)
- [动态渲染下拉框数据并赋值](#动态渲染下拉框数据并赋值)
- [三级联动查询](#三级联动查询)
- [重名问题](#重名问题)
- [在非首页中搜索时出现问题](#在非首页中搜索时出现问题)
- [无成绩时的处理](#无成绩时的处理)
- [学生姓名和班级的联动](#学生姓名和班级的联动)
- [复选框批量删除](#复选框批量删除)
- [图片上传](#图片上传)
- [在后台处理时间格式](#在后台处理时间格式)

---

#### layui
`table`中一些头部写法：
- 头像：
```javascript
templet: function(data) {
	if (!data.img) { // 用户未上传头像时
		return '<img src="">';
	} else {
    	return '<img src="${pageContext.request.contextPath}/' + data.img + '">';
	}
},
```
- 状态切换：
```javascript
templet: function(data) {
    return '<input type="checkbox"' 
    		+ (data.status == 1? 'checked' : '') 
    		+ ' id=' + data.id
    		+ ' lay-filter="switchTest" lay-skin="switch" lay-text="在学|休学">';
},
```
```javascript
// 监听switch切换时传回的数据
var elem = data.elem;
var data = {
	status: elem.checked ? 1 : 2,
	id: elem.id
}
```
- 地址的拼接：
```javascript
templet: function(data) {
	return (data.pName || '') + (data.cName || '') + (data.aName || '') + (data.detailed || '');
},
```

---

#### 其他零碎处理
- 操作成功提示并刷新页面：
```
success: function(data) {
    layer.msg('添加成功！');
    setTimeout(function() {
    	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    	parent.layer.close(index); //再执行关闭   
    	parent.location.reload();
    }, 1000)
},
```
- 编辑页面中，当用户未上传图片时
```javascript
var address = '${pageContext.request.contextPath}/${student.img}';
if (address == '/SchoolProject/') {
	// 当用户之前未上传头像时，不设置display：none时，会显示一个地址错误的图片，因此将其设置为不显示
	$('#preview').css('display', 'none')
} else {
	$('#preview').css('display', 'block');
}
```
- 点击esc退出弹框：
```javascript
// layer.confirm时
layer.confirm('确认删除？', {
	success: function(layero, index){
	    this.esc = function(event){
	      if(event.keyCode === 27){
	        layer.close(index);
	        return false; // 阻止系统默认回车事件
	      }
	    };
	    $(document).on('keydown', this.esc); // 监听键盘事件，关闭层
    },
    end: function(){
      $(document).off('keydown', this.esc);	// 解除键盘关闭事件
    }},
    function(index) { // do something... }
)
```
```javascript
// layer.prompt时
var index = layer.prompt({
  			formType: 0, title : '请添加班级名称：', shadeClose: true, area : [ '800px', '350px' ],
			success: function(layero) {
			    this.esc = function(event){
			      if(event.keyCode === 27){
			        layer.close(index);
			        return false; // 阻止系统默认回车事件
			      }
			    };
			    $(document).on('keydown', this.esc); // 监听键盘事件，关闭层
			},
			end: function() {
				$(document).off('keydown', this.esc);	// 解除键盘关闭事件
			}
		}, function( value, index, elem) { // do something... }
	)
```
```javascript
// layer.open时
layer.open({
    type: 2,  area: ['100%', '100%'], shadeClose: true,
    content: '${pageContext.request.contextPath}/src/views/studentForm.jsp',
    success: function(layero, index){
        this.esc = function(event){
          if(event.keyCode === 27){
            layer.close(index);
            return false; // 阻止系统默认回车事件
          }
        };
        $(document).on('keydown', this.esc); // 监听键盘事件，关闭层
    },
    end: function(){
      $(document).off('keydown', this.esc);	// 解除键盘关闭事件
    }
}); 
```
---

#### 分页问题
分页功能的逻辑是，前端需要传回`page`页码和`limit`每页数据数量，后端中的实体类中含有属性`page`和`limit`接收前端传回的数据。但是在接收前要做一些处理：
```java
实体类.setPage((实体类.getPage()-1) * 实体类.getLimit());
```
另外，最后在实体类中为`page`和`limit`设置默认值，因为在有些情况下并不会传回`page`和`limit`，但此时sql语句却不会改变，就会出现bug。  
可以写一个单独的实体类包装page和limit属性，也可以在各个实体类中都创建`page`和`imit`。前者的情况下，需要将其包装为`Map<String, Object>`，而后者则可以省略这一部，因为包装为`Map`是有点麻烦的，并且容易出现bug。  
最后，前端需要知道总的数据数，就要返回`count`，所以在返回的数据中就要设置`count`。  
使用`Map`的代码：
```xml
<select id="selStudentsMap" parameterType="Map" resultType="Students">
	select student.*, classes.className as className, 
		   province.name as pName, city.name as cName, area.name as aName
		from student
		left join classes on classId = classes.id
		left join province on student.pid = province.id
		left join city on student.cid = city.id
		left join area on student.aid = area.id
 	<where>
		<if test="students.classId != 0 and students.classId != null">
			and student.classId=#{students.classId}
		</if>
		<if test="students.id != 0 and students.id != null">
			and student.id=#{students.id}
		</if>
		<if test="students.name != null and students.name != ''">
			and student.name like concat('%', #{students.name}, '%')
		</if>
	</where>
		order by student.classId, student.id limit #{page.page}, #{page.limit}
</select>
```
`count`中也要带着条件：
```xml
<select id="count" resultType="Integer">
	select count(*) from student
	<where>
		<if test="classId != 0 and classId != null">
			and classId=#{classId}
		</if>
		<if test="id != 0 and id != null">
			and student.id=#{id}
		</if>
		<if test="name != null and name != ''">
			and student.name like concat('%', #{name}, '%')
		</if>
	</where>
</select>
```
Controller：
```java
@RequestMapping("selStudentsMap")
@ResponseBody
public DataGridView selStudentsMap(Students students, PageOV pageOV) {
	List<Object> selStudents;
	if (pageOV.getLimit() != null) {
		// 单纯的表格渲染时用
		pageOV.setPage((pageOV.getPage()-1)*pageOV.getLimit());
		Map<String, Object> map = new HashMap<>();
		map.put("students", students);
		map.put("page", pageOV);
		selStudents = studentsService.selStudentsMap(map);			
	} else {
		// 搜索时用
		selStudents = studentsService.selStudents(students);
	}
	DataGridView dgv = new DataGridView();
	dgv.setData(selStudents);
	dgv.setMsg("查询成功！！");
	dgv.setCount(studentsService.count(students));
	return dgv;
}
```
另外别忘了改`Mapper`等文件中的相关代码。

---

#### 动态渲染下拉框数据并赋值
逻辑为，进入页面以后，通过ajax请求后台数据，返回之后赋值，并动态刷新下拉框。
```javascript
$.ajax({
	url, method: 'get',
	success: function(data) {
		var html = '', data = data.data;
		data.forEach(item => {
			html += '<option value="' + item.id + '">' + item.className + '</option>';
		})
		$('#className').append(html);
		form.render('select');
	}
})
```
通常情况下，只要将数据赋值刷新就好，但有时的需求是编辑已有数据，那么通常是将`id`等唯一标识符传回用于查询，再将数据渲染。
```javascript
layer.open({
	type: 2, area: ['100%', '100%'], shadeClose: true,
	content: '${pageContext.request.contextPath}/students/editStudent.action?id=' + data.id,
	success(layero, index){ // layer弹框成功
		// 点击esc关闭弹出层
	    this.esc = function(event){
	      if(event.keyCode === 27){
	        layer.close(index);
	        return false; // 阻止系统默认回车事件
	      }
	    };
	    $(document).on('keydown', this.esc); //监听键盘事件，关闭层
    },
    // layer弹框关闭时
    end: function(){ $(document).off('keydown', this.esc);	// 解除键盘关闭事件 }
});
```
此时的逻辑是，传回`id`，再返回一个页面，页面中使用El表达式渲染返回的数据。所以现在要增加两个页面，一个为添加，一个为编辑，编辑中有渲染数据。
```java
@RequestMapping("editStudent")
public String editStudent(Students students, Model model) {
	List<Object> selStudents = studentsService.selStudents(students);
	model.addAttribute("student", selStudents.get(0));
	return "editStudent"; // 返回字符串会根据springmvc.xml中的配置自动添加前后缀
}
```
编辑页面：
```xml
<input type="radio" name="sex" value="2" title="男" ${student.sex == 2 ? 'checked' : ''}>
<img class="layui-upload-img" id="preview" src="${pageContext.request.contextPath}/${student.img}">
```
需要注意的是三级联动的赋值，如果存在最上级`pid`，则对应的项就要添加上`selected`，同时因为`pid`存在，就确定了城市列表，以此类推。
```javascript
function getProvince() {
	$.ajax({
		url: "${pageContext.request.contextPath}/students/getProvince.action",
		type: 'get',
		success(data) {
			var html = '', data = data.data;
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
					data: { pid: pid }, type: 'get',
					success: function(data) {
						var html = '', data = data.data;
						data.forEach(function(item, index) {
							html += '<option value="' + item.id + '"'
								+ (cid == item.id ? ' selected>' : '>')
								+ item.name + '</option>';
						});
						$('#cid').append(html);
						form.render('select')
						
						if (cid) {
							$.ajax({
								// do something...
							}) // ajax
						} // if(cid)
					} // success
				}) // ajax
			} // if(pid)
		} // success
	}) // ajax
}
getProvince()
```
---

#### 三级联动查询
联动的最上级列表是无条件渲染的，其他要根据所选值动态请求数据。  
另外，只要上级列表被点击了，就要重新渲染下一级列表，用户可能点击的是同一个选项，可加一个判断，但这里我没有做。
```javascript
form.on('select(selPro)', function(data){
	$('#cid').html('').append('<option value="">选择所在城市</option>')
	$('#aid').html('').append('<option value="">选择所在区域</option>')
	form.render('select') // 清空后要刷新
	var pid = data.value;
	if (!pid) { return; } // 这里用户点击的是提示文字
	else {
		$.ajax({
			url: "${pageContext.request.contextPath}/students/getCity.action",
			data: { pid: pid }, type: 'post',
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
```
查询语句十分简单，最上级列表永远都是全部渲染，下级列表需要传入上级`id`。  
当然，还有实体类：
```java
public class PCAList {
	private int id;
	private String name;
	private int pid;
	private int cid;
	private int aid;
}
```
---

#### 重名问题

主要思路就是前端提交数据到后台，后台拿到用户名搜索数据库，存在就返回`0`，不进行其他操作，不存在就执行添加或更新。先看语句：
```xml
<select id="existClassName" resultType="Classes">
	select * from classes where className=#{className} and id!=#{id}
</select>
```
需要注意的就是最后的`id!=#{id}`，当用户是在编辑时，`id`会自动传回，但如果是添加新用户的话，`id`其实是没有的，那么前端就要传回一个`id`，我这里将`id = 0`。  
然后就是根据返回值提醒用户是否为合法用户名。  
另外需要注意的是，因为layui对返回值的格式有要求，如果不是所要求的格式，就会直接在列表里渲染错误提示。所以在这里就不用`table.roload()`，而是使用`ajax`。
```javascript
$.ajax({
	url: '${pageContext.request.contextPath}/classes/updateClass.action',
	data: { id : data.id || 0, className : value }, method: 'post',
	success: function(data) {
		if (data == 0) { alert("班级已存在！") } 
		else {
			layer.msg('更新成功！');
			setTimeout(function() {
				location.reload();
			}, 500)
		}
	} // success
}) // ajax
```
无论是update还是add都要检测是否重名：
```java
List<Object> exist = classService.existClassName(classes);
if (exist.size() > 0) {
	return 0;
} else {
	classService.updateClass(classes);
	return 200;
}
```

---

#### 在非首页中搜索时出现问题
因为正常情况下请求数据是带有`page`和`limit`，所以在搜索时就会出现问题。我这里的解决方法是，搜索时将`limit`设置为`null`，然后在后端检测`limit`是否为`null`，如果是，就使用未带`page`和`limit`的搜索。这么搜索的结果就是会返回所有符合条件的数据，而没有分页。所以还需要在页面中对`ui`进行处理，虽然我这里并没有处理。  
另外，在用户直接点击搜索而不附加任何条件时，需要刷新页面，如果不刷新，那么`limit`的值就一直是`null`。
```javascript
table.on('toolbar(test)', function(obj){
    var event = obj.event;
    if (event === 'search') {
    	if ($('#className').val() == '' && 
    		$('#stuId').val() == '' && 
    		$('#studentName').val() == '') {
    		location.reload()
    	} else {
        	table.reload('studentsList', {
    			url : '${pageContext.request.contextPath}/students/selStudentsMap.action',
    			where : {
    				classId: $('#className').val() || 0,
    				id: $('#stuId').val() || 0,
    				name: $('#studentName').val() || null,
    				limit: null
    			}
    		});
        	getClassNameList() // 搜索后要重新渲染下拉框
    	} // else
    }
})
```
对应后台：
```java
@RequestMapping("selStudentsMap")
@ResponseBody
public DataGridView selStudentsMap(Students students, PageOV pageOV) {
	List<Object> selStudents;
	if (pageOV.getLimit() != null) { // 表格渲染时用
		pageOV.setPage((pageOV.getPage()-1)*pageOV.getLimit());
		Map<String, Object> map = new HashMap<>();
		map.put("students", students);
		map.put("page", pageOV);
		selStudents = studentsService.selStudentsMap(map);			
	} else { // 搜索时用
		selStudents = studentsService.selStudents(students);
	}
	DataGridView dgv = new DataGridView();
	dgv.setData(selStudents);
	dgv.setMsg("查询成功！");
	dgv.setCount(studentsService.count(students));
	return dgv;
}
```
---

#### 无成绩时的处理
写一个页面，专门应对无成绩时的问题，前端传回`stuId`用来查询学生成绩，后台接收到用来查询，检测查询的结果，如果没有数据，则返回无成绩页面。
```java
@RequestMapping("editResults")
public String editResults(Results results, Model model) {
	List<Object> selResults = resultsService.selResults(results);
	if (selResults.size() == 0) {
		return "noResults";
	} else {
		model.addAttribute("results", selResults.get(0));			
		return "editResults";
	}
}
```
---

#### 学生姓名和班级的联动
在增加成绩时，动态渲染学生姓名列表，在渲染时加入自定义属性`data-classId`，用于保存和学生对应的班级`id`，那么在选择了学生姓名后，就能使用此属性动态更新班级列表里相应的`selected`属性。  
在获取的学生姓名列表这样写：
```
html += '<option value="' + item.id +  '" data-classId="' + item.classId + '">' + item.name + '</option>';
```
另一个函数来监听选择：
```
// 监听选择框，根据所选姓名动态更新班级名字
form.on('select(selName)', function(data){
    var studentId = data.value;
    if (!studentId) { // 无值时，说明选的是提示文字，则刷新classList
        $('#classId').html('').append('<option value="">请选择班级</option>')
        getClassNameList()
    } else {
        var classId = data.elem[data.elem.selectedIndex].dataset.classid; // 取得自定义属性的值，即classId
        $('#classId').children().each(function(index, elem) {
            if (elem.value === classId) { // 根据所选姓名刷新班级
              elem.setAttribute('selected', true);
            }
        })
        form.render('select');
    }
})
```
---

#### 复选框批量删除
监听复选框事件，拿到所选`id`，传回后台，后台对传回的所有`id`进行一一处理。
```javascript
var ids = '';
table.on('checkbox(test)', function(obj){  // 复选框事件
	var checkStatus = table.checkStatus('classList'); // 获取所有选中行的相关信息
	var data = checkStatus.data;
	ids = ''; // 重置ids
	data.forEach(function(item) {
		ids += item.id + ',';
	})
});

if (event === 'multiDelete') {
	if (ids.length === 0) { return; } 
	else {
		layer.confirm('确认删除？', function(index) {
			table.reload('classList', {
				url: '${pageContext.request.contextPath}/classes/delClass.action',
    		    where: { ids: ids },
			});
			layer.msg('删除成功！');
		  	// 如果懒得返回数据，则先用这招遮盖一下异常显示，反正要刷新的
		  	// 另外就是通过ajax代替table.roload()
		  	$('.layui-table-body').css('display', 'none'); 
			setTimeout(function() {
				location.reload();
			}, 500)
		})
	}
}
```
---

#### 图片上传
html：
```html
<div class="layui-form-item layui-upload">
  <label class="layui-form-label">上传头像</label>
<button type="button" class="layui-btn layui-input-inline" id="selectImg"><i class="layui-icon">&#xe67c;</i>选择图片</button>
<button type="button" class="layui-btn layui-input-inline" id="upload"><i class="layui-icon">&#xe67c;</i>点击上传</button>
</div>
<div class="layui-upload-list layui-form-item">
    <!--这个空格的label标签是为了在页面中对齐-->
    <label class="layui-form-label"> </label>
  <img class="layui-upload-img" id="preview" src="${pageContext.request.contextPath}/${student.img}">
</div>
```
javascript：
```javascript
var imagePath = ""; // 提交表单时赋值图片路径
upload.render({
    elem: '#selectImg' //绑定元素
    ,url: '${pageContext.request.contextPath}/UploadController/upload.action' //上传接口
    ,accept: 'images', exts: 'jpg|png|jpeg', auto: false, bindAction: '#upload'
    ,choose: function(obj) { // 显示预览，此时尚未上传
        obj.preview(function(index, file, result){
            $('#preview').attr('src', result).css('display', 'block'); //图片链接（base64）
        });
    }
    ,done: function(res){
        imagePath = res.data[0];
        console.log("上传图片成功！")
    }
    ,error: function(){ alert('图片上传失败！') }
});

// 表单中
data.field.img = "${student.img}"; // 如果是添加学生信息页面，这条需要去掉
if (imagePath) {
  data.field.img =  imagePath;
}
```
springmvc.xml配置：
```xml
<!-- SpringMVC上传文件时，需要配置MultipartResolver处理器 -->
<!-- 配置文件上的二进制流解析器 -->
<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
	<!-- 指定文件上传过程中提交的数据库的编码 clob blob 流的编码 -->
	<property name="defaultEncoding" value="UTF-8"></property>
	<!--文件上传的临时目录 -->
	<property name="uploadTempDir" value="/upload"></property>
	<!-- 文件上传的最大值 20M -->
	<!--注意maxUploadSize属性的限制不是针对单个文件，而是所有文件的容量之和-->
	<property name="maxUploadSize" value="21474836480"></property>
</bean> 
```

后台java，单独建立一个Controller：
```java
@Controller
@RequestMapping("UploadController")
public class UploadController {

	@RequestMapping("upload")
	@ResponseBody
    // MultipartFile是spring类型，代表HTML中form data方式上传的文件，包含二进制数据+文件名称
	// @RequestParam中的value是和页面中type="file"的标签的name值相同的，当然这里使用的layui，所以天file就好 
    // session简单说就是服务器和客户端通信的标识，会存储一些用户信息
	public DataGridView upload( @RequestParam(value = "file", 
	                            required = false) MultipartFile file, 
                                HttpSession session) { 
		// 存放路径
		String savePath = "D:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Test_2\\upload";
		// 获取上传到服务器上的文件路径
		String tempPath = session.getServletContext().getRealPath("/temp");
		File file1 = new File(tempPath);
		// 检测有无该目录，无则创建
		if (!file1.exists() && !file1.isDirectory()) {
			System.out.println("文件或目录不存在！");
			file1.mkdir();
		}
		String oldName = file.getOriginalFilename(); // 文件原名称
		String[] split = oldName.split("\\."); // 取后缀名
		System.out.println("split length: " + split.length);
		// 新名字为当前的时间戳+文件原来的后缀名
		String newName = System.currentTimeMillis() + "." + split[1]; 
		// 用以建立一个新目录，格式为年月日，用以分别存放每日的上传文件
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String date = df.format(new Date());
		// 检测存放路径下是否已有当前日期的文件夹
		File file2 = new File(savePath + "/" + date);
		if ( !file2.exists() && !file2.isDirectory()) {
			file2.mkdirs();
		}
		File file3 = new File(savePath + "/" + date, newName);
		try {
			file.transferTo(file3); // 将上传文件写到服务器上指定的文件
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		List<Object> list = new ArrayList<>();
		// 文件相对路径
		list.add("upload/" + date + "/" + newName);
		DataGridView dgv = new DataGridView();
		dgv.setMsg("上传成功！");
		dgv.setData(list); // 返回路径
		return dgv;
	}
}
```
---

### 在学生管理页面添加和编辑成绩
编辑成绩就是把学生`stuId`和相关成绩传回，很简单。主要是添加成绩，添加成绩时要检测该学生是否已有成绩，如果有，提交就相当于编辑成绩，无则添加。而在做添加功能时要拿到相应的学生数据，就要在父级页面设置`window.myData = data;`，主要是为了拿到该学生的`id`。

添加成绩页面提交时`data.field.stuId = window.top.myData.id;`加入数据，拿给后台检查。
```java
@RequestMapping("addResults")
@ResponseBody
public void addResults(Results results) {
	System.out.println("来自addResults："+ results);
	Results results1 = new Results();
	results1.setStuId(results.getStuId());
	List<Object> res = resultsService.selResults(results1);
	if (res.size() == 0) { // 无则添加
		resultsService.addResults(results);			
	} else { // 有则更新
		resultsService.updateResults(results);
	}
}
```

---

#### 在后台处理时间格式
```java
private Date createTime;
private String time;
// 一个时间格式，传入时间戳即转换
private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

public void setCreateTime(Date createTime) {
		this.createTime = createTime;
		String format = simpleDateFormat.format(createTime);
		setTime(format);
	}

