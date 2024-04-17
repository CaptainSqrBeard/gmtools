

GMT.AddCommand("subthrow",GMT.Lang("Help_SubmarineThrow"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineThrow_submarine")},
    {name="vector",desc=GMT.Lang("Args_SubmarineThrow_vector")},
    {name="mode",desc=GMT.Lang("Args_SubmarineThrow_mode")}})

GMT.AssignClientCommand("subthrow",function(client,cursor,args)
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

    local vector = Vector2.Zero
    if args[2] == nil or args[2] == "cursor" then
        vector = (cursor - sub.WorldPosition)*0.02
    elseif args[2] == "ncursor" then
        vector = Vector2.Normalize(cursor - sub.WorldPosition)*15
    else
        local split = GMT.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                vector = Vector2(x, y)
            else
                GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeVector"),client,Color(255,0,128,255))
                return
            end
        else
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeVector"),client,Color(255,0,128,255))
            return
        end
    end

    if args[3] == nil or args[3] == "set" then
        sub.subBody.Body.LinearVelocity = vector
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineThrow_Set", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),client,Color(255,0,255,255))
    elseif args[3] == "add" then
        sub.subBody.Body.LinearVelocity = sub.subBody.Body.LinearVelocity + vector
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineThrow_Add", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeMode"),client,Color(255,0,128,255))
        return
    end
    
end)

GMT.AssignServerCommand("subthrow",function(args)
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

    local vector = Vector2.Zero
    if args[2] == "cursor" or args[2] == "ncursor" then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_NoCursor"),Color(255,0,128,255))
    else
        local split = GMT.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                vector = Vector2(x, y)
            else
                GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeVector"),Color(255,0,128,255))
                return
            end
        else
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeVector"),Color(255,0,128,255))
            return
        end
    end

    if args[3] == nil or args[3] == "set" then
        sub.subBody.Body.LinearVelocity = vector
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineThrow_Set", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),Color(255,0,255,255))
    elseif args[3] == "add" then
        sub.subBody.Body.LinearVelocity = sub.subBody.Body.LinearVelocity + vector
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineThrow_Add", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),Color(255,0,255,255))
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineThrow_UnknownTypeMode"),Color(255,0,128,255))
        return
    end
end)