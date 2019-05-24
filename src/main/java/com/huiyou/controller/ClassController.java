package com.huiyou.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huiyou.model.Classes;
import com.huiyou.model.DataGridView;
import com.huiyou.service.ClassService;

@Controller
@RequestMapping("classes")
public class ClassController {
	@Autowired
	private ClassService classService; 
	
	@RequestMapping("selClass")
	@ResponseBody
	public DataGridView selClass(Classes classes) {
		System.out.println("来自selClass：" + classes);
		List<Object> selClass = classService.selClass(classes);
		DataGridView dgv = new DataGridView();
		dgv.setData(selClass);
		dgv.setMsg("查询selClass成功！");
		dgv.setCount(selClass.size());
		return dgv;
	}
	
	@RequestMapping("delClass")
	@ResponseBody
	public DataGridView delClass(Classes classes) {
		System.out.println("来自delClass：" + classes);
		String ids = classes.getIds();
		if (ids != null && ids != "") {
			String ids2[] = ids.split(",");
			for (String id : ids2) {
				Integer i = Integer.parseInt(id);
				classes.setId(i);
				classService.delClass(classes);
			}
		} else {
			classService.delClass(classes);
		}
		Classes classes1 = new Classes();
		List<Object> selClasses = classService.selClass(classes1);
		DataGridView dgv = new DataGridView();
		dgv.setData(selClasses);
		dgv.setMsg("删除成功！");
		dgv.setCount(selClasses.size());
		return dgv;
	}
	
	@RequestMapping("updateClass")
	@ResponseBody
	public DataGridView updateClass(Classes classes) {
		System.out.println("来自uplateClass：" + classes);
		classService.updateClass(classes);
		Classes classes1 = new Classes();
		List<Object> selClass = classService.selClass(classes1);
		DataGridView dgv = new DataGridView();
		dgv.setData(selClass);
		dgv.setMsg("更新成功！");
		dgv.setCount(selClass.size());
		return dgv;
	}
}
