package com.cat.code.conf.admin.service.impl;


import com.cat.code.conf.admin.service.IXxlWConfNodeService;
import com.cat.code.conf.admin.util.ReturnT;
import com.cat.code.conf.core.dao.*;
import com.cat.code.conf.core.model.*;
import com.cat.code.conf.core.util.JacksonUtil;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author sunqing
 *
 */

@Service
public class XxlWConfNodeServiceImpl implements IXxlWConfNodeService, InitializingBean, DisposableBean {
	private static Logger logger = LoggerFactory.getLogger(XxlWConfNodeServiceImpl.class);


	@Resource
	private XxlWConfNodeDao xxlWConfNodeDao;
	@Resource
	private XxlConfProjectDao xxlConfProjectDao;
	@Resource
	private XxlWConfNodeLogDao xxlWConfNodeLogDao;
	@Resource
	private XxlConfEnvDao xxlConfEnvDao;
	@Resource
	private XxlConfNodeDao xxlConfNodeDao;

	@Override
	public boolean ifHasProjectPermission(XxlConfUser loginUser, String loginEnv, String appname){
		if (loginUser.getPermission() == 1) {
			return true;
		}
		if (ArrayUtils.contains(StringUtils.split(loginUser.getPermissionData(), ","), (appname.concat("#").concat(loginEnv)) )) {
			return true;
		}
		return false;
	}

	@Override
	public Map<String,Object> pageList(int offset,
									   int pagesize,
									   String appname,
									   String sitename,
									   XxlConfUser loginUser,
									   String loginEnv) {

		// project permission
		if (StringUtils.isBlank(loginEnv) || StringUtils.isBlank(appname) || !ifHasProjectPermission(loginUser, loginEnv, appname)) {
			//return new ReturnT<String>(500, "您没有该项目的配置权限,请联系管理员开通");
			Map<String, Object> emptyMap = new HashMap<String, Object>();
			emptyMap.put("data", new ArrayList<>());
			emptyMap.put("recordsTotal", 0);
			emptyMap.put("recordsFiltered", 0);
			return emptyMap;
		}

		// xxlWConfNode in mysql
		List<XxlWConfNode> data = xxlWConfNodeDao.pageList(offset, pagesize, loginEnv, appname, sitename);
		int list_count = xxlWConfNodeDao.pageListCount(offset, pagesize, loginEnv, appname, sitename);

		// package result
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("data", data);
		maps.put("recordsTotal", list_count);		// 总记录数
		maps.put("recordsFiltered", list_count);	// 过滤后的总记录数
		return maps;

	}

	@Override
	public ReturnT<String> delete(String key, XxlConfUser loginUser, String loginEnv) {
		if (StringUtils.isBlank(key)) {
			return new ReturnT<String>(500, "参数缺失");
		}
		XxlWConfNode existNode = xxlWConfNodeDao.load(loginEnv, key);
		if (existNode == null) {
			return new ReturnT<String>(500, "参数非法");
		}

		// project permission
		if (!ifHasProjectPermission(loginUser, loginEnv, existNode.getAppname())) {
			return new ReturnT<String>(500, "您没有该项目的配置权限,请联系管理员开通");
		}

		xxlWConfNodeDao.delete(loginEnv, key);
		xxlWConfNodeLogDao.deleteTimeout(loginEnv, key, 0);

		return ReturnT.SUCCESS;
	}


	@Override
	public ReturnT<String> add(XxlWConfNode xxlWConfNode, XxlConfUser loginUser, String loginEnv) {

		// valid
		if (StringUtils.isBlank(xxlWConfNode.getAppname())) {
			return new ReturnT<String>(500, "AppName不可为空");
		}

		// project permission
		if (!ifHasProjectPermission(loginUser, loginEnv, xxlWConfNode.getAppname())) {
			return new ReturnT<String>(500, "您没有该项目的配置权限,请联系管理员开通");
		}

		// valid group
		XxlConfProject group = xxlConfProjectDao.load(xxlWConfNode.getAppname());
		if (group==null) {
			return new ReturnT<String>(500, "AppName非法");
		}

		// valid env
		if (StringUtils.isBlank(xxlWConfNode.getEnv())) {
			return new ReturnT<String>(500, "配置Env不可为空");
		}
		XxlConfEnv xxlConfEnv = xxlConfEnvDao.load(xxlWConfNode.getEnv());
		if (xxlConfEnv == null) {
			return new ReturnT<String>(500, "配置Env非法");
		}

		// valid key
		if (StringUtils.isBlank(xxlWConfNode.getKey())) {
			return new ReturnT<String>(500, "配置Key不可为空");
		}
		xxlWConfNode.setKey(xxlWConfNode.getKey().trim());

		XxlWConfNode existNode = xxlWConfNodeDao.load(xxlWConfNode.getEnv(), xxlWConfNode.getKey());
		if (existNode != null) {
			return new ReturnT<String>(500, "配置Key已存在，不可重复添加");
		}
		if (!xxlWConfNode.getKey().startsWith(xxlWConfNode.getAppname())) {
			return new ReturnT<String>(500, "配置Key格式非法");
		}

		// valid sitename
		if (StringUtils.isBlank(xxlWConfNode.getSitename())) {
			return new ReturnT<String>(500, "网站名不可为空");
		}
		existNode = xxlWConfNodeDao.loadBySiteName(xxlWConfNode.getEnv(), xxlWConfNode.getSitename());
		if (existNode != null) {
			return new ReturnT<String>(500, "配置网站已存在，[key="+existNode.getKey()+", sitename="+existNode.getSitename()+", domain="+existNode.getDomain()+"]");
		}
		
		// valid domain
		if (StringUtils.isBlank(xxlWConfNode.getDomain())) {
			return new ReturnT<String>(500, "网站域名不可为空");
		}
		existNode = xxlWConfNodeDao.loadByDomain(xxlWConfNode.getEnv(), xxlWConfNode.getDomain());
		if (existNode != null) {
			return new ReturnT<String>(500, "配置域名已存在，[key="+existNode.getKey()+", sitename="+existNode.getSitename()+", domain="+existNode.getDomain()+"]");
		}
		
		// value force null to ""
		if (xxlWConfNode.getAttributes() == null) {
			xxlWConfNode.setAttributes("");
		} else {
			if (!JacksonUtil.jsonValid(xxlWConfNode.getAttributes())) {
				return new ReturnT<String>(500, "属性值格式必须为JSON格式！");
			}
		}

		// add node
		xxlWConfNodeDao.insert(xxlWConfNode);

		// node log
		XxlWConfNodeLog nodeLog = new XxlWConfNodeLog();
		nodeLog.setEnv(xxlWConfNode.getEnv());
		nodeLog.setKey(xxlWConfNode.getKey());
		nodeLog.setSitename(xxlWConfNode.getSitename());
		nodeLog.setDomain(xxlWConfNode.getDomain());
		nodeLog.setAttributes(xxlWConfNode.getAttributes());
		nodeLog.setOptuser(loginUser.getUsername());
		xxlWConfNodeLogDao.add(nodeLog);

		return ReturnT.SUCCESS;
	}

	@Override
	public ReturnT<String> update(XxlWConfNode xxlWConfNode, XxlConfUser loginUser, String loginEnv) {

		// valid
		if (StringUtils.isBlank(xxlWConfNode.getKey())) {
			return new ReturnT<String>(500, "配置Key不可为空");
		}
		XxlWConfNode existNode = xxlWConfNodeDao.load(xxlWConfNode.getEnv(), xxlWConfNode.getKey());
		if (existNode == null) {
			return new ReturnT<String>(500, "配置Key非法");
		}

		// project permission
		if (!ifHasProjectPermission(loginUser, loginEnv, existNode.getAppname())) {
			return new ReturnT<String>(500, "您没有该项目的配置权限,请联系管理员开通");
		}

		if (StringUtils.isBlank(xxlWConfNode.getSitename())) {
			return new ReturnT<String>(500, "网站名不可为空");
		}
		
		if (StringUtils.isBlank(xxlWConfNode.getDomain())) {
			return new ReturnT<String>(500, "网站域名不可为空");
		}
		
		// value force null to ""
		if (xxlWConfNode.getAttributes() == null) {
			xxlWConfNode.setAttributes("");
		} else {
			if (!JacksonUtil.jsonValid(xxlWConfNode.getAttributes())) {
				return new ReturnT<String>(500, "属性值格式必须为JSON格式！");
			}
		}

		XxlWConfNode existNodeAnother = xxlWConfNodeDao.loadBySiteName(xxlWConfNode.getEnv(), xxlWConfNode.getSitename());
		if (!existNode.getSitename().equals(xxlWConfNode.getSitename()) && existNodeAnother != null) {
			return new ReturnT<String>(500, "网站已存在，[key="+existNodeAnother.getKey()+", sitename="+existNodeAnother.getSitename()+", domain="+existNodeAnother.getDomain()+"]");
		}
		String oldSiteName = existNode.getSitename();
		existNode.setSitename(xxlWConfNode.getSitename());
		existNodeAnother = xxlWConfNodeDao.loadByDomain(xxlWConfNode.getEnv(), xxlWConfNode.getDomain());
		if (!existNode.getDomain().equals(xxlWConfNode.getDomain()) && existNodeAnother != null) {
			return new ReturnT<String>(500, "配置域名已存在，[key="+existNodeAnother.getKey()+", sitename="+existNodeAnother.getSitename()+", domain="+existNodeAnother.getDomain()+"]");
		}		
		existNode.setDomain(xxlWConfNode.getDomain());
		
		existNode.setAttributes(xxlWConfNode.getAttributes());
		int ret = xxlWConfNodeDao.update(existNode);
		if (ret < 1) {
			return ReturnT.FAIL;
		}

		System.out.println(existNode.getSitename());
		System.out.println(oldSiteName);
		//update xxl_wconf_node
		if (!existNode.getSitename().equals(oldSiteName)){
			ret = xxlConfNodeDao.updateSiteName(xxlWConfNode.getSitename(), oldSiteName);
		}
		
		// node log
		XxlWConfNodeLog nodeLog = new XxlWConfNodeLog();
		nodeLog.setEnv(existNode.getEnv());
		nodeLog.setKey(existNode.getKey());
		nodeLog.setSitename(existNode.getSitename());
		nodeLog.setDomain(existNode.getDomain());
		nodeLog.setAttributes(existNode.getAttributes());
		nodeLog.setOptuser(loginUser.getUsername());
		xxlWConfNodeLogDao.add(nodeLog);
		xxlWConfNodeLogDao.deleteTimeout(existNode.getEnv(), existNode.getKey(), 10);

		return ReturnT.SUCCESS;
	}

	@Override
	public void destroy() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		
	}
}
