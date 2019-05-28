package com.huiyou.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huiyou.model.DataGridView;
import com.huiyou.model.PageOV;
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
	
	@RequestMapping("selResultsMap")
	@ResponseBody
	public DataGridView selResultsMap(Results results, PageOV pageOV) {
		System.out.println("来自selResultsMap："+ results);
		List<Object> selResults;
		if (pageOV.getLimit() != null) {
			pageOV.setPage((pageOV.getPage()-1)*pageOV.getLimit());
			Map<String, Object> map = new HashMap<>();
			map.put("results", results);
			map.put("page", pageOV);
			selResults = resultsService.selResultsMap(map);			
		} else {
			selResults = resultsService.selResults(results);	
		}
		DataGridView dgv = new DataGridView();
		dgv.setData(selResults);
		dgv.setMsg("查询成功！！");
		dgv.setCount(resultsService.count(results));
		return dgv;
	}
	
	@RequestMapping("delResults")
	@ResponseBody
	public Integer delResults(Results results) {
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
		return 0;
	}
	
	@RequestMapping("updateResults")
	@ResponseBody
	public void updateResults(Results results) {
		System.out.println("来自updateResults："+ results);
		resultsService.updateResults(results);
	}
	
	@RequestMapping("addResults")
	@ResponseBody
	public void addResults(Results results) {
		System.out.println("来自addResults："+ results);
		Results results1 = new Results();
		results1.setStuId(results.getStuId());
		List<Object> res = resultsService.selResults(results1);
		if (res.size() == 0) {
			resultsService.addResults(results);			
		} else {
			resultsService.updateResults(results);
		}
	}
}
