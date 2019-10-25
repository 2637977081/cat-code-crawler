package com.cat.code.crawler.executor.jobhandler;

import com.cat.code.conf.core.core.model.XxlConfNode;
import com.cat.code.conf.core.dao.XxlConfNodeDao;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.IJobHandler;
import com.xxl.job.core.handler.annotation.JobHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private XxlConfNodeDao xxlConfNodeDao;

    @Override
    public ReturnT<String> execute(String param) throws Exception {
        logger.info("测试调用");
        XxlConfNode xxlConfNode =  xxlConfNodeDao.load("dev","test1.key01");
        if(xxlConfNode==null){
            return FAIL;
        }
        String task = xxlConfNode.getValue();
        String title = xxlConfNode.getTitle();
        logger.info(task+"-"+title);
        return SUCCESS;
    }
}
