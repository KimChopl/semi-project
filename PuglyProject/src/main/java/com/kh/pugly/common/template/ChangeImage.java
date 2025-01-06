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

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class ChangeImage {
	
	private final ServletContext c;
	
	public List<Image> changeImgName(MultipartFile[] multi) {
		List<Image> imgList = new ArrayList();
		//log.info("{}", multi.length);
		if(multi == null) {
			return null;
		}
		int imgLevel = 2;
		for(int i = 0; i < multi.length; i++) {
			if(i == 0) {
				imgLevel = 1;
			} else {
				imgLevel = 2;
			}
			String originName = multi[i].getOriginalFilename();
			
			if(!!!originName.equals("")) {
				System.out.println(imgLevel);
				String subOrigin = originName.substring(originName.indexOf('.'));
				String currentTime = new SimpleDateFormat("yyMMddHHmm").format(new Date());
				int randNo = (int)(Math.random() * 12354) + 12354; // 수식 진행 순서 파악하기
				String changeName = "pugly" + randNo + currentTime + subOrigin;
				String filePath = "resources/farm-img/";
				String savePath = c.getRealPath(filePath);
				//log.info("{} : {}", changeName, savePath);
				Image img = Image.builder().originImgName(originName).changeImgName(changeName).imgPath(filePath).imgLevel(imgLevel).build();
				imgList.add(img);
				//log.info("{}", img);
				try {
					multi[i].transferTo(new File(savePath + changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return imgList;
	}
	
	public void deleteImage(List<Image> img) {
		
		for(int i = 0; i < img.size(); i++) {
			
			new File(img.get(i).getImgPath() + img.get(i).getChangeImgName()).delete();
		}
		
	}
	
}
