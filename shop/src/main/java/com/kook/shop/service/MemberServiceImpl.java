package com.kook.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kook.shop.domain.AuthVO;
import com.kook.shop.domain.MemberVO;
import com.kook.shop.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder passwordEncoder;
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper Mmapper;
	
	@Override
	public String joinIdCheck(String userid) {
		
		MemberVO vo = Mmapper.read(userid);
		
		String result = null;
		
		if(vo == null) {
			result = "success";
		}
		else {
			result = "failed";
		}
		
		return result;
	}

	@Override
	public int joinRegister(MemberVO vo) {
		
		String userid = vo.getUserid();
		
		String userpw = vo.getUserpw(); //패스워드
		
		String bcriptPw = passwordEncoder.encode(userpw); //암호화된 패스워드
		
		vo.setUserpw(bcriptPw);
		
		AuthVO auth = new AuthVO();
		
		auth.setAuth("ROLE_MEMBER"); //권한은 일반 회원으로 초기화
		auth.setUserid(userid);
		
		Mmapper.memberJoin(vo);
		
		int result = Mmapper.memberAuth(auth);
		
		return result;
		
	}

}
