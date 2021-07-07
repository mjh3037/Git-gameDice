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
	
	public String getIncludeItemsId(String includeId) {
		
		return productDao.getIncludeItemsId(includeId);
	}
	
	public List<DataMap> getIncludeProduct(String pcode){
		
		return productDao.getIncludeProduct(pcode);
	}
	
	public void insertProductInfoAdd(DataMap data) {
		productDao.insertProductInfoAdd(data);
	}
	
	public List<DataMap> getProductPname(){
		
		return productDao.getProductPname();
	}
	
	public List<DataMap> getProductPakageLogoInfo(String includeId) {
		
		return productDao.getProductPakageLogoInfo(includeId);
	}
	
	public List<DataMap> getProductCollectionInfo(String includeId){
		return productDao.getProductCollectionInfo(includeId);
	}
	
	public List<DataMap> getProductPakageInfo(String includeId){
		return productDao.getProductPakageInfo(includeId);
	}
	
	public List<DataMap> getProductLogoInfo(String includeId) {
		
		return productDao.getProductLogoInfo(includeId);
	}
	
	public List<DataMap> getProduct(String pcode){
		System.out.println("serviec:"  + pcode);
		return productDao.getProduct(pcode);
	}
	
	public List<DataMap> getProductItemInfo(String pcode) {
		return productDao.getProductItemInfo(pcode);
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
