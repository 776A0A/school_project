package com.huiyou.mapper;

import java.util.List;

import com.huiyou.model.PCAList;
import com.huiyou.model.Students;

public interface StudentsMapper {
	List<Object> selStudents(Students students);
	void delStudents(Students students);
	void updateStatus(Students students);
	List<Object> getProvince(PCAList pcaList);
	List<Object> getCity(PCAList pcalist);
	List<Object> getArea(PCAList pcalist);
}
