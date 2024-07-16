package com.kook.shop.domain;

import lombok.Data;

@Data
public class ListImageVO {

	private String uuid;
	private String uploadpath;
	private String filename;
	private boolean filetype;
	
	private Long rno;
	
}
