package com.kook.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kook.shop.domain.PayVO;
import com.kook.shop.mapper.PayMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PayServiceImpl implements PayService {
	
	@Setter(onMethod_ = @Autowired)
	private PayMapper pmapper;
	
	@Override
	public void insertPayment(PayVO pay) {
		pmapper.insertPayment(pay);

	}

	@Override
	public PayVO getPaymentById(Long id) {
		return pmapper.getPaymentById(id);
	}

	@Override
	public List<PayVO> getPaymentsByUserId(Long userid) {
		return pmapper.getPaymentsByUserId(userid);
	}

	@Override
	public void updatePayment(PayVO pay) {
		pmapper.updatePayment(pay);

	}

	@Override
	public void deletePayment(Long id) {
		pmapper.deletePayment(id);

	}

}
