package com.kook.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kook.shop.domain.MemberVO;
import com.kook.shop.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService mservice;
	
	@GetMapping("/customJoin")
	public void customJoin() {
		log.info("customJoin....");
	}
	
	@GetMapping("/customLogout")
	public void customLogout() {
		log.info("log..out...");
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("사용자 권한 : " + auth);
		
		model.addAttribute("msg", "권한 없음");
		
	}
	
	@GetMapping("/customLogin")
	public void customLogin(String error, String logout, Model model) {
		
		//error은 로그인 실패시 스프링에서 error내용을 전달하고 logout시는 로그아웃 정보를 전달
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error -- Check Your Account");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@GetMapping(value = "/idChk", produces = MediaType.TEXT_PLAIN_VALUE + ";charset=UTF8")
	@ResponseBody
	public String customJoinIdChk(String userid) {
		log.info("Join ID 중복체크");
		System.out.println("userid: " + userid);
		String result = mservice.joinIdCheck(userid);
		return result;
	}
	
	@PostMapping("customJoin")
	public String customJoinPost(MemberVO vo) {
		System.out.println("vo: " + vo.getUsername());
		
		int result = mservice.joinRegister(vo);
		
		if(result > 0) {
			return "member/customLogin";
		}
		else {
			return "redirect:customJoin";
		}
	}
}
