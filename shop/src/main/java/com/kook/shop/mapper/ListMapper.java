package com.kook.shop.mapper;

import java.util.List;

import com.kook.shop.domain.ListVO;

public interface ListMapper {
	
	public int insert(ListVO vo);
	
	public ListVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ListVO shopList);
	
	public ListVO getBySname(String sname);
	
	public List<ListVO> getList();
}
