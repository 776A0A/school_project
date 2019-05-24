package com.huiyou.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huiyou.model.DataGridView;
import com.huiyou.model.Results;
import com.huiyou.service.ResultsService;

@Controller
@RequestMapping("results")
public class ResultsController {
	@Autowired
	private ResultsService resultsService;
	
	@RequestMapping("selResults")
	@ResponseBody
	public DataGridView selResults(Results results) {
		System.out.println("来自selResults："+ results);
		List<Object> selResults = resultsService.selResults(results);
		DataGridView dgv = new DataGridView();
		dgv.setData(selResults);
		dgv.setMsg("查询成功！");
		dgv.setCount(selResults.size());
		return dgv;
	}
	
	@RequestMapping("delResults")
	@ResponseBody
	public DataGridView delResults(Results results) {
		System.out.println("来自delResults："+ results);
		String ids = results.getIds();
		if (ids != null && ids != "") {
			String ids1[] = ids.split(",");
			for (String id : ids1) {
				Integer i = Integer.parseInt(id);
				results.setId(i);
				resultsService.delResults(results);
			}
		} else {
			resultsService.delResults(results);
		}
		Results results1 = new Results();
		List<Object> selResults = resultsService.selResults(results1);
		DataGridView dgv = new DataGridView();
		dgv.setData(selResults);
		dgv.setMsg("批量删除！");
		dgv.setCount(selResults.size());
		return dgv;
	}
}
