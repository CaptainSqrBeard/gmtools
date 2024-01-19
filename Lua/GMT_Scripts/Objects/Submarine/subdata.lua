

GMT.AddCommand("subdata",GMT.Lang("Help_SubmarineData"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineData_submarine")}})

GMT.AssignClientCommand("subdata",function(client,cursor,args)
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

    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_header", {sub_id}),client,Color(255,0,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_name", {sub.Info.Name}),client,Color(255,255,255,255))
    if sub == Game.RespawnManager.RespawnShuttle then
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_shuttle"),client,Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_mainsub"),client,Color(255,255,255,255))
    end
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_team", {GMT.GetLocalizedTeam(sub.TeamID)}),client,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_type", {GMT.GetLocalizedSubmarineType(sub.Info.Type)}),client,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_class", {GMT.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),client,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),client,Color(255,255,255,255))
    if sub.LockX or sub.LockY then
        local lockedText = ""
        if sub.LockX then lockedText = lockedText.."X" end
        if sub.LockY then lockedText = lockedText.."Y" end
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_locked", {lockedText}),client,Color(255,255,255,255))
    else
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_unlocked"),client,Color(255,255,255,255))
    end
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),client,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),client,Color(255,255,255,255))
end)

GMT.AssignServerCommand("subdata",function(args)
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

    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_header", {sub_id}),Color(255,0,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_name", {sub.Info.Name}),Color(255,255,255,255))
    if sub == Game.RespawnManager.RespawnShuttle then
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_shuttle"),Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_mainsub"),Color(255,255,255,255))
    end
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_team", {GMT.GetLocalizedTeam(sub.TeamID)}),Color(255,255,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_type", {GMT.GetLocalizedSubmarineType(sub.Info.Type)}),Color(255,255,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_class", {GMT.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),Color(255,255,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),Color(255,255,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),Color(255,255,255,255))
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),Color(255,255,255,255))
end)