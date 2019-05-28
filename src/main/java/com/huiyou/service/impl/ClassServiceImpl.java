package com.huiyou.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huiyou.mapper.ClassMapper;
import com.huiyou.model.Classes;
import com.huiyou.service.ClassService;

@Service
public class ClassServiceImpl implements ClassService{
	@Autowired
	private ClassMapper classMapper;
	
	@Override
	public List<Object> selClass(Classes classes) {
		return classMapper.selClass(classes);
	}
	
	@Override
	public List<Object> selClassMap(Map<String, Object> map) {
		return classMapper.selClassMap(map);
	}
	
	@Override
	public void delClass(Classes classes) {
		classMapper.delClass(classes);
	}
	@Override
	public void updateClass(Classes classes) {
		classMapper.updateClass(classes);
	}
	@Override
	public void addClass(Classes classes) {
		classMapper.addClass(classes);
	}
	
	@Override
	public Integer count(Classes classes) {
		return classMapper.count(classes);
	}
	
	@Override
	public List<Object> existClassName(Classes classes) {
		return classMapper.existClassName(classes);
	}
}
