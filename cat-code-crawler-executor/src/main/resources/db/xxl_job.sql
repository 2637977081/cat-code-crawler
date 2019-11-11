/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : xxl_job

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 11/11/2019 10:58:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xxl_job_group
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行器名称',
  `order` tinyint(4) NOT NULL DEFAULT 0 COMMENT '排序',
  `address_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xxl_job_group
-- ----------------------------
INSERT INTO `xxl_job_group` VALUES (1, 'xxl-job-executor-sample', '示例执行器', 1, 0, NULL);
INSERT INTO `xxl_job_group` VALUES (2, 'tyc-crawler-executor', '天眼查采集执行器', 1, 0, NULL);
INSERT INTO `xxl_job_group` VALUES (4, 'independent-base-crawler-job-executor', '基础采集工程', 1, 0, NULL);

-- ----------------------------
-- Table structure for xxl_job_info
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务执行CRON',
  `job_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int(11) NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `glue_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime(0) NULL DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint(13) NOT NULL DEFAULT 0 COMMENT '上次调度时间',
  `trigger_next_time` bigint(13) NOT NULL DEFAULT 0 COMMENT '下次调度时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xxl_job_info
-- ----------------------------
INSERT INTO `xxl_job_info` VALUES (1, 1, '0 0 0 * * ? *', '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '', 0, 0, 0);
INSERT INTO `xxl_job_info` VALUES (2, 2, '0 0 23 * * ?', '天眼查从文件获取采集公司', '2019-10-10 11:10:30', '2019-10-10 11:13:59', 'lvgang', '', 'FIRST', 'tycCrawlFromMysqlJobHandler', '{\r\n\"type\":\"file\",\r\n\"key\":\"test\",\r\n\"path\":\"C:/Users/dell/Desktop/新建文本文档.txt\"\r\n}', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-10 11:10:30', '', 0, 0, 0);
INSERT INTO `xxl_job_info` VALUES (3, 2, '0 0 23 * * ?', '天眼查开始采集1-59-1', '2019-10-10 11:15:53', '2019-10-12 17:11:35', 'lvgang', '', 'FIRST', 'tycCrawlFromRedisJobHandler', '{\r\n\"key\":\"companyUpdateCrawler\",\r\n\"level\":\"0\",\r\n\"tokenType\":\"1\",\r\n\"params\":\"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43\"\r\n}', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-10 11:15:53', '', 0, 0, 0);
INSERT INTO `xxl_job_info` VALUES (5, 4, '0 0 23 * * ?', 'url生成', '2019-10-25 16:14:30', '2019-11-08 10:44:05', 'catcoder', '', 'FIRST', 'DappCrawlerJobGenerator', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-10-25 16:14:30', '6', 0, 0, 0);
INSERT INTO `xxl_job_info` VALUES (6, 4, '0 0 23 * * ?', 'url采集', '2019-11-08 10:43:54', '2019-11-08 10:43:54', 'catcoder', '', 'FIRST', 'DappCrawlerJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2019-11-08 10:43:54', '', 0, 0, 0);

-- ----------------------------
-- Table structure for xxl_job_lock
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock`  (
  `lock_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xxl_job_lock
-- ----------------------------
INSERT INTO `xxl_job_lock` VALUES ('schedule_lock');

-- ----------------------------
-- Table structure for xxl_job_log
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `trigger_time` datetime(0) NULL DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
  `trigger_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '调度-日志',
  `handle_time` datetime(0) NULL DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int(11) NOT NULL COMMENT '执行-状态',
  `handle_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行-日志',
  `alarm_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `I_trigger_time`(`trigger_time`) USING BTREE,
  INDEX `I_handle_code`(`handle_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xxl_job_log
-- ----------------------------
INSERT INTO `xxl_job_log` VALUES (24, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:14:34', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 16:14:35', 500, 'java.lang.NullPointerException\r\n	at com.cat.code.crawler.executor.jobhandler.TestJobHandler.execute(TestJobHandler.java:32)\r\n	at com.xxl.job.core.thread.JobThread.run(JobThread.java:152)\r\n', 1);
INSERT INTO `xxl_job_log` VALUES (25, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 16:17:02', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (26, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 16:17:59', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (27, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:18:18', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 16:18:35', 500, 'java.lang.NullPointerException\r\n	at com.cat.code.crawler.executor.jobhandler.TestJobHandler.execute(TestJobHandler.java:32)\r\n	at com.xxl.job.core.thread.JobThread.run(JobThread.java:152)\r\n', 1);
INSERT INTO `xxl_job_log` VALUES (28, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:31:54', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 16:31:54', 500, 'java.lang.NullPointerException\r\n	at com.cat.code.crawler.executor.jobhandler.TestJobHandler.execute(TestJobHandler.java:32)\r\n	at com.xxl.job.core.thread.JobThread.run(JobThread.java:152)\r\n', 1);
INSERT INTO `xxl_job_log` VALUES (29, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 16:32:17', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (30, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:32:27', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 16:34:16', 500, 'java.lang.NullPointerException\r\n	at com.cat.code.crawler.executor.jobhandler.TestJobHandler.execute(TestJobHandler.java:32)\r\n	at com.xxl.job.core.thread.JobThread.run(JobThread.java:152)\r\n', 1);
INSERT INTO `xxl_job_log` VALUES (31, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:37:25', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 16:41:43', 500, 'java.lang.NullPointerException\r\n	at com.cat.code.crawler.executor.jobhandler.TestJobHandler.execute(TestJobHandler.java:32)\r\n	at com.xxl.job.core.thread.JobThread.run(JobThread.java:152)\r\n', 1);
INSERT INTO `xxl_job_log` VALUES (32, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 16:58:12', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:00:21', 500, '人为操作主动终止:', 1);
INSERT INTO `xxl_job_log` VALUES (33, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 17:00:04', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:00:05', 500, '', 1);
INSERT INTO `xxl_job_log` VALUES (34, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 17:02:16', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:02:16', 500, '', 1);
INSERT INTO `xxl_job_log` VALUES (35, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 17:03:58', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (36, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 17:05:32', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (37, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 17:06:24', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:11:39', 500, '人为操作主动终止:job thread aleady killed.', 1);
INSERT INTO `xxl_job_log` VALUES (38, 4, 5, NULL, 'testJobHandler', '', NULL, 0, '2019-10-25 17:11:24', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (39, 1, 1, NULL, 'demoJobHandler', '', NULL, 0, '2019-10-25 17:11:46', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (40, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 17:11:55', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:11:56', 500, '', 1);
INSERT INTO `xxl_job_log` VALUES (41, 4, 5, '172.30.128.51:8101', 'testJobHandler', '', NULL, 0, '2019-10-25 17:13:29', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.51<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.51:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.51:8101<br>code：200<br>msg：null', '2019-10-25 17:13:35', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (42, 4, 5, NULL, 'testJobHandler', '', NULL, 0, '2019-10-28 14:14:19', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (43, 4, 5, '172.30.128.56:8101', 'testJobHandler', '', NULL, 0, '2019-10-28 14:14:46', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.56:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.56:8101<br>code：200<br>msg：null', '2019-10-28 14:14:48', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (44, 4, 5, '172.30.128.56:8101', 'testJobHandler', '', NULL, 0, '2019-10-28 15:08:14', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.56:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.56:8101<br>code：200<br>msg：null', '2019-10-28 15:08:16', 500, '', 1);
INSERT INTO `xxl_job_log` VALUES (45, 4, 5, '172.30.128.56:8101', 'testJobHandler', '', NULL, 0, '2019-10-28 15:09:04', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.56:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.56:8101<br>code：200<br>msg：null', NULL, 0, NULL, 0);
INSERT INTO `xxl_job_log` VALUES (46, 4, 5, '172.30.128.56:8101', 'testJobHandler', '', NULL, 0, '2019-10-28 15:17:58', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.56:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.56:8101<br>code：200<br>msg：null', '2019-10-28 15:35:55', 500, '人为操作主动终止:job thread aleady killed.', 1);
INSERT INTO `xxl_job_log` VALUES (47, 4, 5, NULL, 'testJobHandler', '', NULL, 0, '2019-10-28 15:35:46', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (48, 4, 5, '172.30.128.56:8101', 'testJobHandler', '', NULL, 0, '2019-10-28 15:36:06', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.56<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.56:8101]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.56:8101<br>code：200<br>msg：null', NULL, 0, NULL, 0);
INSERT INTO `xxl_job_log` VALUES (49, 4, 5, NULL, 'DappCrawlerJobGenerator', '', NULL, 0, '2019-11-08 10:44:17', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (50, 4, 5, '172.30.128.96:1161', 'DappCrawlerJobGenerator', '', NULL, 0, '2019-11-08 10:45:55', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.96:1161]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.96:1161<br>code：200<br>msg：null', '2019-11-08 10:48:33', 500, '人为操作主动终止:job thread aleady killed.', 1);
INSERT INTO `xxl_job_log` VALUES (51, 4, 5, '172.30.128.96:1161', 'DappCrawlerJobGenerator', '', NULL, 0, '2019-11-08 10:48:41', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.96:1161]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.96:1161<br>code：200<br>msg：null', '2019-11-08 10:57:31', 500, '人为操作主动终止:job thread aleady killed.', 1);
INSERT INTO `xxl_job_log` VALUES (52, 4, 5, NULL, 'DappCrawlerJobGenerator', '', NULL, 0, '2019-11-08 10:57:40', 500, '任务触发类型：手动触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：null<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>调度失败：执行器地址为空<br><br>', NULL, 0, NULL, 1);
INSERT INTO `xxl_job_log` VALUES (53, 4, 5, '172.30.128.96:1161', 'DappCrawlerJobGenerator', '', NULL, 0, '2019-11-08 10:57:57', 200, '任务触发类型：手动触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.96:1161]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.96:1161<br>code：200<br>msg：null', '2019-11-08 12:56:52', 200, '<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发子任务<<<<<<<<<<< </span><br>1/1 [任务ID=6], 触发成功, 触发备注: null <br>', 0);
INSERT INTO `xxl_job_log` VALUES (54, 4, 6, '172.30.128.96:1161', 'DappCrawlerJobHandler', '', NULL, 0, '2019-11-08 12:56:52', 200, '任务触发类型：父任务触发<br>调度机器：172.30.128.96<br>执行器-注册方式：自动注册<br>执行器-地址列表：[172.30.128.96:1161]<br>路由策略：第一个<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：172.30.128.96:1161<br>code：200<br>msg：null', NULL, 0, NULL, 0);

-- ----------------------------
-- Table structure for xxl_job_logglue
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'GLUE备注',
  `add_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xxl_job_registry
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `registry_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `registry_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i_g_k_v`(`registry_group`, `registry_key`, `registry_value`) USING BTREE,
  INDEX `i_u`(`update_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xxl_job_user
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_user`;
CREATE TABLE `xxl_job_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` tinyint(4) NOT NULL COMMENT '角色：0-普通用户、1-管理员',
  `permission` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xxl_job_user
-- ----------------------------
INSERT INTO `xxl_job_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
