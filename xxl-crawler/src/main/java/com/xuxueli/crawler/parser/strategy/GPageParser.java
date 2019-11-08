package com.xuxueli.crawler.parser.strategy;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.xuxueli.crawler.model.PageRequest;
import com.xuxueli.crawler.parser.PageParser;

/**
 * 
 * @author sunqing 2019-08-28
 *
 */
public abstract class GPageParser  extends PageParser {

    @Override
    public void parse(Document html, Element pageVoElement, Object pageVo) {
        // TODO，not parse page, output page source
    }	

    /**
     * parse pageVo
     *
     * @param url               page url
     * @param pageSource     	page data
     * @param extemplate        page extract template 
     */
    public abstract void parse(String url, String pageSource, String extemplate);
}
