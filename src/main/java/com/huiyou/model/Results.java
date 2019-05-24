package com.huiyou.model;

public class Results {
	private Integer id;
	private Integer stuId;
	private Integer chinese;
	private Integer english;
	private Integer math;
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
	@Override
	public String toString() {
		return "Results [id=" + id + ", stuId=" + stuId + ", chinese=" + chinese + ", english=" + english + ", math="
				+ math + "]";
	}
}
