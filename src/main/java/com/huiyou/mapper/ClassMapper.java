package com.huiyou.mapper;

import java.util.List;

import com.huiyou.model.Classes;

public interface ClassMapper {
	List<Object> selClass(Classes classes);
	void delClass(Classes classes);
	void updateClass(Classes classes);
}
