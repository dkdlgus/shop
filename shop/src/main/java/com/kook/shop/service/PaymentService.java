package com.kook.shop.service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.Payment;

public class PaymentService {
	
	private IamportClient iamportClient;

    // 생성자에서 IamportClient 초기화
    public PaymentService() {
        // 여기에 본인의 Iamport API 키와 시크릿을 넣어주세요
        this.iamportClient = new IamportClient("8755134467268530", "qW5zhppWkclVOQHck7LnzNDCHNiLURRMZlh7hd1AJRVVnr7Cx0xPFvsfz17uHJA6lpkuEVHncvyQzK6P");
    }

}
