package com.cat.code.crawler.executor.jobhandler;

import com.cat.code.crawler.executor.util.MD5Util;
import com.cat.code.crawler.executor.vo.PageVo;
import com.xuxueli.crawler.XxlCrawler;
import com.xuxueli.crawler.loader.strategy.HtmlUnitPageLoader;
import com.xuxueli.crawler.parser.PageParser;
import com.xuxueli.crawler.util.FileUtil;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.IJobHandler;
import com.xxl.job.core.handler.annotation.JobHandler;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.Base64Utils;
import org.springframework.util.StringUtils;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: lvgang
 * @Time: 2019/10/21 15:42
 * @Email: lvgang@golaxy.cn
 * @Description: todo
 */
@JobHandler(value="testJobHandler")
@Component
public class TestJobHandler extends IJobHandler {

    private static Logger logger = LoggerFactory.getLogger(TestJobHandler.class);


    @Override
    public ReturnT<String> execute(String param) throws Exception {

        Map<String,String> headerMap = new HashMap<>();
        headerMap.put("Accept","*/*");
        headerMap.put("Accept-Encoding","gzip, deflate, br");
        headerMap.put("Accept-Language","zh-CN,zh;q=0.9,en;q=0.8");
        headerMap.put("Access-Control-Request-Headers","content-type");
        headerMap.put("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36");

        // 构造爬虫
        XxlCrawler crawler = new XxlCrawler.Builder()
//                .setUrls("https://image.baidu.com/search/index?tn=baiduimage&ct=201326592&lm=-1&cl=2&ie=gb18030&word=%B0%D9%B6%C8%CD%BC%C6%AC%C3%C0%C5%AE&fr=ala&ala=1&alatpl=adress&pos=0&hs=2&xthttps=111111")
                .setUrls("https://www.bbilibili.com/")
                .setAllowSpread(false)
                .setHeaderMap(headerMap)
                .setPageLoader(new HtmlUnitPageLoader())        // HtmlUnit 版本 PageLoader：支持 JS 渲染
                .setPageParser(new PageParser() {
                    @Override
                    public void parse(Document html, Element pageVoElement, Object pageVo) {
                        Elements elements = html.getElementsByTag("img");
                        for (Element element:elements){

                            String value =  element.attr("src");
                            logger.info("修改之前：{}",value);
                            if(StringUtils.isEmpty(value)){
                                continue;
                            }
                            String link = value;
                            if(value.indexOf("http:")!=0&&value.indexOf("https:")!=0){
                                link = "https:"+value;
                            }
                            logger.info("url:{}",link);
                            try {
                                String filePath = "F:\\data\\images";
                                String fileName = MD5Util.getMd5(link)+".jpg";
                                FileUtil.downFile(link,1000,filePath,fileName);
                            }catch (Exception e){
                                logger.info("error:{}",value);
                                e.printStackTrace();
                            }
                        }

                    }
                })
                .build();

        // 启动
        crawler.start(true);

        return SUCCESS;
    }
}
