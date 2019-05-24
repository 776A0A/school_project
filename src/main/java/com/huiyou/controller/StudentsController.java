package com.huiyou.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huiyou.model.DataGridView;
import com.huiyou.model.Results;
import com.huiyou.model.Students;
import com.huiyou.service.ResultsService;
import com.huiyou.service.StudentsService;

@Controller
@RequestMapping("students")
public class StudentsController {
	@Autowired
	private StudentsService studentsService;
	@Autowired
	private ResultsService resultsService;
	
	@RequestMapping("selStudents")
	@ResponseBody
	public DataGridView selStudents(Students students) {
		System.out.println("来自selStudents：" + students);
		List<Object> selStudents = studentsService.selStudents(students);
		DataGridView dgv = new DataGridView();
		dgv.setData(selStudents);
		dgv.setMsg("查询成功！");
		dgv.setCount(selStudents.size());
		return dgv;
	}
	
	@RequestMapping("delStudents")
	@ResponseBody
	public DataGridView delStudents(Students students) {
		System.out.println("来自delStudents：" + students);
		String ids = students.getIds();
		if (ids != "" && ids != null) {
			String ids1[] = ids.split(",");
			for (String id : ids1) {
				Integer i = Integer.parseInt(id);
				students.setId(i);
				studentsService.delStudents(students);
			}
		} else {
			studentsService.delStudents(students);
		}
		Students students1 = new Students();
		List<Object> selStudents = studentsService.selStudents(students1);
		DataGridView dgv = new DataGridView();
		dgv.setData(selStudents);
		dgv.setMsg("删除成功！");
		dgv.setCount(selStudents.size());
		return dgv;
	}
	
	@RequestMapping("updateStatus")
	@ResponseBody
	public void updateStatus(Students students) {
		studentsService.updateStatus(students);
	}
	
	@RequestMapping("editResults")
	public String editResults(Results results, Model model) {
		List<Object> selResults = resultsService.selResults(results);
		model.addAttribute("results", selResults.get(0));
		return "editResults";
	}
	
}
