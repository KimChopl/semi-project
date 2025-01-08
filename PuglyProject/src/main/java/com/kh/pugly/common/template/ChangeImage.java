package com.kh.pugly.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.exception.FailDeleteObjectException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class ChangeImage {
	
	private final ServletContext c;
	
	public List<Image> changeImgName(MultipartFile[] multi) {
		List<Image> imgList = new ArrayList();
		int imgLevel = 2;
		for(int i = 0; i < multi.length; i++) {
			String originName = multi[i].getOriginalFilename();
			
			if(!!!originName.equals("")) {
				List<MultipartFile> list = new ArrayList<MultipartFile>();
					String subOrigin = originName.substring(originName.indexOf('.'));
					String currentTime = new SimpleDateFormat("yyMMddHHmm").format(new Date());
					int randNo = (int)(Math.random() * 12354) + 12354; // 수식 진행 순서 파악하기
					String changeName = "pugly" + randNo + currentTime + subOrigin;
					String filePath = "resources/farm-img/";
					String savePath = c.getRealPath(filePath);
					//log.info("{} : {}", changeName, savePath);
					Image img = Image.builder().originImgName(originName).changeImgName(changeName).imgPath(filePath).build();
					imgList.add(img);
					//log.info("{}", img);
					try {
						multi[i].transferTo(new File(savePath + changeName));
						break;
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
				}
				
			}
		for(int i = 0; i < imgList.size(); i++) {
			if(i == 0) {
				imgLevel = 1;
			}
			imgList.get(i).setImgLevel(imgLevel);
		}
		return imgList;
	}
	
	public void deleteImage(List<Image> img) {
		if(img != null && !(img.isEmpty())) {
			
			for(int i = 0; i < img.size(); i++) {
				
				if(!(new File(c.getRealPath(img.get(i).getImgPath()) + img.get(i).getChangeImgName()).delete())) {
					
					throw new FailDeleteObjectException("사진 삭제 실패");
				} 
			}
		}
		
	}
	
	public void deleteImageOne(Image img) {
		log.info("{}", c.getRealPath(img.getImgPath()) + img.getChangeImgName());
		if(!(new File(c.getRealPath(img.getImgPath()) + img.getChangeImgName()).delete())) {
			
			throw new FailDeleteObjectException("사진 삭제 실패");
		} 
	}
	
}
