package com.kook.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kook.shop.domain.BoardVO;
import com.kook.shop.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@GetMapping("/board")
	public void list(Model model) {
		
		log.info("list...");
		
		model.addAttribute("list", service.getList());
		
	}
	//관리자만 등록가능 하게끔 수정해야함.
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/register")
	public void register() {
		log.info("register....");
	}
	
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		
		log.info("==========");
		log.info("register : " + vo);
		
		service.register(vo);
		
		rttr.addFlashAttribute("result", vo.getBno());
		//1회용 데이터
		
		return "redirect:board";
		
	}
}
