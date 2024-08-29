package com.kook.shop.domain;

import lombok.Data;

@Data
public class PayVO {
	
	private Long id;
	private String pg;
	private String impuid;
	private String merchantuid;
	private String name;
	private Long amount;
	private String buyer_name;
	private String buyer_email;
	private String buyer_tel;
}
