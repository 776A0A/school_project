package com.huiyou.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huiyou.mapper.StudentsMapper;
import com.huiyou.model.Students;
import com.huiyou.service.StudentsService;

@Service
public class StudentsServiceImpl implements StudentsService{
	@Autowired
	private StudentsMapper studentsMapper;
	
	@Override
	public List<Object> selStudents(Students students) {
		return studentsMapper.selStudents(students);
	}
	
	@Override
	public void delStudents(Students students) {
		studentsMapper.delStudents(students);
	}
}
