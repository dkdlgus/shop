package com.kook.shop.domain;

import lombok.Data;

@Data
public class ImageFileDTO {
	
	private String filename;
	private String uploadpath;
	private String uuid;
	private boolean image;
	
}
