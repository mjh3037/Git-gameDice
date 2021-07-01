package com.gamedis.dao;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.util.DataMap;


@Repository("searchDao")
public class SearchDao {
	
	@Autowired
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate session;

	private static String search = "search";


	public List<DataMap> getProductSearchList(String pname){
		
		
		return session.selectList(search + ".getProductSearchList", pname);
	}
	
}
