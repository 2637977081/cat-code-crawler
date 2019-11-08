package com.cat.code.crawler.executor;

import com.cat.code.crawler.executor.jobhandler.TestJobHandler;
import com.cat.code.crawler.executor.util.MD5Util;
import com.xuxueli.crawler.util.FileUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.StringUtils;

/**
 * @Author: lvgang
 * @Time: 2019/11/8 11:49
 * @Email: lvgang@golaxy.cn
 * @Description: todo
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = CatCodeCrawlerExecutor.class)
public class JobHandlerTest {

    private final Logger logger =LoggerFactory.getLogger(JobHandlerTest.class);

    @Autowired
    private TestJobHandler testJobHandler;

    @Test
    public void jobHandlerTest() throws Exception{
        testJobHandler.execute(null);
    }

    @Test
    public void crawlerTest() throws Exception{
        logger.info("测试调用");
        String url = "https://www.bilibili.com/";
        Document document = Jsoup.connect(url).ignoreContentType(true).get();
        Elements elements = document.getElementsByTag("img");
        for (Element element:elements){

            String value =  element.attr("src");
            if(StringUtils.isEmpty(value)){
                continue;
            }
            if(value.indexOf("http:")!=0&&value.indexOf("https:")!=0){
                value = "https:"+value;
            }
            logger.info("url:{}",value);
            try {
                String filePath = "F:\\data\\images";
                String fileName = MD5Util.getMd5(value)+".jpg";
                FileUtil.downFile(value,1000,filePath,fileName);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    @Test
    public void testHttp(){
        String url = "https://image.baidu.com/search/index?tn=baiduimage&ct=201326592&lm=-1&cl=2&ie=gb18030&word=%B0%D9%B6%C8%CD%BC%C6%AC%C3%C0%C5%AE&fr=ala&ala=1&alatpl=adress&pos=0&hs=2&xthttps=111111";
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        CloseableHttpResponse response = null;
        try {
            // 由客户端执行(发送)Get请求
            response = httpClient.execute(httpGet);
            // 从响应模型中获取响应实体
            HttpEntity responseEntity = response.getEntity();
            System.out.println("响应状态为:" + response.getStatusLine());
            if (responseEntity != null) {
                System.out.println("响应内容长度为:" + responseEntity.getContentLength());
                System.out.println("响应内容为:" + EntityUtils.toString(responseEntity));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
