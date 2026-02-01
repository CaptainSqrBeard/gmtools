local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")

LuaUserData.RegisterType("Barotrauma.SubmarineTurretAI")

command.AddCommand("subaddturretai",GMT.Lang("Help_SubmarineAddTurretAI"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineAddTurretAI_submarine")}})

command.AssignClientCommand("subaddturretai",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_SubmarineNotFound"),client,Color(255,0,128,255))
        return
    end

    if sub.TurretAI == nil then
        sub.CreateTurretAI()
        utils.SendConsoleMessage(GMT.Lang("CMD_SubmarineAddTurretAI_Success", {sub.Info.Name}),client,Color(255,0,255,255))
    else
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineAddTurretAI_AlreadyHave", {sub.Info.Name}),client,Color(255,0,128,255))
    end
end)

command.AssignServerCommand("subaddturretai",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    if sub.TurretAI == nil then
        sub.CreateTurretAI()
        utils.NewConsoleMessage(GMT.Lang("CMD_SubmarineAddTurretAI_Success", {sub.Info.Name}),Color(255,0,255,255))
    else
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineAddTurretAI_AlreadyHave", {sub.Info.Name}),Color(255,0,128,255))
    end
end)