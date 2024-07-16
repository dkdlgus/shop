package com.kook.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kook.shop.domain.BoardVO;
import com.kook.shop.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service // bean으로 자동 등록되기 위해서 필수
//@AllArgsConstructor //멤버변수 1개일 때 사용 (모든 멤버 변수를 갖는 생성자)
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;	
	
	@Override
	public void register(BoardVO board) {
		
		log.info("register..." + board);
		
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get.." + bno);
		
		return mapper.read(bno);
		
	}

	@Override
	public List<BoardVO> getList() {

		log.info("getList....");
		
		return mapper.getList();
		
	}
	

}
