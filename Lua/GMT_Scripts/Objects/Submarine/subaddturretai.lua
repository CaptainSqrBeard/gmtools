local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    LuaUserData.RegisterType("Barotrauma.SubmarineTurretAI")

    command.AddCommand("subaddturretai",lang.Lang("Help_SubmarineAddTurretAI"),true,nil,{
        {name="submarine",desc=lang.Lang("Args_SubmarineAddTurretAI_submarine")}})

    command.AssignSharedCommand("subaddturretai",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("subaddturretai"),Color(255,0,128,255))
            return
        end

        local sub_id = tonumber(args[1])
        local sub = Submarine.Loaded[sub_id]
        if sub == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
            return
        end

        if sub.TurretAI == nil then
            sub.CreateTurretAI()
            interface.showMessage(lang.Lang("CMD_SubmarineAddTurretAI_Success", {sub.Info.Name}),Color(255,0,255,255))
        else
            interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineAddTurretAI_AlreadyHave", {sub.Info.Name}),Color(255,0,128,255))
        end
    end)
end

return module