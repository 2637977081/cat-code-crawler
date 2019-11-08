package com.xuxueli.crawler.model;

import java.util.Objects;

/**
 * 
 * @author sunqing 2019-08-28
 *
 */
public class CrawlerTask {
	private String url;
	private String extemplate;
	public CrawlerTask() {
		
	}
	public CrawlerTask(String url, String extemplate) {
		this.url = url;
		this.extemplate = extemplate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getExtemplate() {
		return extemplate;
	}
	public void setExtemplate(String extemplate) {
		this.extemplate = extemplate;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass()) return false;
		
		CrawlerTask task = (CrawlerTask)obj;
		return Objects.equals(this.url, task.url) && Objects.equals(this.extemplate, task.extemplate);
	}
	
	@Override
    public int hashCode() {
        return Objects.hash(url, extemplate);
    }
	
	
	@Override
	public String toString() {
		return "CrawlerTask{" + 
				"url=" + url + 
				", extemplate=" + extemplate +
				"}";
	}
	public static void main(String[] args){
		CrawlerTask t1 = new CrawlerTask("1", "2");
		CrawlerTask t2 = new CrawlerTask("1", "2");
		System.out.println(t1.equals(t2));
		System.out.println(t2.toString());
	}
}
