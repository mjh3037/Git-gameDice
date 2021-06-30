package com.gamedis.dao;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.util.DataMap;


@Repository("uploadDao")
public class UploadDao {
	
	@Autowired
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate session;

	private static String uploadFiles = "uploadFiles";

	public List<DataMap> getUploadList(String pcode){
		
		return session.selectList(uploadFiles + ".getUploadList", pcode);
	}
	
	
	public void insertUploadFile(DataMap uploadFile){
		
		System.out.println(uploadFile.getMap());
		
		try {
//			String code = "C010101";
//			String company= session.selectOne("sample.selectUploadFile", code);
			session.insert(uploadFiles+ ".insertUploadFile", uploadFile.getMap());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteUploadFile(String uuid) {
		
		try {
			session.delete(uploadFiles+ ".deleteUploadFile", uuid);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<DataMap> getProductList(){
		
		return session.selectList(uploadFiles+ ".getProductList");
	}
	
}
