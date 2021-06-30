package com.gamedis.service;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.gamedis.dao.ProductDao;

import common.util.DataMap;

@Service
public class ProductService {

	@Resource(name = "productDao")
	private ProductDao productDao;

	
	
	public List<DataMap> getIncludeProduct(String pcode){
		
		return productDao.getIncludeProduct(pcode);
	}
	
	public void insertProductInfoAdd(DataMap data) {
		productDao.insertProductInfoAdd(data);
	}
	
	public List<DataMap> getProductPname(){
		
		return productDao.getProductPname();
	}
	
	public List<DataMap> getProductPakageInfo(String includeId){
		return productDao.getIncludeProduct(includeId);
	}
	
	public List<DataMap> getProduct(String pcode){
		System.out.println("serviec:"  + pcode);
		return productDao.getProduct(pcode);
	}
	
	public void insertProduct(DataMap params) {
		
		productDao.insertProduct(params);
	}
	
	public String getCompanyCode(String cname) {
		
		return productDao.getCompanyCode(cname);
	}
	
	public List<DataMap> getCompanyList(){
		
		return productDao.getCompanyList();
	}
	
}
