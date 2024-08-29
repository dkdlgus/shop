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
		
		String userpw = vo.getUserpw(); //�뙣�뒪�썙�뱶
		
		String bcriptPw = passwordEncoder.encode(userpw); //�븫�샇�솕�맂 �뙣�뒪�썙�뱶
		
		vo.setUserpw(bcriptPw);
		
		AuthVO auth = new AuthVO();
		
		auth.setAuth("ROLE_MEMBER"); //沅뚰븳�� �씪諛� �쉶�썝�쑝濡� 珥덇린�솕
		auth.setUserid(userid);
		
		Mmapper.memberJoin(vo);
		
		int result = Mmapper.memberAuth(auth);
		
		return result;
		
	}

}
