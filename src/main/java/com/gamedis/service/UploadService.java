package com.gamedis.service;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gamedis.dao.UploadDao;
import common.util.DataMap;

@Service
public class UploadService {
	
	@Resource(name="uploadDao") 
	private UploadDao uploadDao;

	public List<DataMap> getUploadList(String pcode){
		
		List<DataMap> list = uploadDao.getUploadList(pcode);
		
		return list;
	}
	
	public void insertUploadFile(DataMap uploadFile) {
		uploadDao.insertUploadFile(uploadFile);
	}
	
	public void deleteUploadFile(String uuid) {
		uploadDao.deleteUploadFile(uuid);
	}
	
	public List<DataMap> getProductList(){
		return uploadDao.getProductList();
	}
	
}
