package com.kook.shop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno; // 번호
	private String title; // 제목
	private String content; // 내용
	private String username; // 작성자
	private Date regdate; // 작성날짜
	private Date updatedate; // 수정날짜
}
