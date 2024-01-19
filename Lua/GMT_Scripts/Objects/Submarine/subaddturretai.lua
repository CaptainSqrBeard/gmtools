LuaUserData.RegisterType("Barotrauma.SubmarineTurretAI")

GMT.AddCommand("subaddturretai",GMT.Lang("Help_SubmarineAddTurretAI"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineAddTurretAI_submarine")}})

GMT.AssignClientCommand("subaddturretai",function(client,cursor,args)
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

    if sub.TurretAI == nil then
        sub.CreateTurretAI()
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineAddTurretAI_Success", {sub.Info.Name}),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineAddTurretAI_AlreadyHave", {sub.Info.Name}),client,Color(255,0,128,255))
    end
end)

GMT.AssignServerCommand("subaddturretai",function(args)
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

    if sub.TurretAI == nil then
        sub.CreateTurretAI()
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineAddTurretAI_Success", {sub.Info.Name}),Color(255,0,255,255))
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineAddTurretAI_AlreadyHave", {sub.Info.Name}),Color(255,0,128,255))
    end
end)