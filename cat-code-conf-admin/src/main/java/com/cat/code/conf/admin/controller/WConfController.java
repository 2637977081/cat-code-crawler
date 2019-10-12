package com.cat.code.conf.admin.controller;


import com.cat.code.conf.admin.service.IXxlWConfNodeService;
import com.cat.code.conf.admin.service.impl.LoginService;
import com.cat.code.conf.admin.util.ReturnT;
import com.cat.code.conf.core.dao.XxlConfProjectDao;
import com.cat.code.conf.core.model.XxlConfProject;
import com.cat.code.conf.core.model.XxlConfUser;
import com.cat.code.conf.core.model.XxlWConfNode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

import static com.cat.code.conf.admin.controller.interceptor.EnvInterceptor.CURRENT_ENV;

/**
 * 网站管理
 *
 * @author sunqing
 */
@Controller
@RequestMapping("/wconf")
public class WConfController {
	@Resource
	private XxlConfProjectDao xxlConfProjectDao;
	@Resource
	private IXxlWConfNodeService xxlWConfNodeService;

	@RequestMapping("")
	public String index(HttpServletRequest request, Model model, String appname){

		List<XxlConfProject> list = xxlConfProjectDao.findAll();
		if (list==null || list.size()==0) {
			throw new RuntimeException("系统异常，无可用项目");
		}

		XxlConfProject project = list.get(0);
		for (XxlConfProject item: list) {
			if (item.getAppname().equals(appname)) {
				project = item;
			}
		}

		boolean ifHasProjectPermission = xxlWConfNodeService.ifHasProjectPermission(
				(XxlConfUser) request.getAttribute(LoginService.LOGIN_IDENTITY),
				(String) request.getAttribute(CURRENT_ENV),
				project.getAppname());

		model.addAttribute("ProjectList", list);
		model.addAttribute("project", project);
		model.addAttribute("ifHasProjectPermission", ifHasProjectPermission);

		return "conf/wconf.index";
	}

	@RequestMapping("/pageList")
	@ResponseBody
	public Map<String, Object> pageList(HttpServletRequest request,
										@RequestParam(required = false, defaultValue = "0") int start,
										@RequestParam(required = false, defaultValue = "10") int length,
										String appname,
										String sitename) {

		XxlConfUser xxlConfUser = (XxlConfUser) request.getAttribute(LoginService.LOGIN_IDENTITY);
		String loginEnv = (String) request.getAttribute(CURRENT_ENV);

		return xxlWConfNodeService.pageList(start, length, appname, sitename, xxlConfUser, loginEnv);
	}

	/**
	 * get
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public ReturnT<String> delete(HttpServletRequest request, String key){

		XxlConfUser xxlConfUser = (XxlConfUser) request.getAttribute(LoginService.LOGIN_IDENTITY);
		String loginEnv = (String) request.getAttribute(CURRENT_ENV);

		return xxlWConfNodeService.delete(key, xxlConfUser, loginEnv);
	}

	/**
	 * create/update
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public ReturnT<String> add(HttpServletRequest request, XxlWConfNode xxlWConfNode){

		XxlConfUser xxlConfUser = (XxlConfUser) request.getAttribute(LoginService.LOGIN_IDENTITY);
		String loginEnv = (String) request.getAttribute(CURRENT_ENV);

		// fill env
		xxlWConfNode.setEnv(loginEnv);

		return xxlWConfNodeService.add(xxlWConfNode, xxlConfUser, loginEnv);
	}
	
	/**
	 * create/update
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public ReturnT<String> update(HttpServletRequest request, XxlWConfNode xxlWConfNode){

		XxlConfUser xxlConfUser = (XxlConfUser) request.getAttribute(LoginService.LOGIN_IDENTITY);
		String loginEnv = (String) request.getAttribute(CURRENT_ENV);

		// fill env
		xxlWConfNode.setEnv(loginEnv);

		return xxlWConfNodeService.update(xxlWConfNode, xxlConfUser, loginEnv);
	}
}
