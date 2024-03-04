package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class DemoApplication {
	@Autowired
	private Environment environment;
	@RequestMapping("/")
	public String home() {
		return "Hello World! ##"+ environment.getProperty("current.text");
	}
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
