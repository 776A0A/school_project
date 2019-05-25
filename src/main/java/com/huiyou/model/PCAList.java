package com.huiyou.model;

public class PCAList {
	private int id;
	private String name;
	private int pid;
	private int cid;
	private int aid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	@Override
	public String toString() {
		return "PCAList [id=" + id + ", name=" + name + ", pid=" + pid + ", cid=" + cid + ", aid=" + aid + "]";
	}
	
	
	
}
