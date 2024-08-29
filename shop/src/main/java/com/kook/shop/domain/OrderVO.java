package com.kook.shop.domain;

import lombok.Data;

@Data
public class OrderVO {
	
	private Long orderid;
	private Long rno;
	private String merchantuid;
	private String name;
	private Long amount;
	private String buyer_name;
	private String buyer_email;
	private String buyer_tel;
	
}
