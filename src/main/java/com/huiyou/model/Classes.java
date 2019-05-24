package com.huiyou.model;

public class Classes {
	private Integer id;
	private String className;
	private String ids;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	@Override
	public String toString() {
		return "Classes [id=" + id + ", className=" + className + ", ids=" + ids + "]";
	}
	
}
