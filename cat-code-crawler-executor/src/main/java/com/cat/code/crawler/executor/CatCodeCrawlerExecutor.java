package com.cat.code.crawler.executor;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * @Author: lvgang
 * @Time: 2019/10/21 15:37
 * @Email: lvgang@golaxy.cn
 * @Description: todo
 */
@SpringBootApplication
@ComponentScan(basePackages="com.cat.code.*")
@MapperScan("com.cat.code.conf.core.dao")
public class CatCodeCrawlerExecutor {
    public static void main(String[] args){
        SpringApplication.run(CatCodeCrawlerExecutor.class);
    }
}
