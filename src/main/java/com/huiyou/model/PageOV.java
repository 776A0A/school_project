package com.huiyou.model;

public class PageOV {
	private Integer page = 1;
	private Integer limit = 10;
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	@Override
	public String toString() {
		return "PageOV [page=" + page + ", limit=" + limit + "]";
	}
}
