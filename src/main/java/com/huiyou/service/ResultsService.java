package com.huiyou.service;

import java.util.List;

import com.huiyou.model.Classes;
import com.huiyou.model.Results;

public interface ResultsService {

	List<Object> selResults(Results results);

	void delResults(Results results);

	void updateResults(Results results);

}
