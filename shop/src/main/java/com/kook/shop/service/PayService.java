package com.kook.shop.service;

import com.kook.shop.domain.OrderVO;
import com.kook.shop.domain.PayVO;

public interface PayService {
	
	public void insertPayment(PayVO pay);

	public PayVO getPaymentById(Long id);
	
	public PayVO getPaymentByImpUid(String impuid);

	//public List<PayVO> getPaymentsByUserId(String userid);

	//public void updatePayment(PayVO pay);

	//public void deletePayment(Long id);
	
	public void insertOrder(OrderVO order);

	public OrderVO getOrderByMerchantUid(String merchantuid);
	
}
