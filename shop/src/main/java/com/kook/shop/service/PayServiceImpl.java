package com.kook.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kook.shop.domain.OrderVO;
import com.kook.shop.domain.PayVO;
import com.kook.shop.mapper.PayMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PayServiceImpl implements PayService {
	
	@Setter(onMethod_ = @Autowired)
	private PayMapper pmapper;
	
	@Transactional
	@Override
	public void insertPayment(PayVO pay) {
		log.info("Insert payment called for impuid: " + pay.getImpuid());
		pmapper.insertPayment(pay);
        log.info("Payment inserted successfully for impuid: " + pay.getImpuid());


	}

	@Override
	public PayVO getPaymentById(Long id) {
		return pmapper.getPaymentById(id);
	}
	
	@Override
	public PayVO getPaymentByImpUid(String impuid) {
		return pmapper.getPaymentByImpUid(impuid);
	}

	//@Override
	//public List<PayVO> getPaymentsByUserId(String userid) {
	//	return pmapper.getPaymentsByUserId(userid);
	//}

	//@Override
	//public void updatePayment(PayVO pay) {
	//	pmapper.updatePayment(pay);

	//}

	//@Override
	//public void deletePayment(Long id) {
	//	pmapper.deletePayment(id);
	//}
	
	@Transactional
	@Override
	public void insertOrder(OrderVO order) {
		pmapper.insertOrder(order);

	}

	@Override
	public OrderVO getOrderByMerchantUid(String merchantuid) {
		return pmapper.getOrderByMerchantUid(merchantuid);
	}

}
