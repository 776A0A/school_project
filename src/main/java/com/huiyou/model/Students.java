package com.huiyou.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Students {
	private Integer id;
	private Integer number;
	private String img;
	private String name;
	private Integer sex;
	private Integer classId;
	private Integer status;
	private Integer pid;
	private Integer cid;
	private Integer aid;
	private String detailed;
	private Date createTime;
	private String time;
	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private String className;
	private Integer chinese;
	private Integer english;
	private Integer math;
	private String ids;
	private String pName;
	private String cName;
	private String aName;
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
		String format = simpleDateFormat.format(createTime);
		setTime(format);
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Integer getClassId() {
		return classId;
	}
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public String getDetailed() {
		return detailed;
	}
	public void setDetailed(String detailed) {
		this.detailed = detailed;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
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
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getaName() {
		return aName;
	}

	public void setaName(String aName) {
		this.aName = aName;
	}

	@Override
	public String toString() {
		return "Students [id=" + id + ", number=" + number + ", img=" + img + ", name=" + name + ", sex=" + sex
				+ ", classId=" + classId + ", status=" + status + ", pid=" + pid + ", cid=" + cid + ", aid=" + aid
				+ ", detailed=" + detailed + ", createTime=" + createTime + ", time=" + time + ", simpleDateFormat="
				+ simpleDateFormat + ", className=" + className + ", chinese=" + chinese + ", english=" + english
				+ ", math=" + math + ", ids=" + ids + ", pName=" + pName + ", cName=" + cName + ", aName=" + aName
				+ "]";
	}
}
