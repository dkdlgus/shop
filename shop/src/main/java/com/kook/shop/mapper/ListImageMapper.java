package com.kook.shop.mapper;

import java.util.List;

import com.kook.shop.domain.ListImageVO;

public interface ListImageMapper {
	
	public void insert(ListImageVO vo);
	
	public void delete(String uuid);
	
	public List<ListImageVO> findByRno(Long rno);
	
	public void deleteAll(Long rno);
	
	public List<ListImageVO> getOldFiles();
}
