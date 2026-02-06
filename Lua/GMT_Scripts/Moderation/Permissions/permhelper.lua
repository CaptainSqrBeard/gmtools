local module = {}

local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local permissions = require("GMT_Scripts._UTILS.permissions")

function module.initialize()
    command.AddCommand("permhelper",lang.Lang("Help_PermHelper"),false,nil,nil)

    command.AssignSharedCommand("permhelper",function (args, interface)
        interface.showMessage(lang.Lang("CMD_PermHelper_header"),Color(255,0,255,255))
        for k, desc in pairs(permissions.availablePermissions) do
            interface.showMessage(lang.Lang("CMD_PermHelper_item",{k, desc}),Color(196,196,196,255))
        end
        interface.showMessage(lang.Lang("CMD_PermHelper_Tip"),Color(255,255,255,255))
    end)
end

return module