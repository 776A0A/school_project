package com.huiyou.model;

import java.util.List;

// layui中table组件默认数据交换格式
public class DataGridView {
	private Integer	code = 0;
	private String msg = "";
	private Integer count;
	private List<Object> data;
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public List<Object> getData() {
		return data;
	}
	public void setData(List<Object> data) {
		this.data = data;
	}
	@Override
	public String toString() {
		return "DataGridView [code=" + code + ", msg=" + msg + ", count=" + count + ", data=" + data + "]";
	}
}
