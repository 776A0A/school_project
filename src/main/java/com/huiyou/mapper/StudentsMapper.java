package com.huiyou.mapper;

import java.util.List;

import com.huiyou.model.Students;

public interface StudentsMapper {
	List<Object> selStudents(Students students);
	void delStudents(Students students);
}
