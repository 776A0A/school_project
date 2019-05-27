package com.huiyou.service;

import java.util.List;
import java.util.Map;

import com.huiyou.model.Classes;
import com.huiyou.model.Results;

public interface ResultsService {

	List<Object> selResults(Results results);

	void delResults(Results results);

	void updateResults(Results results);

	void addResults(Results results);

	List<Object> selResultsMap(Map<String, Object> map);

	Integer count(Results results);

}
