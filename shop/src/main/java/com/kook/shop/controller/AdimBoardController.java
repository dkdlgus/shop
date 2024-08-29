package com.kook.shop.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kook.shop.service.ListService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board") // �슂泥��쓣 �빐�떦 硫붿꽌�뱶濡� �뿰寃고븯�뒗 �뼱�끂�뀒�씠�뀡�쑝濡� �겢�옒�뒪�뿉 吏��젙�떆�뒗 怨듯넻 寃쎈줈, board濡� �떆�옉�븯�뒗 �슂泥��� 紐⑤뱶 BoardController濡� �샂
@AllArgsConstructor
public class AdimBoardController {

	private ListService service;
	
	//寃뚯떆�뙋 �솕硫�
	@Secured({"ROLE_ADMIN"}) //�뼱�뱶誘� 沅뚰븳
	@GetMapping("/AdminList")
	public void list(Model model) {
		
		log.info("AdminList");
		
		model.addAttribute("AdminList", service.getList());
		
	}
		
}
