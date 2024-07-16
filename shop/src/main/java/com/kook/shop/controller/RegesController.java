package com.kook.shop.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kook.shop.domain.ListImageVO;
import com.kook.shop.domain.ListVO;
import com.kook.shop.service.ListService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reges")
@Log4j
@AllArgsConstructor
public class RegesController {
	
	private ListService LService;
	
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE + ";charset=UTF8" })
	public ResponseEntity<String> create(@RequestBody ListVO vo){
		log.info("ListVO : " + vo);
		
		if(vo.getImageList() != null) {
			vo.getImageList().forEach(Image -> log.info(Image));
		}
		int insertCount = LService.register(vo);
		log.info("Insert Count : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<ListVO>> getList(){
		
		log.info("getList...");
		
		return new ResponseEntity<>(LService.getList(), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ListVO> get(@PathVariable("rno") Long rno){
		
		log.info("get: " + rno);
		
		return new ResponseEntity<>(LService.get(rno), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE + ";charset=UTF8"})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		
		log.info("remove: " + rno);
		
		List<ListImageVO> imageList = LService.getImageList(rno);
		
		deleteFiles(imageList);
		
		return LService.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}",
			consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE + ";charset=UTF8"})
	public ResponseEntity<String> modify(@RequestBody ListVO vo, @PathVariable("rno") Long rno) {
		
		System.out.println("kook");
		vo.setRno(rno);
		
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		
		return LService.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	private void deleteFiles(List<ListImageVO> imageList) {
		
		if(imageList == null || imageList.size() == 0) {
			return;
		}
		
		log.info("delete image files........");
		log.info(imageList);
		
		imageList.forEach(image -> {
			try {
				Path file = Paths.get(
						"C:/upload/" + image.getUploadpath() + "/" + image.getUuid() + "_" + image.getFilename());
				
				Files.deleteIfExists(file); //파일 존재시 삭제
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:/upload/" + image.getUploadpath() + "/s_" + image.getUuid() + "_"
							+ image.getFilename());
					
					Files.delete(thumbNail);
				}
			}
			catch(Exception e) {
				log.info("delete file error" + e.getMessage());
			}
		});
	}
	
}
