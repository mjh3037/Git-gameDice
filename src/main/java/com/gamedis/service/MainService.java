package com.gamedis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gamedis.dao.MainDao;

import common.util.DataMap;

@Service
public class MainService {
	
	@Resource(name = "MainDao")
	private MainDao mainDao;
	
	public int getAttachLength() {
		
		return mainDao.getAttachLength();
	}
	
	public DataMap getAttachInfo(){
		
		
		DataMap data = new DataMap();
	
		String screenType = "M";
		List<DataMap> mainAttach= mainDao.getAttachInfo(screenType);
		screenType = "S";
		List<DataMap> subAttach= mainDao.getAttachInfo(screenType);
		
		data.put("mainAttach", mainAttach);
		data.put("subAttach", subAttach);
		return data;
	}
	
	public List<DataMap> getAttachMain(){
		
		List<DataMap> attach = mainDao.getAttachMain();
		return attach;
	}
	
	public List<DataMap> getAttachSub(String pcode){
		
		List<DataMap> attach = mainDao.getAttachSub(pcode);
		return attach;
	}
	
	public List<DataMap> getAttach(String uuid){
		
		List<DataMap> result = mainDao.getAttach(uuid);
		return result;
	}
	
	public List<DataMap> getAutoComplete(String value){
		
		List<DataMap> list = mainDao.getAutoComplete(value);
		return list;
	}
}
