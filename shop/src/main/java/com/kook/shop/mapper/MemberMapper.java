package com.kook.shop.mapper;

import com.kook.shop.domain.AuthVO;
import com.kook.shop.domain.MemberVO;

public interface MemberMapper {
	
	//회원 조회
	public MemberVO read(String userid);
	
	//회원 등록
	public int memberJoin(MemberVO vo);
	
	//권한 등록
	public int memberAuth(AuthVO avo);
	
}
