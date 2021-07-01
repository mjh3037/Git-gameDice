package com.gamedis.controller;

import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {


	
	@RequestMapping("/member/loginPage")
	public String loginPage() {
		System.out.println("open loginPage");
		return "/member/login";
	}
	
}
