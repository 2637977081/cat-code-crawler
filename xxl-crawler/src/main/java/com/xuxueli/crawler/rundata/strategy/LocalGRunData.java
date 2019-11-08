package com.xuxueli.crawler.rundata.strategy;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.LinkedBlockingQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.xuxueli.crawler.exception.XxlCrawlerException;
import com.xuxueli.crawler.model.CrawlerTask;
import com.xuxueli.crawler.rundata.GRunData;
import com.xuxueli.crawler.util.UrlUtil;

public class LocalGRunData extends GRunData {
    private static Logger logger = LoggerFactory.getLogger(LocalGRunData.class);

    // url
    private volatile LinkedBlockingQueue<CrawlerTask> unVisitedTaskQueue = new LinkedBlockingQueue<CrawlerTask>();     // 待采集任务池
    private volatile Set<CrawlerTask> visitedTaskSet = Collections.synchronizedSet(new HashSet<CrawlerTask>()); 
	@Override
	public boolean addTask(CrawlerTask task) {
		// TODO Auto-generated method stub
		if (task == null) {
            logger.debug(">>>>>>>>>>> xxl-crawler addTask fail, task is null");
            return false;
		}
        if (!UrlUtil.isUrl(task.getUrl())) {
            logger.debug(">>>>>>>>>>> xxl-crawler addTask fail, link not valid: {}", task.getUrl());
            return false; // check URL格式
        }
        if (visitedTaskSet.contains(task)) {
            logger.debug(">>>>>>>>>>> xxl-crawler addTask fail, task repeate: {}", task.getUrl());
            return false; // check 未访问过
        }
        if (unVisitedTaskQueue.contains(task)) {
            logger.debug(">>>>>>>>>>> xxl-crawler addTask fail, task visited: {}", task.getUrl());
            return false; // check 未记录过
        }
        unVisitedTaskQueue.add(task);
        logger.info(">>>>>>>>>>> xxl-crawler addTask success, link: {}", task.getUrl());
        return true;
	}

	@Override
	public CrawlerTask getTask() {
		// TODO Auto-generated method stub
        CrawlerTask task = null;
        try {
        	task = unVisitedTaskQueue.take();
        } catch (InterruptedException e) {
            throw new XxlCrawlerException("LocalGRunData.getTask interrupted.");
        }
        if (task != null) {
            visitedTaskSet.add(task);
        }
        return task;
	}

	@Override
	public int getTaskNum() {
		// TODO Auto-generated method stub
        return unVisitedTaskQueue.size();
	}

}
