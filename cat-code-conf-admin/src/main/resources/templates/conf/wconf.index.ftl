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

		<@netCommon.commonLeft "wconf" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>配置管理 <small></small></h1>
				<#--<ol class="breadcrumb">
					<li><a><i class="fa fa-dashboard"></i>配置中心</a></li>
					<li class="active">配置管理</li>
				</ol>-->
			</section>

			<!-- Main content -->
			<section class="content">
			
                <div class="row">
                    <div class="col-xs-3">
                        <div class="input-group">
                            <span class="input-group-addon">项目</span>
                            <select class="form-control" id="appname" >
                                <#--<option value="" >全部</option>-->
								<#list ProjectList as item>
									<option value="${item.appname}" <#if item.appname = project.appname>selected</#if> >${item.title}</option>
								</#list>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">网站</span>
                            <input type="text" class="form-control" id="sitename" autocomplete="on" >
                        </div>
                    </div>
                    <div class="col-xs-1">
                        <button class="btn btn-block btn-info" id="searchBtn">搜索</button>
                    </div>
                    <div class="col-xs-2">
                        <button class="btn btn-block btn-success" id="add" type="button">新增配置</button>
                    </div>
                    <#--<div class="col-xs-2">
                        <button class="btn btn-block btn-nomal" id="syncConf">全量同步</button>
                    </div>-->
                </div>

				<!-- 全部配置 -->
				<div class="box box-info2">
	                <div class="box-body">
	                  	<table id="conf_list" class="table table-bordered table-hover" width="100%" >
		                    <thead>
		                      	<tr>
                                    <th>KEY</th>
			                        <th>网站</th>
			                        <th>域名</th>
			                        <th>属性</th>
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
	            	<h4 class="modal-title" >新增配置</h4>
	         	</div>
	         	<div class="modal-body">
					<form class="form-horizontal form" role="form" >
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">环境</label>
                            <div class="col-sm-10">
								<input type="text" class="form-control" name="env" value="${XXL_CONF_CURRENT_ENV}" readonly >
							</div>
                        </div>
						<div class="form-group">
							<label for="firstname" class="col-sm-2 control-label">KEY</label>
                            <div class="col-sm-10">
								<div class="input-group" >
									<span class="input-group-addon" style="background-color: #eee;" >${project.appname}.</span>
									<input type="text" class="form-control" name="key" placeholder="请输入网站key" maxlength="100" >

                                    <input type="hidden" name="appname" value="${project.appname}" >

                                </div>
                            </div>
						</div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">网站</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="sitename" placeholder="请输入网站名" maxlength="100" ></div>
                        </div>						
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">域名</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="domain" placeholder="请输入网站域名" maxlength="100" ></div>
                        </div>
						<div class="form-group">
							<label for="lastname" class="col-sm-2 control-label">VALUE</label>
							<div class="col-sm-10">
                                <textarea class="textarea" name="attributes" maxlength="2000" placeholder="请输入网站其它属性配置，以JSON格式！" style="width: 100%; height: 100px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
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
	            	<h4 class="modal-title" >更新配置</h4>
	         	</div>
	         	<div class="modal-body">
					<form class="form-horizontal form" role="form" >
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">环境</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="env" value="${XXL_CONF_CURRENT_ENV}" readonly >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="firstname" class="col-sm-2 control-label">KEY</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="key" placeholder="请输入网站Key" maxlength="100" readonly ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">网站</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="sitename" placeholder="请输入网站名" maxlength="100" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">域名</label>
                            <div class="col-sm-10"><input type="text" class="form-control" name="domain" placeholder="请输入网站域名" maxlength="100" ></div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">VALUE</label>
                            <div class="col-sm-10">
                                <textarea class="textarea" name="attributes" maxlength="2000" placeholder="请输入网站其它属性配置，以JSON格式！" style="width: 100%; height: 100px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
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

	<@netCommon.commonScript/>
	<script>
        var hasPermission = ${ifHasProjectPermission?string};
	</script>

    <script src="${request.contextPath}/static/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script src="${request.contextPath}/static/adminlte/plugins/daterangepicker/moment.min.js"></script>
    <script src="${request.contextPath}/static/js/xxl.alert.1.js"></script>
    <script src="${request.contextPath}/static/js/wconf.1.js"></script>
	
</body>
</html>