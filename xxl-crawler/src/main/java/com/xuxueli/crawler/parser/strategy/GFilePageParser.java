package com.xuxueli.crawler.parser.strategy;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.xuxueli.crawler.parser.PageParser;

public abstract class GFilePageParser extends PageParser {

    @Override
    public void parse(Document html, Element pageVoElement, Object pageVo) {
        // TODO，not parse page, output page source
    }
    
    /**
     * @param url
     * @param path
     */
    public abstract void parse(String url, String path);
}
