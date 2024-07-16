package com.kook.shop.domain;

import java.util.List;

import lombok.Data;

@Data
public class ShopListDTO {
	
	private int listCnt;
	private List<ListVO> list;
	
}
