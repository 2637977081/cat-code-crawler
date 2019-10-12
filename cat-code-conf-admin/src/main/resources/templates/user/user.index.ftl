<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>配置管理中心</title>

<#import "../common/common.macro.ftl" as netCommon>
<@netCommon.commonStyle />
<link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">

</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && cookieMap["adminlte_settings"]?exists && "off" == cookieMap["adminlte_settings"].value >sidebar-collapse</#if> ">
	<div class="wrapper">
		
		<@netCommon.commonHeader />

		<@netCommon.commonLeft "user" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>用户管理 <small></small></h1>
			</section>

			<!-- Main content -->
			<section class="content">
			
                <div class="row">
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">权限</span>
                            <select class="form-control" id="permission" >
                                <option value="-1" >全部</option>
                                <option value="0" >普通用户</option>
                                <option value="1" >管理员</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">用户名</span>
                            <input type="text" class="form-control" id="username" autocomplete="on" >
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <button class="btn btn-block btn-info" id="searchBtn">搜索</button>
                    </div>
                    <div class="col-xs-2">
                        <button class="btn btn-block btn-success" id="add" type="button">新增用户</button>
                    </div>
                </div>

				<!-- 全部配置 -->
				<div class="box box-info2">
	                <div class="box-body">
	                  	<table id="data_list" class="table table-bordered table-hover" width="100%" >
		                    <thead>
		                      	<tr>
                                    <th>用户名</th>
			                        <th>权限</th>
                                    <th>操作</th>
		                      	</tr>
							</thead>
		                    <tbody></tbody>
	                  	</table>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
				
			</section>
			<!-- /.content -->
			
		</div>
		<!-- /.content-wrapper -->

		<@netCommon.commonFooter />

	</div>
	<!-- ./wrapper -->
	
	<!-- 新增.模态框 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
	            	<h4 class="modal-title" >新增用户</h4>
	         	</div>
	         	<div class="modal-body">
					<form class="form-horizontal form" role="form" >
						<div class="form-group">
							<label for="firstname" class="col-sm-2 control-label">权限</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="permission" >
                                    <option value="0" >普通用户</option>
                                    <option value="1" >管理员</option>
                                </select>
                            </div>
						</div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="username" placeholder="请输入用户名" maxlength="50" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="password" value="123456" placeholder="请输入密码" maxlength="50" ></div>
                        </div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary"  >保存</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							</div>
						</div>
					</form>
	         	</div>
			</div>
		</div>
	</div>

	<!-- 更新.模态框 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
	            	<h4 class="modal-title" >更新用户</h4>
	         	</div>
	         	<div class="modal-body">
					<form class="form-horizontal form" role="form" >
                        <div class="form-group">
                            <label for="firstname" class="col-sm-2 control-label">权限</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="permission" >
                                    <option value="0" >普通用户</option>
                                    <option value="1" >管理员</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="username" placeholder="请输入用户名" maxlength="50" readonly ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">

                                <div class="input-group">
									<span class="input-group-addon">
										重置密码<input type="checkbox" name="passwordInput" >
									</span>
                                    <input type="text" class="form-control" name="password" placeholder="为空则不更新密码" maxlength="50" readonly >
                                </div>

							</div>
                        </div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary"  >更新</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							</div>
						</div>
					</form>
	         	</div>
			</div>
		</div>
	</div>

    <!-- 分配项目权限.模态框 -->
    <div class="modal fade" id="permissionDataModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" >分配项目权限</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form" role="form" >

                        <!-- permission start -->
                        <div class="table-responsive">
                            <table id="permissionData" class="table table-bordered" width="100%" >
                                <thead>
                                    <tr>
                                        <th>项目</th>
                                        <#if envList?exists>
                                            <#list envList as env>
                                                <th>${env.title}(${env.env})</th>
                                            </#list>
                                        </#if>
                                    </tr>
                                </thead>
                                <tbody>
                                    <#if projectList?exists>
                                        <#list projectList as project>
                                            <tr>
                                                <td>${project.title}(${project.appname})</td>
                                                <#list envList as env>
                                                    <td>
                                                        <input type="checkbox" name="permissionData" value="${project.appname}#${env.env}" >
                                                    </td>
                                                </#list>
                                            </tr>
                                        </#list>
                                    </#if>
                                </tbody>

                            </table>
                        </div>
                        <!-- permission end -->

                        <div class="form-group">
                            <div class="text-center">
                                <button type="button" class="btn btn-primary ok" >保存</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

                                <input type="hidden" name="username"  >
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<@netCommon.commonScript/>
    <script src="${request.contextPath}/static/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.min.js"></script>

    <script src="${request.contextPath}/static/js/user.1.js"></script>
	
</body>
</html>
