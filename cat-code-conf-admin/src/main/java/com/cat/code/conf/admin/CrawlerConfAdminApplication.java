package com.cat.code.conf.admin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author sunqing 2018-06-08 20:55:06
 */
@SpringBootApplication
@ComponentScan(basePackages="com.cat.code.*")
@MapperScan("com.cat.code.conf.core.dao")
public class CrawlerConfAdminApplication {

	public static void main(String[] args) {
        SpringApplication.run(CrawlerConfAdminApplication.class, args);
	}
}