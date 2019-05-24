package com.huiyou.service;

import java.util.List;

import com.huiyou.model.Classes;

public interface ClassService {

	List<Object> selClass(Classes classes);

	void delClass(Classes classes);

	void updateClass(Classes classes);

	void addClass(Classes classes);
	
}
