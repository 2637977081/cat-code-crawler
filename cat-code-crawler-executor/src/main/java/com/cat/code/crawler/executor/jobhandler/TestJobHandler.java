package com.cat.code.crawler.executor.jobhandler;

import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.IJobHandler;
import com.xxl.job.core.handler.annotation.JobHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

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
        logger.info("测试调用");

        return SUCCESS;
    }
}
