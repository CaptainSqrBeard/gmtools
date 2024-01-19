

GMT.AddCommand("subgodmode",GMT.Lang("Help_SubmarineGodmode"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineGodmode_submarine")},
    {name="value",desc=GMT.Lang("Args_SubmarineGodmode_value")}})

GMT.AssignClientCommand("subgodmode",function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_SubmarineNotFound"),client,Color(255,0,128,255))
        return
    end

    if args[2] == nil or args[2] == "switch" then
        sub.GodMode = not sub.GodMode
    elseif args[2] == "true" then
        sub.GodMode = true
    elseif args[2] == "false" then
        sub.GodMode = false
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineGodmode_BadArgument"),client,Color(255,0,128,255))
        return
    end

    if sub.GodMode then
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Enabled", {sub.Info.Name}),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Disabled", {sub.Info.Name}),client,Color(255,0,255,255))
    end
end)

GMT.AssignServerCommand("subgodmode",function(args)
    if #args == 0 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    if args[2] == nil or args[2] == "switch" then
        sub.GodMode = not sub.GodMode
    elseif args[2] == "true" then
        sub.GodMode = true
    elseif args[2] == "false" then
        sub.GodMode = false
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineGodmode_BadArgument"),Color(255,0,128,255))
        return
    end

    if sub.GodMode then
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Enabled", {sub.Info.Name}),Color(255,0,255,255))
    else
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineGodmode_Disabled", {sub.Info.Name}),Color(255,0,255,255))
    end
end)