package com.cat.code.crawler.executor.vo;

import com.xuxueli.crawler.annotation.PageFieldSelect;
import com.xuxueli.crawler.annotation.PageSelect;
import com.xuxueli.crawler.conf.XxlCrawlerConf;

/**
 * @Author: lvgang
 * @Time: 2019/11/8 15:38
 * @Email: lvgang@golaxy.cn
 * @Description: todo
 */
@PageSelect(cssQuery = "body")
public class PageVo {
    @PageFieldSelect(cssQuery = "#jd-price", selectType = XxlCrawlerConf.SelectType.TEXT)
    private String data;

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
