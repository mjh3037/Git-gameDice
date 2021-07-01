package com.gamedis.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gamedis.service.SearchService;
import com.gamedis.service.UploadService;

import common.util.DataMap;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class SearchController {
	
		@Autowired
		private SearchService searchService;
		
		@RequestMapping("/search/searchForm/{idx}")
		public ModelAndView searForm(@PathVariable("idx") String idx) {
			System.out.println("searchForm:" + idx);
			
			ModelAndView view = new ModelAndView();
			
			view.setViewName("/search/search");
			view.addObject("text", idx);

			return view;
		}
		
		
		@RequestMapping("/search/searchAjax")
		@ResponseBody
		public List<DataMap> searchAjax(HttpServletRequest request){
			
			String text = request.getParameter("text");

			List<DataMap> result = searchService.getProductSearchList(text);

			return result;
		}
}
