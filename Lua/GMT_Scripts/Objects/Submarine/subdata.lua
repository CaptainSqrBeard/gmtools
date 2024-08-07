

GMT.AddCommand("subdata",GMT.Lang("Help_SubmarineData"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineData_submarine")}})

GMT.AssignSharedCommand("subdata",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    interface.showMessage(GMT.Lang("CMD_SubmarineData_header", {sub_id}),Color(255,0,255,255))
    interface.showMessage(GMT.Lang("CMD_SubmarineData_name", {sub.Info.Name}),Color(255,255,255,255))
    if sub == Game.RespawnManager.RespawnShuttle then
        interface.showMessage(GMT.Lang("CMD_SubmarineData_shuttle"),Color(255,255,255,255))
    end
    if sub == Submarine.MainSub then
        interface.showMessage(GMT.Lang("CMD_SubmarineData_mainsub"),Color(255,255,255,255))
    end
    interface.showMessage(GMT.Lang("CMD_SubmarineData_team", {GMT.GetLocalizedTeam(sub.TeamID)}),Color(255,255,255,255))
    interface.showMessage(GMT.Lang("CMD_SubmarineData_type", {GMT.GetLocalizedSubmarineType(sub.Info.Type)}),Color(255,255,255,255))
    interface.showMessage(GMT.Lang("CMD_SubmarineData_class", {GMT.GetLocalizedSubmarineClass(sub.Info.SubmarineClass)}),Color(255,255,255,255))
    interface.showMessage(GMT.Lang("CMD_SubmarineData_velocity", {math.floor(sub.Velocity.x), math.floor(sub.Velocity.y)}),Color(255,255,255,255))

    if Submarine.LockX or Submarine.LockY or (GMT.SubLocks[sub] ~= nil and (GMT.SubLocks[sub].x or GMT.SubLocks[sub].y)) then
        local lockedText = ""
        if Submarine.LockX or GMT.SubLocks[sub].x then lockedText = lockedText.."X" end
        if Submarine.LockY or GMT.SubLocks[sub].y then lockedText = lockedText.."Y" end
        interface.showMessage(GMT.Lang("CMD_SubmarineData_locked", {lockedText}),Color(255,255,255,255))
    else
        interface.showMessage(GMT.Lang("CMD_SubmarineData_unlocked"),Color(255,255,255,255))
    end

    interface.showMessage(GMT.Lang("CMD_SubmarineData_position", {math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y)}),Color(255,255,255,255))
    interface.showMessage(GMT.Lang("CMD_SubmarineData_depth", {math.floor(sub.RealWorldDepth), sub.RealWorldCrushDepth}),Color(255,255,255,255))
end)