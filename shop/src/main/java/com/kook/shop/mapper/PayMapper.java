package com.kook.shop.mapper;

import java.util.List;

import com.kook.shop.domain.PayVO;

public interface PayMapper {
	
	public void insertPayment(PayVO pay);
	
	public PayVO getPaymentById(Long id);
	
	public List<PayVO> getPaymentsByUserId(Long userid);
	
	public void updatePayment(PayVO pay);
	
	public void deletePayment(Long id);
	
}
