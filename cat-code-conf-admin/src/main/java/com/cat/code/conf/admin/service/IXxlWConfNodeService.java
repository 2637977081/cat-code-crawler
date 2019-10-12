package com.cat.code.conf.admin.service;


import com.cat.code.conf.admin.util.ReturnT;
import com.cat.code.conf.core.model.XxlConfUser;
import com.cat.code.conf.core.model.XxlWConfNode;

import java.util.Map;


/**
 * 
 * @author sunqing
 *
 */
public interface IXxlWConfNodeService {
	public boolean ifHasProjectPermission(XxlConfUser loginUser, String loginEnv, String appname);

	public Map<String,Object> pageList(int offset,
                                       int pagesize,
                                       String appname,
                                       String sitename,
                                       XxlConfUser loginUser,
                                       String loginEnv);

	public ReturnT<String> delete(String key, XxlConfUser loginUser, String loginEnv);

	public ReturnT<String> add(XxlWConfNode xxlWConfNode, XxlConfUser loginUser, String loginEnv);

	public ReturnT<String> update(XxlWConfNode xxlWConfNode, XxlConfUser loginUser, String loginEnv);

}
