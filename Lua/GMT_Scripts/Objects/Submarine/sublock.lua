GMT.SubLocks = {}

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

    if GMT.SubLocks[sub] == nil then
        GMT.SubLocks[sub] = {x = false, y = false}
    end

    if args[2] == nil or args[2] == "xy" then
        if GMT.SubLocks[sub].x and GMT.SubLocks[sub].y then
            GMT.SubLocks[sub].x = false
            GMT.SubLocks[sub].y = false
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullUnlock"),client,Color(255,0,255,255))
        else
            GMT.SubLocks[sub].x = true
            GMT.SubLocks[sub].y = true
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullLock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        GMT.SubLocks[sub].x = not GMT.SubLocks[sub].x
        if GMT.SubLocks[sub].x then
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XLock"),client,Color(255,0,255,255))
        else
            GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XUnlock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        GMT.SubLocks[sub].y = not GMT.SubLocks[sub].y
        if GMT.SubLocks[sub].y then
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

    if GMT.SubLocks[sub] == nil then
        GMT.SubLocks[sub] = {x = false, y = false}
    end

    if args[2] == nil or args[2] == "xy" then
        if GMT.SubLocks[sub].x and GMT.SubLocks[sub].y then
            GMT.SubLocks[sub].x = false
            GMT.SubLocks[sub].y = false
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullUnlock"),Color(255,0,255,255))
        else
            GMT.SubLocks[sub].x = true
            GMT.SubLocks[sub].y = true
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_FullLock"),Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        GMT.SubLocks[sub].x = not GMT.SubLocks[sub].x
        if GMT.SubLocks[sub].x then
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XLock"),Color(255,0,255,255))
        else
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_XUnlock"),Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        GMT.SubLocks[sub].y = not GMT.SubLocks[sub].y
        if GMT.SubLocks[sub].y then
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YLock"),Color(255,0,255,255))
        else
            GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineLocked_YUnlock"),Color(255,0,255,255))
        end
    end
end)

Hook.Add("roundEnd", "gmtools.on_round_end", function ()
    GMT.SubLocks = {}
end)

Hook.Patch("Barotrauma.SubmarineBody", "CalculateBuoyancy", function (instance, ptable)
    if GMT.SubLocks[instance.Submarine] ~= nil and GMT.SubLocks[instance.Submarine].y == true then
        ptable.PreventExecution = true
        return Vector2.Zero
    end
end, Hook.HookMethodType.Before)


Hook.Patch("Barotrauma.Submarine", "Update", function (instance, ptable)
    if GMT.SubLocks[instance] ~= nil then
        local patched_x = instance.subBody.Body.LinearVelocity.x
        local patched_y = instance.subBody.Body.LinearVelocity.y
        if GMT.SubLocks[instance].x == true then
            patched_x = 0
        end
        if GMT.SubLocks[instance].y == true then
            patched_y = 0
        end
        instance.subBody.Body.LinearVelocity = Vector2(patched_x, patched_y)
    end
end, Hook.HookMethodType.After)