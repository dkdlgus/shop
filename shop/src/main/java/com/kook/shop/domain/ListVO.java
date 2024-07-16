package com.kook.shop.domain;

import java.util.List;

import lombok.Data;

@Data
public class ListVO {
	
	private Long rno;
	private String sname;
	private Long money;
	
	private List<ListImageVO> imageList;
	
}
