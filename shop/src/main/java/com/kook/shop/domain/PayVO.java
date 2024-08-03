package com.kook.shop.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PayVO {
	
	private Long id;
	private Long userid;
	private String impuid;
	private String merchantuid;
	private BigDecimal amount;
	private String status;
	private LocalDateTime paidat;
	private LocalDateTime failedat;
	private LocalDateTime createdat;
	private LocalDateTime updatedat;
	
}
