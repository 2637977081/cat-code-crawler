package com.xuxueli.crawler.rundata;

import com.xuxueli.crawler.model.CrawlerTask;

/**
 * GolaxyRunData
 * @author sunqing 2019-08-28
 *
 */
public abstract class GRunData {

    /**
     * add task
     *
     * @param task
     * @return boolean
     */
    public abstract boolean addTask(CrawlerTask task);

    /**
     * get task
     *
     * @return CrawlerTask
     */
    public abstract CrawlerTask getTask();

    /**
     * get task num
     *
     * @return int
     */
    public abstract int getTaskNum();
}
