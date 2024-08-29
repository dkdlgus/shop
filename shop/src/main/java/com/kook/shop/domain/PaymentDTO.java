package com.kook.shop.domain;

import lombok.Data;

@Data
public class PaymentDTO {
	
	private String pgProvider;
    private String status;
    private Long amount;
    private String name;
    private String buyerName;
    private String buyerEmail;
    private String buyerTel;
	
}
