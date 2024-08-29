package com.kook.shop.domain;

import java.util.List;

import lombok.Data;

@Data
public class ListVO {
	
	private Long rno; // 번호
	private String sname; // 상품이름
	private Long money; // 상품금액
	private Long discount; // 할인율
	private Long moneyshop; // 할인된 금액
	
	private List<ListImageVO> imageList; // 이미지
	
}
