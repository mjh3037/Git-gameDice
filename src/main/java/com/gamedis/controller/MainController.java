package com.gamedis.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gamedis.service.MainService;
import com.gamedis.service.ProductService;

import common.util.CommonUtil;
import common.util.DataMap;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@Autowired
	ProductService productService;
	
	@RequestMapping("/main/open")
	public String mainPageOpen(HttpServletRequest request) {
			System.out.println("openPage..");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("1", "apple");
			map.put("2", "banana");
			map.put("3", "orange");
			CommonUtil.printMap(map);
		return "index";
	}
	
	
	@GetMapping("/main/getAttachMain")
	@ResponseBody
	public DataMap getAttach(){
		System.out.println("attach..");
		
		List<DataMap> list = mainService.getAttachMain();
		int attachCount = mainService.getAttachLength();
		
		DataMap attachInfo = mainService.getAttachInfo(); 
		return attachInfo;
	}
	
	@RequestMapping("/main/getAttachSub")
	@ResponseBody
	public DataMap getAttachSub(HttpServletRequest request){

		String pcode= request.getParameter("pcode");

		List<DataMap> list = mainService.getAttachSub(pcode);
		List<DataMap> product = productService.getProduct(pcode);
		DataMap subScreen = new DataMap();
		
		subScreen.put("list", list);
		subScreen.put("product", product);
		
		return subScreen;
	}
	
	@RequestMapping("/main/getAttach")
	@ResponseBody
	public List<DataMap> getProduct(HttpServletRequest request) {
		
		String uuid = request.getParameter("uuid");
		
		List<DataMap> result = mainService.getAttach(uuid);
		
		return result;
	}
	
	@PostMapping("/main/autocomplete")
	@ResponseBody
	public List<DataMap> getAutoComplete(String value){
	
		List<DataMap> result = mainService.getAutoComplete(value);
		
		for(int i=0; i< result.size(); i++) {
			System.out.println("list= "+ result.get(i));
		}
		System.out.println(result);
		return result;
	}
	
}
