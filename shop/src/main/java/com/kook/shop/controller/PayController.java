package com.kook.shop.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kook.shop.domain.PayVO;
import com.kook.shop.service.PayService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/webhook")
public class PayController {

    @Autowired
    private PayService payService;

    @PostMapping("/iamport")
    public ResponseEntity<String> handleIamportWebhook(@RequestBody Map<String, Object> payload) {
        log.info("Webhook payload: " + payload);

        try {
            String impUid = (String) payload.get("imp_uid");
            String merchantUid = (String) payload.get("merchant_uid");
            String status = (String) payload.get("status");

            if ("paid".equals(status)) {
                // 결제가 완료된 경우에만 데이터베이스에 저장
                PayVO pay = new PayVO();
                pay.setPg((String) payload.get("pg_provider"));
                pay.setImpuid(impUid);
                pay.setMerchantuid(merchantUid);
                pay.setName((String) payload.get("name"));
                pay.setAmount(Long.valueOf(payload.get("amount").toString()));
                pay.setBuyer_name((String) payload.get("buyer_name"));
                pay.setBuyer_email((String) payload.get("buyer_email"));
                pay.setBuyer_tel((String) payload.get("buyer_tel"));

                // 데이터베이스에 결제 정보 저장
                payService.insertPayment(pay);
                log.info("Payment information saved successfully.");
            }

            return ResponseEntity.ok("Webhook processed successfully");
        } catch (Exception e) {
            log.error("Error processing webhook", e);
            return ResponseEntity.status(500).body("Error processing webhook");
        }
    }
}