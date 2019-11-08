package com.cat.code.crawler.executor;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

/**
 * @Author: lvgang
 * @Time: 2019/10/21 15:37
 * @Email: lvgang@golaxy.cn
 * @Description: todo
 */
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class,HibernateJpaAutoConfiguration.class})
@ComponentScan(basePackages="com.cat.code.*")
public class CatCodeCrawlerExecutor {
    public static void main(String[] args){
        SpringApplication.run(CatCodeCrawlerExecutor.class);
    }
}
