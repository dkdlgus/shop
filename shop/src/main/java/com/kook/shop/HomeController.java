package com.kook.shop;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kook.shop.domain.ListImageVO;
import com.kook.shop.domain.ListVO;
import com.kook.shop.domain.OrderVO;
import com.kook.shop.domain.PayVO;
import com.kook.shop.domain.PaymentDTO;
import com.kook.shop.security.domain.CustomUser;
import com.kook.shop.service.ListService;
import com.kook.shop.service.PayService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	@Setter(onMethod_ = @Autowired)
	private ListService Lservice;
	
	@Setter(onMethod_ = @Autowired)
	private PayService pservice;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "redirect:home/home";
	}
	@PostMapping("/home/order")
    public ResponseEntity<Map<String, Object>> saveOrder(@RequestBody OrderVO order) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 주문 정보를 데이터베이스에 저장
            pservice.insertOrder(order);
            
            // 성공 응답
            response.put("success", true);
            response.put("message", "Order saved successfully.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
        	// 예외 처리
            response.put("success", false);
            response.put("message", "Error saving order: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
	
	@PostMapping("/home/iamport")
	public ResponseEntity<String> completePayment(@RequestBody Map<String, String> payload) {
	    String impUid = payload.get("imp_uid");
	    String merchantUid = payload.get("merchant_uid");
	    
	    log.info("Payment completion process started for impUid: " + impUid);
	    
	    try {
	    	// 중복 결제 검증
	        PayVO existingPayment = pservice.getPaymentByImpUid(impUid);
	        if (existingPayment != null) {
	            log.warn("Duplicate payment attempt detected for impUid: " + impUid);
	            return ResponseEntity.status(400).body("Duplicate payment detected.");
	        }
	        
	        // 1. 토큰 발급
	        String accessToken = getAccessToken();

	        // 2. 결제 정보 조회
	        PaymentDTO paymentDTO = getPaymentInfo(impUid, accessToken);
	        
	        // 주문정보 조회
	        OrderVO order = pservice.getOrderByMerchantUid(merchantUid);
	        
	        // 3. 결제 검증
	        if (paymentDTO.getAmount().equals(order.getAmount())) {
	            if ("paid".equals(paymentDTO.getStatus())) {
	                // 결제가 완료된 경우, 로직 처리
	                PayVO pay = new PayVO();
	                pay.setPg(paymentDTO.getPgProvider());
	                pay.setImpuid(impUid);
	                pay.setMerchantuid(merchantUid);
	                pay.setName(paymentDTO.getName());
	                pay.setAmount(paymentDTO.getAmount());
	                pay.setBuyer_name(paymentDTO.getBuyerName());
	                pay.setBuyer_email(paymentDTO.getBuyerEmail());
	                pay.setBuyer_tel(paymentDTO.getBuyerTel());
	                
	                log.info("Attempting to insert payment with impUid: " + impUid);
	                pservice.insertPayment(pay);
	                log.info("Payment inserted for impUid: " + impUid);

	                return ResponseEntity.ok("Payment completed successfully.");
	            }
	        } else {
	            log.warn("Payment amount mismatch for impUid: " + impUid);
	            return ResponseEntity.status(400).body("Payment amount mismatch.");
	        }
	    } catch (Exception e) {
	        log.error("Error processing payment completion for impUid: " + impUid, e);
	        return ResponseEntity.status(500).body("Error processing payment completion.");
	    }
	    
	    // 기본 반환값 추가
	    return ResponseEntity.status(500).body("Unknown error occurred.");
	}
	
	private String getAccessToken() throws IOException {
	    String apiUrl = "https://api.iamport.kr/users/getToken";
	    HttpClient client = HttpClient.newHttpClient();
	    HttpRequest request = HttpRequest.newBuilder()
	        .uri(URI.create(apiUrl))
	        .header("Content-Type", "application/json")
	        .POST(HttpRequest.BodyPublishers.ofString("{\"imp_key\":\"\",\"imp_secret\":\"\"}"))
	        .build();

	    // 예외 처리 추가
        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
                return jsonResponse.get("response").getAsJsonObject().get("access_token").getAsString();
            } else {
                throw new RuntimeException("Failed to get access token, status code: " + response.statusCode());
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            throw new RuntimeException("Error occurred while getting access token", e);
        }
	}
	
	private PaymentDTO getPaymentInfo(String impUid, String accessToken) throws IOException {
	    String apiUrl = "https://api.iamport.kr/payments/" + impUid;
	    HttpClient client = HttpClient.newHttpClient();
	    HttpRequest request = HttpRequest.newBuilder()
	        .uri(URI.create(apiUrl))
	        .header("Authorization", accessToken)
	        .build();

	    // 예외 처리 추가
        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
                JsonObject responseData = jsonResponse.get("response").getAsJsonObject();

                PaymentDTO paymentDTO = new PaymentDTO();
                paymentDTO.setPgProvider(responseData.get("pg_provider").getAsString());
                paymentDTO.setStatus(responseData.get("status").getAsString());
                paymentDTO.setAmount(responseData.get("amount").getAsLong());
                paymentDTO.setName(responseData.get("name").getAsString());
                paymentDTO.setBuyerName(responseData.get("buyer_name").getAsString());
                paymentDTO.setBuyerEmail(responseData.get("buyer_email").getAsString());
                paymentDTO.setBuyerTel(responseData.get("buyer_tel").getAsString());

                return paymentDTO;
            } else {
                throw new RuntimeException("Failed to get payment information, status code: " + response.statusCode());
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            throw new RuntimeException("Error occurred while getting payment information", e);
        }
	}
	
	@GetMapping("/home/home")
	public void get(Model model) {
		
		log.info("home...");
		
		model.addAttribute("list", Lservice.getList());
		
		// 현재 로그인된 사용자 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    
	    if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
	        CustomUser customUser = (CustomUser) authentication.getPrincipal();
	        // Model에 사용자 정보 추가
	        model.addAttribute("username", customUser.getUsername());
	        model.addAttribute("email", customUser.getMember().getUseremail());
	        model.addAttribute("tell", customUser.getMember().getTell());
	    } else {
	        // 인증되지 않은 사용자일 경우 기본값 설정
	        model.addAttribute("username", "Anonymous");
	        model.addAttribute("email", "N/A");
	        model.addAttribute("phone", "N/A");
	    }
		
	}
	
	//home 화면에서 첨부파일 처리
	@GetMapping(value = "/home/getImageList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<ListImageVO>> getImageList(Long rno){
		
		log.info("getImageList..." + rno);
		
		List<ListImageVO> imageList = Lservice.getImageList(rno);
		
		return new ResponseEntity<>(imageList, HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/home/getHomeModal", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<ListVO> getHomeModal(@RequestParam("rno") Long rno){
		ListVO list = Lservice.get(rno);
		
		return ResponseEntity.ok(list);
	}
}
