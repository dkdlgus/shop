package com.kook.shop.mapper;

import com.kook.shop.domain.OrderVO;
import com.kook.shop.domain.PayVO;

public interface PayMapper {
	
	// 결제 등록
	public void insertPayment(PayVO pay);
	
	// 결제 고유ID로 조회
	public PayVO getPaymentById(Long id);
	
	// 결제 impuid로 조회
	public PayVO getPaymentByImpUid(String impuid);
	
	//
	//public List<PayVO> getPaymentsByUserId(String userid);
	
	//
	//public void updatePayment(PayVO pay);
	
	// 삭제
	//public void deletePayment(Long id);
	
	// ------------------ 주문 정보 -----------------------
	// 주문정보 등록
	public void insertOrder(OrderVO order);
	
	// 주문정보 merchantuid로 조회
	public OrderVO getOrderByMerchantUid(String merchantuid);
	
}
