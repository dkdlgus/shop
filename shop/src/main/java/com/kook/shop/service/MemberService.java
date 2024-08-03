package com.kook.shop.service;

import com.kook.shop.domain.MemberVO;

public interface MemberService {
	
	public String joinIdCheck(String userid);
	
	public int joinRegister(MemberVO vo);
	
}
