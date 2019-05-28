package com.huiyou.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huiyou.model.Classes;
import com.huiyou.model.DataGridView;
import com.huiyou.model.PageOV;
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
	
	@RequestMapping("selClassMap")
	@ResponseBody
	public DataGridView selClassMap(Classes classes, PageOV pageOV) {
		System.out.println("来自selClassMap：" + classes);
		List<Object> selClass;
		if (pageOV.getLimit() != null) {
			pageOV.setPage((pageOV.getPage()-1)*pageOV.getLimit());
			Map<String, Object> map = new HashMap<>();
			map.put("classes", classes);
			map.put("page", pageOV);
			selClass = classService.selClassMap(map);
		} else {
			selClass = classService.selClass(classes);
		}
		DataGridView dgv = new DataGridView();
		dgv.setData(selClass);
		dgv.setMsg("查询成功！！");
		dgv.setCount(classService.count(classes));
		return dgv;
	}
	
	@RequestMapping("delClass")
	@ResponseBody
	public void delClass(Classes classes) {
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
	}
	
	@RequestMapping("updateClass")
	@ResponseBody
	public Integer updateClass(Classes classes) {
		System.out.println("来自uplateClass：" + classes);
		List<Object> exist = classService.existClassName(classes);
		System.out.println("aaaaaaaaaaaaaaaaaa" + exist);
		if (exist.size() > 0) {
			return 0;
		} else {
			classService.updateClass(classes);
			return 200;
		}
	}
	
	@RequestMapping("addClass")
	@ResponseBody
	public Integer addClass(Classes classes) {
		System.out.println("来自addClass：" + classes);
		List<Object> exist = classService.existClassName(classes);
		System.out.println("aaaaaaaaaaaaaaaaaa" + exist);
		if (exist.size() > 0) {
			return 0;
		} else {
			classService.addClass(classes);
			return 200;
		}
	}
}
