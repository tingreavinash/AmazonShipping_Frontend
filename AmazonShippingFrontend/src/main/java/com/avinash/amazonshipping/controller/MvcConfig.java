package com.avinash.amazonshipping.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@Controller
public class MvcConfig {
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/user")
	public String home() {
		return "user";
	}
	@GetMapping("/admin")
	public String hello() {
		return "admin";
	}
	@GetMapping("/index")
	public String login() {
		return "index";
	}
	
}