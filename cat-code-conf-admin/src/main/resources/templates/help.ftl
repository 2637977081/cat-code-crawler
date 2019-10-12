<!DOCTYPE html>
<html>
<head>
  	<title>配置管理中心</title>
  	<#import "./common/common.macro.ftl" as netCommon>
	<@netCommon.commonStyle />
</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && cookieMap["adminlte_settings"]?exists && "off" == cookieMap["adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "help" />
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>使用教程<small></small></h1>
			<!--
			<ol class="breadcrumb">
				<li><a><i class="fa fa-dashboard"></i>配置中心</a></li>
				<li class="active">使用教程</li>
			</ol>
			-->
		</section>

		<!-- Main content -->
		<section class="content">
			<div class="callout callout-info">
				<!--<h4>简介：分布式配置管理平台XXL-CONF</h4>-->
				<h4>简介：分布式配置管理平台模板配置教程</h4>
				<br>
				<p>
					<!--
                    <a target="_blank" href="https://github.com/xuxueli/xxl-conf">Github</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<iframe src="https://ghbtns.com/github-btn.html?user=xuxueli&repo=xxl-conf&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px" style="margin-bottom:-5px;"></iframe>
					<br><br>
					<a target="_blank" href="http://www.xuxueli.com/xxl-conf/">官方文档</a>
                    <br><br>
					-->
					配置模板支持的字段及说明如下：<br>
					bn：可选，板块名，建议设置<br>
					entryURLs：必须， 入口url，可指定多个，数组<br>
					pn：必须， 入口url页码控制，数组，与entryURLs结合使用，为0不翻页，大于0翻页，根据页码数替换entryURLs中的[#pn#]<br>
					requestParams：可选， 请求参数， 包括请求头、请求url参数、cookies、userAgent、referrer。例如：{"headers":{"token":"111111","u":"tttt"}, "params":{"a":1,"b":2}, "cookies":{},"userAgent":"","referrer":""},
					mapping：必须，信息字段提取模板，内支持如下关键词：<br>
					|———mtype: 可选，当存在且值为net时，需要先下载<br>
					|———method：必须，提取算法，支持xpath、jsonpath、、regex，注意为regex时“( )”只可以对要提取的信息使用，否则会造成提取信息不是希望值，另外用“.*”匹配任意字符包括换行符，程序内部已做处理，不要用“(.|\r|\n)*”去匹配<br>
					|———rows：必须，代表提取数据是多行，还是单条，第一个值是起始位置，第二个值是结束位置，如果第一个为0则默认单行，不做处理<br>
					|———fields：必须，字段提取配置，数组<br>
					　　｜———key：必须，字段名<br>
					　　｜———type：可选，数据类型，指定type则进行格式转换，否则保留提取的原格式；type目前支持：string、int、long、datetime、float、double、attachment（附件），当为attachment的时候，将抽取的字段值添加到文件下载队列中。<br>
					　　｜———format：可选，提取的该字段原始信息格式，仅当type为datetime时起作用，支持：int_timestamp,long_timestamp,YYYY-MM-dd HH:mm:SS,等其他时间日期格式<br>
					　　｜———value：必须，抽取规则串数组，可指定多条抽取规则<br>
					　　｜———required:可选，默认false；指明该字段是否必须，为true时如果该字段提取不到信息则整条数据丢弃<br>
					　　｜———multivalue: 可选，默认false，表名为单值，为true时标明为多值，注意该字段仅对xpath起作用，为jsoupath时不起作用，另外当该字段包含mapping时该字段将会失效！<br>
					　　｜———mapping: 可选，信息字段提取模板，格式同上述，加上该字段将会对该字段的value值进行再次信息提取<br>
					　　｜———mappingType:可选，支持fold（折叠）、unfold（展开）， 当不设置该字段时，如果mapping提取结果为map则默认为unfold，为list时默认为fold。注意当mapping提取结果为list时，可以设置unfold展开，但一个mapping下如果有多个字段包含mapping且返回结果为list时只能设置一个进行unfold，如果设置多个，会默认第一个起作用其它的设置不生效。当为fold时，mapping中提取的字段名、字段值会存到上层结果中，如果上层结果有相同的字段名，则会覆盖。当为unfold时，会以mappingKey作为字段名，mapping提取的结果作为字段值存储。<br>
							技巧：如果field中包含mapping，本字段提取的value值不存储，只作为mapping的输入再次提取某些字段值，则可设置mapping中的字段名与本字段key重名即可覆盖。<br>
					　　｜———mappingKey: 可选，与mappingType配合使用，当mappingType为fold的时必须设置该字段值<br>
					　　｜———attachmentStore: 可选，当type为attachment时，本字段才起作用，type为其它值时，本字段会被忽略；该字段值结构同storage.ds, 包含dtype和其它字段（具体有哪些字段根据存储类型决定）；目前仅支持本地存储，因此结构为 "attachmentStore":{"dtype":"local","path":"/home/data/files/"},此处的path字段为路径，不包含文件名，文件名根据附件url的md5计算得到<br>
					strategy：可选，代表主键和去重策略，支持skip（跳过）、stop（停止）、no（不做处理）；如果不存在该字段，则不做去重处理<br>
					|———key：必须，去重字段列表，逗号隔开<br>
					|———algorithm：可选，算法，目前仅支持md5<br>
					|———duplicates：可选，数据重复的处理策略，支持skip（跳过）、stop（停止）、no（不做处理），默认为no<br>
					|———expired：可选，去重缓存key的缓存时长，单位为妙，默认2678400秒<br>
					
					storage：可选，指定存储数据源类型和目标库表，并指定字段映射关系<br>
					|———ds： 数据源说明<br>
					　　　　dtype：必须，数据源类型，目前支持console,mongodb,kafka,elasticsearch,file<br>
					　　　　其它字段说明：<br>
					　　　　　当dtype为console时，无其它字段；<br>
					　　　　　当dtype为mongodb时，还包含db、tb字段，db代表库名（目前未用），tb代表表名；<br>
					　　　　　当dtype为kafka时，包含topic字段为主题名；<br>
					　　　　　当dtype为elasticsearch时，包含index（索引）、type（类型）；<br>
					　　　　　当dtype为file时，包含path（文件全路径，包含文件名）<br>
					　　　　storage示例：<br>
					　　　　　控制台： {"storage":{"ds":{"dtype":"console"}}}<br>
					　　　　　mongodb：{"storage":{"ds":{"dtype":"mongodb","db":"test","tb":"articles"}}}<br>
					　　　　　kafka：{"storage":{"ds":{"dtype":"kafka","topic":"test"}}}<br>
					　　　　　elasticsearch：{"storage":{"ds":{"dtype":"elasticsearch","index":"test","type":"document"}}}<br>
					　　　　　kafka：{"storage":{"ds":{"dtype":"file","path":"/home/test/files/aaa.txt"}}}<br>
					<br><br>
					示例可参考采集模板样例-xpath.txt和采集模板样例-JsonPath.txt　
				</p>
				<p></p>
            </div>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	
	<!-- footer -->
	<@netCommon.commonFooter />
</div>
<@netCommon.commonScript />
</body>
</html>
