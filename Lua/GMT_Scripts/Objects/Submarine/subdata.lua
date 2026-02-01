local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("subdata",lang.Lang("Help_SubmarineData"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineData_submarine")}})

command.AssignClientCommand("subdata",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),client,Color(255,0,128,255))
        return
    end

    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_header", {sub_id}),client,Color(255,0,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_name", {sub.Info.Name}),client,Color(255,255,255,255))
    if sub == Game.RespawnManager.RespawnShuttle then
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_shuttle"),client,Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_mainsub"),client,Color(255,255,255,255))
    end
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_team", {GMT.GetLocalizedTeam(sub.TeamID)}),client,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_type", {GMT.GetLocalizedSubmarineType(sub.Info.Type)}),client,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_class", {GMT.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),client,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),client,Color(255,255,255,255))
    if sub.LockX or sub.LockY then
        local lockedText = ""
        if sub.LockX then lockedText = lockedText.."X" end
        if sub.LockY then lockedText = lockedText.."Y" end
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_locked", {lockedText}),client,Color(255,255,255,255))
    else
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_unlocked"),client,Color(255,255,255,255))
    end
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),client,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),client,Color(255,255,255,255))
end)

command.AssignServerCommand("subdata",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_header", {sub_id}),Color(255,0,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_name", {sub.Info.Name}),Color(255,255,255,255))
    if sub == Game.RespawnManager.RespawnShuttle then
        utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_shuttle"),Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_mainsub"),Color(255,255,255,255))
    end
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_team", {GMT.GetLocalizedTeam(sub.TeamID)}),Color(255,255,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_type", {GMT.GetLocalizedSubmarineType(sub.Info.Type)}),Color(255,255,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_class", {GMT.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),Color(255,255,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),Color(255,255,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),Color(255,255,255,255))
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),Color(255,255,255,255))
end)