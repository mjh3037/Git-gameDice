package com.gamedis.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gamedis.service.UploadService;

import common.util.DataMap;

@Controller
public class AdminController {

	@Autowired
	private UploadService uploadService;
	
	@RequestMapping("/admin/info")
	public String adminInfoView() {
		
		return "/adminView";
	}
	
	@RequestMapping("/admin/getIncludeProductList")
	@ResponseBody
	public List<DataMap> getIncludeProductList(HttpServletRequest request) {
		
		String pcode = request.getParameter("pcode");
		
		List<DataMap> result = uploadService.getUploadIncludeProduct(pcode);
		return result;
	}
}
