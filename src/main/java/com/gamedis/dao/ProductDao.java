package com.gamedis.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.util.DataMap;

@Repository("productDao")
public class ProductDao {

	@Autowired
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate session;
	
	private static String productPath= "product";
	
	
	public List<DataMap> getIncludeProduct(String pcode){
		
		return session.selectList(productPath + ".getIncludeProduct", pcode);
	}
	
	public void insertProductInfoAdd(DataMap data) {
		
		System.out.println("Dao:"+data.getMap());
		session.insert(productPath + ".insertProductInfoAdd", data.getMap());
		
	}
	
	
	public List<DataMap> getProductPname(){
		
		return session.selectList(productPath + ".getProductPname");
	}
	
	public List<DataMap> getProductPakageInfo(String includeId){
		
		return session.selectList(productPath + ".getProductPakageInfo", includeId);
	}
	
	public List<DataMap> getProduct(String pcode) {
		return session.selectList(productPath + ".getProduct", pcode);
	}
	
	public void insertProduct(DataMap params) {
		System.out.println("insertdao..");
		
		try {
			session.insert(productPath + ".insertProduct", params.getMap());
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String getCompanyCode(String cname) {
		
		return session.selectOne(productPath + ".getCompanyCode", cname);
	}
	
	
	public List<DataMap> getCompanyList(){
	
		
		return session.selectList(productPath + ".getCompanyList");
	}
}
