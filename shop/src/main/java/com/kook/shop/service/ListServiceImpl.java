package com.kook.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kook.shop.domain.ListImageVO;
import com.kook.shop.domain.ListVO;
import com.kook.shop.mapper.ListImageMapper;
import com.kook.shop.mapper.ListMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class ListServiceImpl implements ListService {
	
	@Setter(onMethod_ = @Autowired)
	private ListMapper Lmapper;
	
	@Setter(onMethod_ = @Autowired)
	private ListImageMapper Imapper;
	
	@Transactional
	@Override
	public int register(ListVO vo) {
		
		log.info("register..." + vo);
		
		int result = Lmapper.insert(vo); // 상품 정보 등록 및 rno 값 생성
	    
	    // 생성된 rno 값을 가져옴
	    Long rno = vo.getRno();
	    log.info("Generated rno: " + rno);
		
		vo.getImageList().forEach(Image -> {
			Image.setRno(rno);
			Imapper.insert(Image);
		});
		
		return result;
		
	}

	@Override
	public ListVO get(Long rno) {
	    ListVO listVO = Lmapper.read(rno);
	    listVO.setImageList(Imapper.findByRno(rno)); // 이미지 리스트 추가
	    return listVO;
	}

	@Override
	public int modify(ListVO vo) {
		
		log.info("modify...." + vo);
		
		Imapper.deleteAll(vo.getRno());
		
		int updateCount = Lmapper.update(vo);
		
		if(vo.getImageList() != null && vo.getImageList().size() > 0) {
			vo.getImageList().forEach(image -> {
				image.setRno(vo.getRno());
				Imapper.insert(image);
			});
		}
		
		return updateCount;
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove..." + rno);
		
		Imapper.deleteAll(rno);
		
		return Lmapper.delete(rno);
	}
	
	@Override
    public List<ListVO> getList() {
        log.info("getList...");
        List<ListVO> list = Lmapper.getList();
        list.forEach(vo -> {
            List<ListImageVO> imageList = Imapper.findByRno(vo.getRno());
            vo.setImageList(imageList);
        });
        return list;
    }
	
	@Override
	public List<ListImageVO> getImageList(Long rno){
		
		log.info("get Image List ... " + rno);
		
		return Imapper.findByRno(rno);
	}

}
