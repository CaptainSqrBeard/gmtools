local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")

command.AddCommand("subgodmode",GMT.Lang("Help_SubmarineGodmode"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineGodmode_submarine")},
    {name="value",desc=GMT.Lang("Args_SubmarineGodmode_value")}})

command.AssignClientCommand("subgodmode",function(client,cursor,args)
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

    if args[2] == nil or args[2] == "switch" then
        sub.GodMode = not sub.GodMode
    elseif args[2] == "true" then
        sub.GodMode = true
    elseif args[2] == "false" then
        sub.GodMode = false
    else
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineGodmode_BadArgument"),client,Color(255,0,128,255))
        return
    end

    if sub.GodMode then
        utils.SendConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Enabled", {sub.Info.Name}),client,Color(255,0,255,255))
    else
        utils.SendConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Disabled", {sub.Info.Name}),client,Color(255,0,255,255))
    end
end)

command.AssignServerCommand("subgodmode",function(args)
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

    if args[2] == nil or args[2] == "switch" then
        sub.GodMode = not sub.GodMode
    elseif args[2] == "true" then
        sub.GodMode = true
    elseif args[2] == "false" then
        sub.GodMode = false
    else
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineGodmode_BadArgument"),Color(255,0,128,255))
        return
    end

    if sub.GodMode then
        utils.NewConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Enabled", {sub.Info.Name}),Color(255,0,255,255))
    else
        utils.NewConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Disabled", {sub.Info.Name}),Color(255,0,255,255))
    end
end)