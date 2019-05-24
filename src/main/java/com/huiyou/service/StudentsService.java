package com.huiyou.service;

import java.util.List;

import com.huiyou.model.Students;

public interface StudentsService {

	List<Object> selStudents(Students students);

	void delStudents(Students students);

	void updateStatus(Students students);

}
