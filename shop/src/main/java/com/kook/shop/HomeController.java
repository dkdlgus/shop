package com.kook.shop;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kook.shop.domain.ListImageVO;
import com.kook.shop.domain.ListVO;
import com.kook.shop.service.ListService;

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
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "redirect:home/home";
	}
	
	@GetMapping("/home/home")
	public void get(Model model) {
		
		log.info("home...");
		
		model.addAttribute("list", Lservice.getList());
		
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
