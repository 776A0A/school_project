package com.huiyou.service;

import java.util.List;

import com.huiyou.model.PCAList;
import com.huiyou.model.Students;

public interface StudentsService {

	List<Object> selStudents(Students students);

	void delStudents(Students students);

	void updateStatus(Students students);

	List<Object> getProvince(PCAList pcaList);

	List<Object> getCity(PCAList pcaList);

	List<Object> getArea(PCAList pcaList);

	void addStudent(Students students);

}
