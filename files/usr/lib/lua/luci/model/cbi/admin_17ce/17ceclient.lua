require("luci.sys")
local fs = require "nixio.fs"

if fs.access("/etc/config/17ceclient") then

	m2 = Map("17ceclient", translate("17CE Client"),translate("17CE是知名监控测速平台，每天有上亿次的监控测试需求，17CE通过将这些监测任务分配给路>由器执行，每执行一个有效任务产生收益."))

	s = m2:section(TypedSection, "17ceclient", translate(""))
	s.anonymous = true
	s.addremove = false

	name = s:option(Value, "username", translate("用户名："),translate("数据关联到17ce账号，默认为yiqice@qq.com."))

	local apply = luci.http.formvalue("cbi.apply")
	if apply then
		io.popen("/etc/init.d/17ce restart")
	end


	function m2.on_commit(map)
	end

end

return m2
