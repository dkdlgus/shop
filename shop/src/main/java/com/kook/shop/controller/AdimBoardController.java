package com.kook.shop.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kook.shop.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board") // 요청을 해당 메서드로 연결하는 어노테이션으로 클래스에 지정시는 공통 경로, board로 시작하는 요청은 모드 BoardController로 옴
@AllArgsConstructor
public class AdimBoardController {

	private BoardService service;
	
	//게시판 화면
	@Secured({"ROLE_ADMIN"}) //어드민 권한
	@GetMapping("/AdminList")
	public void list(Model model) {
		
		log.info("AdminList");
		
		model.addAttribute("AdminList", service.getList());
		
	}
		
}
