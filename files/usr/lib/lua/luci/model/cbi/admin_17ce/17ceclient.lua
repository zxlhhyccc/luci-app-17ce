require("luci.sys")
local fs = require "nixio.fs"

if fs.access("/etc/config/17ceclient") then

	m2 = Map("17ceclient", translate("17CE Client"),translate("17CE是知名监控测速平台，每天有上亿次的监控测试需求，17CE通过将这些监测任务分配给路>由器执行，每执行一个有效任务产生收益.<br/>1、<a href=\"http://t.cn/Res4xyb\" target=\"_blank\">ZDX区块链浏览器：集成区块链挖矿赚+使用/广告分红赚+分红BTC币赚，点击进入官网立即赚钱>>></a><br/>2、<a href=\"http://t.cn/RQO2AKu\" target=\"_blank\">一路赚钱：集成挖矿赚+网站测速赚+APP广告分红赚，点击进入官网立即赚钱>>></a><br/>3、<a href=\"http://t.cn/Rkawxio\" target=\"_blank\">挂机邦：超多挂机赚钱项目，点击进入官网立即赚钱>>></a><br/>4、<a href=\"http://t.cn/RsouVhR\" target=\"_blank\">测试猿：国内最靠谱监测挂机，5元起付！免费挂机不收任何费用！点击进入官网立即赚钱>>></a><br/>5、<a href=\"http://t.cn/RsoQgVd\" target=\"_blank\">旺宝神器：一款网络挂机赚钱项目+高收益（月入千元太简单！），点击进入官网立即赚钱>>></a>"))

	s = m2:section(TypedSection, "17ceclient", translate(""))
	s.anonymous = true
	s.addremove = false

	name = s:option(Value, "username", translate("用户名："),translate("数据关联到17ce账号，填写自己注册的账号."))

	local apply = luci.http.formvalue("cbi.apply")
	if apply then
		io.popen("/etc/init.d/17ce restart")
	end


	function m2.on_commit(map)
	end

end

return m2
