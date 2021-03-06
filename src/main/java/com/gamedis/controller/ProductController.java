package com.gamedis.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gamedis.service.MainService;
import com.gamedis.service.ProductService;

import common.util.DataMap;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;
	
	@Autowired
	MainService mainService;
	
	
	@RequestMapping("/product/getIncludedItems")
	@ResponseBody
	public List<DataMap> getIncludedItems(HttpServletRequest request){
		
		String includeId = request.getParameter("includeId");
		String includeItemsId = productService.getIncludeItemsId(includeId);
		String items[] = includeItemsId.split(",");
		List data= new ArrayList();
		for(int i=0; i<items.length; i++) {
			String item = items[i];
			
			if(item.contains("P")) {
				
				String splitPcode[] = item.split("_");
				List<DataMap> productItem = productService.getProductItemInfo(splitPcode[1]);
				
				System.out.println(productItem);
				data.add(productItem);
			}else {
				String splitIncludeId[] = item.split("_");
				List<DataMap> includItem = productService.getProductCollectionInfo(splitIncludeId[1]);
				
				data.add(includItem);
			}
		}
		
		System.out.println("data:" + data);
		return data;
	}
	
	
	
	
	@RequestMapping("/product/productInfoAdd")
	public void productInfoAdd(HttpServletRequest request) {
		DataMap data = new DataMap();
		
		data.put("includePname", request.getParameter("includePname"));
		data.put("pcode", request.getParameter("productCode"));
		data.put("price", request.getParameter("price"));
		data.put("content", request.getParameter("content"));
		data.put("aboutGame", request.getParameter("aboutGame"));
		data.put("flatForm", request.getParameter("flatForm"));
		data.put("pakageType", request.getParameter("pakageType"));
		
		if(request.getParameter("confirmationCheck").equals("none")) {
			data.put("releasedDate", "0000-00-00");
			data.put("releasedStatus", "Cooming Soon");
		}else {
			data.put("releasedDate", request.getParameter("confirmationCheck"));
			data.put("releasedStatus", "Confirmation");
		}
		
		if(request.getParameter("includeItems").equals("none")) {
			data.put("includeItems", "");
			data.put("includeItemsId", "");
		}else {
			data.put("includeItems", request.getParameter("includeItems"));
			data.put("includeItemsId", request.getParameter("includeItemsId"));
		}
		
		System.out.println(data.getMap());
//		productService.insertProductInfoAdd(data);
	}
	
	
	@RequestMapping("/product/productInfoView")
	public String productInfoUpdate(Model model) {
			
		model.addAttribute("productList",productService.getProductPname());
	
		return "/product/productInfoUpdate";
	}
	
	@RequestMapping("/product/productAjax")
	public void product(Model model) {
		
		System.out.println("..product");
		
		model.addAttribute("companyList",productService.getCompanyList());
	}
	
	@PostMapping("/product/insert")
	public void insertProduct(HttpServletRequest request) {
		
		DataMap params = new DataMap();
		
		params.put("pname", request.getParameter("pname"));
		params.put("companyCode", request.getParameter("companyCode"));
		params.put("lowGenrue", "Action Games");
		params.put("middleGenrue", "");
		params.put("highGenrue", "");
		params.put("flatform", request.getParameter("flatForm"));
		params.put("price", request.getParameter("price"));
		params.put("content", request.getParameter("content"));
		params.put("aboutGame", request.getParameter("aboutGame"));
		params.put("systemMinRequirements", request.getParameter("systemMinRequirements"));
		params.put("systemMaxRequirements", request.getParameter("systemMaxRequirements"));
		params.put("totalArcheive", request.getParameter("totalArcheive"));
		
		if(request.getParameter("confirmationCheck").equals("none")) {
			params.put("releasedDate", "0000-00-00");
			params.put("releasedStatus", "Cooming Soon");
		}else {
			params.put("releasedDate", request.getParameter("confirmationCheck"));
			params.put("releasedStatus", "Confirmation");
		}
//		params.put("confirmationCheck", request.getParameter("confirmationCheck"));
		
		System.out.println("insert :"+ params.getMap());
		productService.insertProduct(params);
	}
	@RequestMapping("/product/productPakageInfo/{idx}")
	public ModelAndView productPakageInfo(@PathVariable("idx") String idx) {
		
		System.out.println("pak!");
		ModelAndView view = new ModelAndView();

		List<DataMap> data = productService.getIncludeProduct(idx);

		view.setViewName("/product/productInfo/");
		view.addObject("list", data.get(0));
		
		return view;
	}
	
	
	@RequestMapping("/product/productInfo/{idx}")
	public ModelAndView productInfo(@PathVariable("idx") String idx) {
		System.out.println("productInfo : " + idx);
			
		ModelAndView view = new ModelAndView();
		List<DataMap> data = new ArrayList<DataMap>();
		String includeId = "";
		if(idx.contains("pak")) {
			
			if(idx.contains("collection")) {
				System.out.println("col");
				String includeIdArray[] = idx.split("_");
				includeId = includeIdArray[2];
				view.setViewName("/product/packageDetails");
				data = productService.getProductCollectionInfo(includeId);
			}else {
				System.out.println("not cal");
				String includeIdArray[] = idx.split("_");
				includeId = includeIdArray[2];
				view.setViewName("/product/productInfo");
				data = productService.getProductPakageInfo(includeId);
			}
			
			
			view.addObject("pak", idx);

		}else {
			view.setViewName("/product/productInfo");
			data = productService.getProduct(idx);
			
		}
		
		view.addObject("list", data.get(0));
		System.out.println(data.get(0));
		return view;
	}
	
	@RequestMapping("/product/highlight")
	@ResponseBody
	public List<DataMap> getHighlight(HttpServletRequest request){
		
		String pcode = request.getParameter("pcode");
		String pak = request.getParameter("pak");
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap logoInfo = new DataMap();

		if(pak!= null) {
		
			String includeIdArray[] = pak.split("_");
			String includeId = includeIdArray[2];
			 list = productService.getProductPakageInfo(includeId);
		}else {
			 list = productService.getProduct(pcode);
		}
		
		System.out.println("list:"+list);
		return list;
	}
	
	@RequestMapping("/product/getLogoInfo")
	@ResponseBody
	public List<DataMap> getLogoInfo(HttpServletRequest request){
		
		String pcode = request.getParameter("pcode");
		String pak = request.getParameter("pak");
		List<DataMap> list = new ArrayList<DataMap>();
		
		if(pak!= null) {
			
			String includeIdArray[] = pak.split("_");
			String includeId = includeIdArray[2];
			 list = productService.getProductPakageLogoInfo(includeId);
		}else {
			 list = productService.getProductLogoInfo(pcode);
		}
		
		return list;
	}
}
