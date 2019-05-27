package com.huiyou.mapper;

import java.util.List;
import java.util.Map;

import com.huiyou.model.Results;

public interface ResultsMapper {
	List<Object> selResults(Results results);
	List<Object> selResultsMap(Map<String, Object> map);
	void delResults(Results results);
	void updateResults(Results results);
	void addResults(Results results);
	Integer count(Results results);
}
