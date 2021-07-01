package com.gamedis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping("/admin/info")
	public String adminInfoView() {
		System.out.println("add1saassadb");
		return "/adminView";
	}
}
