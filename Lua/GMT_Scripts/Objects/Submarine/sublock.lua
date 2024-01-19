

GMT.AddCommand("sublock",GMT.Lang("Help_SubmarineLock"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineLock_submarine")},
    {name="axis",desc=GMT.Lang("Args_SubmarineLock_axis")}})

GMT.AssignClientCommand("sublock",function(client,cursor,args)
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

    if args[2] == nil or args[2] == "xy" then
        if sub.LockX and sub.LockY then
            sub.LockX = false
            sub.LockY = false
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullUnlock"),client,Color(255,0,255,255))
        else
            sub.LockX = true
            sub.LockY = true
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullLock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        sub.LockX = not sub.LockX
        if sub.LockX then
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XLock"),client,Color(255,0,255,255))
        else
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XUnlock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        sub.LockY = not sub.LockY
        if sub.LockY then
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YLock"),client,Color(255,0,255,255))
        else
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YUnlock"),client,Color(255,0,255,255))
        end
    end
end)

GMT.AssignServerCommand("sublock",function(args)
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

    if args[2] == nil or args[2] == "xy" then
        if sub.LockX and sub.LockY then
            sub.LockX = false
            sub.LockY = false
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullUnlock"),Color(255,0,255,255))
        else
            sub.LockX = true
            sub.LockY = true
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullLock"),Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        sub.LockX = not sub.LockX
        if sub.LockX then
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XLock"),Color(255,0,255,255))
        else
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XUnlock"),Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        sub.LockY = not sub.LockY
        if sub.LockY then
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YLock"),Color(255,0,255,255))
        else
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YUnlock"),Color(255,0,255,255))
        end
    end
end)