module("luci.controller.admin.17ce", package.seeall)
function index()
	local page
	entry({"admin", "17ce"}, alias("admin", "17ce", "17ceclient"), _("17CE"), 35).index = true
	entry({"admin", "17ce", "17ceclient"}, cbi("admin_17ce/17ceclient"), _("17ce测速客户端"), 1)
end

