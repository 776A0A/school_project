package com.huiyou.model;

public class Results {
	private Integer id;
	private Integer stuId;
	private Integer chinese;
	private Integer english;
	private Integer math;
	private Integer classId;
	private String studentName;
	private String className;
	private String ids;
	private Integer total;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStuId() {
		return stuId;
	}
	public void setStuId(Integer stuId) {
		this.stuId = stuId;
	}
	public Integer getChinese() {
		return chinese;
	}
	public void setChinese(Integer chinese) {
		this.chinese = chinese;
	}
	public Integer getEnglish() {
		return english;
	}
	public void setEnglish(Integer english) {
		this.english = english;
	}
	public Integer getMath() {
		return math;
	}
	public void setMath(Integer math) {
		this.math = math;
	}
	
	public Integer getClassId() {
		return classId;
	}
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
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
	
	public Integer getTotal() {
		return this.chinese + this.english + this.math;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "Results [id=" + id + ", stuId=" + stuId + ", chinese=" + chinese + ", english=" + english + ", math="
				+ math + ", classId=" + classId + ", studentName=" + studentName + ", className=" + className + ", ids="
				+ ids + ", total=" + total + "]";
	}
}
