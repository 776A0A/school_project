package com.huiyou.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huiyou.mapper.StudentsMapper;
import com.huiyou.model.PCAList;
import com.huiyou.model.Students;
import com.huiyou.service.StudentsService;

@Service
public class StudentsServiceImpl implements StudentsService{
	@Autowired
	private StudentsMapper studentsMapper;
	
	@Override
	public List<Object> selStudentsMap(Map<String, Object> map) {
		return studentsMapper.selStudentsMap(map);
	}
	
	@Override
	public List<Object> selStudents(Students students) {
		return studentsMapper.selStudents(students);
	}
	
	@Override
	public void delStudents(Students students) {
		studentsMapper.delStudents(students);
	}
	
	@Override
	public void updateStatus(Students students) {
		studentsMapper.updateStatus(students);
	}
	
	@Override
	public List<Object> getProvince(PCAList pcaList) {
		return studentsMapper.getProvince(pcaList);
	}
	
	@Override
	public List<Object> getCity(PCAList pcaList) {
		return studentsMapper.getCity(pcaList);
	}
	
	@Override
	public List<Object> getArea(PCAList pcaList) {
		return studentsMapper.getArea(pcaList);
	}
	
	@Override
	public void addStudent(Students students) {
		studentsMapper.addStudent(students);
	}
	
	@Override
	public void updateStudent(Students students) {
		studentsMapper.updateStudent(students);
	}
	
	public Integer count(Students students) {
		return studentsMapper.count(students);
	}
}
