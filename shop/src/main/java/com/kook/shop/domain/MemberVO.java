package com.kook.shop.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String username;
	private String useremail;
	private String tell;
	private Date regdate;
	private Date updatedate;
	
	private boolean enabled;
	
	private List<AuthVO> authList;
	
}
