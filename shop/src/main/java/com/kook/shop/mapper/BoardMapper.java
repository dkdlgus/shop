package com.kook.shop.mapper;

import java.util.List;

import com.kook.shop.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public Integer insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
}
