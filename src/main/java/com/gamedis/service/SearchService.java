package com.gamedis.service;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gamedis.dao.SearchDao;
import com.gamedis.dao.UploadDao;
import common.util.DataMap;

@Service
public class SearchService {
	
	@Resource(name="searchDao") 
	private SearchDao searchDao;

	public List<DataMap> getProductSearchList(String pname){
		
		List<DataMap> result = searchDao.getProductSearchList(pname);
		
		return result;
	}
}
