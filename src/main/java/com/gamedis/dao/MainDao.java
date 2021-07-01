package com.gamedis.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.util.DataMap;

@Repository("MainDao")
public class MainDao {

	
	@Autowired
	@Resource(name= "sqlSessionTemplate")
	private SqlSessionTemplate session;
	
	private static String main = "mainMapper";
	
	public int getAttachLength() {
		
		return session.selectOne(main + ".getAttachLength");
	}
	
	
	public List<DataMap> getAttachInfo(String screenType){
		
		return session.selectList(main + ".getAttachInfo", screenType);
	}
	
	
	public List<DataMap> getAttachMain(){
		
		List<DataMap> list = session.selectList(main + ".getAttachMain");
		
		return list;
	}
	
	public List<DataMap>  getAttachSub(String pcode){
		
		List<DataMap> list = session.selectList(main + ".getAttachSub", pcode);
		
		return list;
	}
	
	public List<DataMap> getAttach(String uuid) {
		
		return session.selectList(main + ".getAttach", uuid);
	}
	
	public List<DataMap> getAutoComplete(String value){
		
		return session.selectList(main + ".getAutoComplete", value);
	}
}
