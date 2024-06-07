package com.kook.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kook.shop.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board") // 요청을 해당 메서드로 연결하는 어노테이션으로 클래스에 지정시는 공통 경로, board로 시작하는 요청은 모드 BoardController로 옴
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	//게시판 화면
	@GetMapping("/list")
	public void list(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getList());
		
	}
	
	//등록화면
	@GetMapping("/register")
	public void register() {
		log.info("register");
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model){
		
		log.info("get");
		
		model.addAttribute("board", service.get(bno));
				
	}
		
}
