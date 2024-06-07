package com.kook.shop.service;

import java.util.List;

import com.kook.shop.domain.BoardVO;

public interface BoardService {
	
	// 게시글 등록
	public void register(BoardVO board);
	
	// 특정번호 게시판 보기.
	public BoardVO get(Long bno);
	
	// 리스트
	public List<BoardVO> getList();
	
}
