package com.kook.shop.service;

import java.util.List;

import com.kook.shop.domain.ListImageVO;
import com.kook.shop.domain.ListVO;

public interface ListService {
	
	//상품 등록
	public int register(ListVO vo);
	
	//상품 확인
	public ListVO get(Long rno);
	
	//상품 수정
	public int modify(ListVO vo);
	
	//상품 삭제
	public int remove(Long rno);
	
	//상품 리스트
	public List<ListVO> getList();
	
	//상품권 이미지 리스트
	public List<ListImageVO> getImageList(Long rno);
	
}
