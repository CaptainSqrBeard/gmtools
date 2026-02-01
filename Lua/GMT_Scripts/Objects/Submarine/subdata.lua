local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local gameInfo = require("GMT_Scripts._UTILS.gameInfo")

command.AddCommand("subdata",lang.Lang("Help_SubmarineData"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineData_submarine")}})

command.AddCommand("subdata",lang.Lang("Help_SubmarineData"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineData_submarine")}})

command.AssignSharedCommand("subdata",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("subdata"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    interface.showMessage(lang.Lang("CMD_SubmarineData_header", {sub_id}),Color(255,0,255,255))
    interface.showMessage(lang.Lang("CMD_SubmarineData_name", {sub.Info.Name}),Color(255,255,255,255))
    if sub.IsRespawnShuttle then
        interface.showMessage(lang.Lang("CMD_SubmarineData_shuttle"),Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        interface.showMessage(lang.Lang("CMD_SubmarineData_mainsub"),Color(255,255,255,255))
    end
    interface.showMessage(lang.Lang("CMD_SubmarineData_team", {gameInfo.GetLocalizedTeam(sub.TeamID)}),Color(255,255,255,255))
    interface.showMessage(lang.Lang("CMD_SubmarineData_type", {gameInfo.GetLocalizedSubmarineType(sub.Info.Type)}),Color(255,255,255,255))
    interface.showMessage(lang.Lang("CMD_SubmarineData_class", {gameInfo.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),Color(255,255,255,255))
    interface.showMessage(lang.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),Color(255,255,255,255))

    if Submarine.LockX or Submarine.LockY or (GMT.SubLocks[sub] ~= nil and (GMT.SubLocks[sub].x or GMT.SubLocks[sub].y)) then
        local lockedText = ""
        if Submarine.LockX or GMT.SubLocks[sub].x then lockedText = lockedText.."X" end
        if Submarine.LockY or GMT.SubLocks[sub].y then lockedText = lockedText.."Y" end
        interface.showMessage(lang.Lang("CMD_SubmarineData_locked", {lockedText}),Color(255,255,255,255))
    else
        interface.showMessage(lang.Lang("CMD_SubmarineData_unlocked"),Color(255,255,255,255))
    end

    interface.showMessage(lang.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),Color(255,255,255,255))
    interface.showMessage(lang.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),Color(255,255,255,255))
end)