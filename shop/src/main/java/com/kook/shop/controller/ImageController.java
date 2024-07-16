package com.kook.shop.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kook.shop.domain.ImageFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/image")
@Log4j
public class ImageController {
	
	@PostMapping(value = "/imageAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<ImageFileDTO>> imageAjaxPost(MultipartFile[] imageFile){
		
		log.info("image ajax post...");
		
		List<ImageFileDTO> list = new ArrayList<>();
		String imageFolder = "C:/upload";
		String imageFolderPath = getFolder();
		
		//전체 경로 폴더
		File imagePath = new File(imageFolder, imageFolderPath);
		
		if(imagePath.exists() == false) {
			imagePath.mkdirs();
		}
		
		for(MultipartFile multipartFile : imageFile) {
			
			ImageFileDTO imageDTO = new ImageFileDTO();
			
			log.info("--------------------------------");
			log.info("image File Name : " + multipartFile.getOriginalFilename());
			log.info("image File Size : " + multipartFile.getSize());
			
			String imageFileName = multipartFile.getOriginalFilename();
			imageFileName.substring(imageFileName.lastIndexOf("/") + 1);
			log.info("only file name : " + imageFileName);
			
			imageDTO.setFilename(imageFileName);
			
			UUID uuid = UUID.randomUUID();
			
			imageFileName = uuid.toString() + "_" + imageFileName;
			
			File saveFile = new File(imagePath, imageFileName);
			
			try {
				multipartFile.transferTo(saveFile);
				
				imageDTO.setUuid(uuid.toString());
				imageDTO.setUploadpath(imageFolderPath);
				
				if(checkImageType(saveFile)) {
					
					imageDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(imagePath, "s_" + imageFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
					
				}
				list.add(imageDTO);
			}
			catch(Exception e) {
				log.error(e.getMessage());
			}
			
		}
		
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/display", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String filename){
		log.info("filename : " + filename);
		
		File file = new File("c:/upload/" + filename);
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			if(contentType == null) {
				return false;
			}
			return contentType.startsWith("image");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
