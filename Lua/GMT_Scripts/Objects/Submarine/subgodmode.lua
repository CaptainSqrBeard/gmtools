local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    command.AddCommand("subgodmode",lang.Lang("Help_SubmarineGodmode"),true,nil,{
        {name="submarine",desc=lang.Lang("Args_SubmarineGodmode_submarine")},
        {name="value",desc=lang.Lang("Args_SubmarineGodmode_value"),optional=true}})

    command.AssignSharedCommand("subgodmode",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("subgodmode"),Color(255,0,128,255))
            return
        end

        local sub_id = tonumber(args[1])
        local sub = Submarine.Loaded[sub_id]
        if sub == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
            return
        end

        if args[2] == nil or args[2] == "switch" then
            sub.GodMode = not sub.GodMode
        elseif args[2] == "true" then
            sub.GodMode = true
        elseif args[2] == "false" then
            sub.GodMode = false
        else
            interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineGodmode_BadArgument"),Color(255,0,128,255))
            return
        end

        if sub.GodMode then
            interface.showMessage(lang.Lang("CMD_SubmarineGodmode_Enabled", {sub.Info.Name}),Color(255,0,255,255))
        else
            interface.showMessage(lang.Lang("CMD_SubmarineGodmode_Disabled", {sub.Info.Name}),Color(255,0,255,255))
        end
    end)
end

return module