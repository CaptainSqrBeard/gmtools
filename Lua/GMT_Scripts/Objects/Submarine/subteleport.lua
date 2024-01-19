

GMT.AddCommand("subtp",GMT.Lang("Help_SubmarineTeleport"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineTp_submarine")},
    {name="position",desc=GMT.Lang("Args_SubmarineTp_position")}})

GMT.AssignClientCommand("subtp",function(client,cursor,args)
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

    local endPos = nil

    if args[2] == nil or args[2] == "cursor" then
        endPos = cursor
    elseif args[2] == "start" then
        if Level.Loaded == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),client,Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.StartPosition

        if (Level.Loaded.StartOutpost ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
        end
    elseif args[2] == "end" then
        if Level.Loaded == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),client,Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.EndPosition

        if (Level.Loaded.EndPosition ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.EndOutpost.Borders.Height) / 2;
        end
    else
        local split = GMT.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                endPos = Vector2(x, y)
            else
                GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),client,Color(255,0,128,255))
                return
            end
        else
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),client,Color(255,0,128,255))
            return
        end
    end

    if endPos ~= nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),client,Color(255,0,255,255))
        sub.SetPosition(endPos);
    end
end)

GMT.AssignServerCommand("subtp",function(args)
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

    local endPos = nil

    if args[2] == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_NoPosition"),Color(255,0,128,255))
        return
    elseif args[2] == "cursor" then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_NoCursor"),Color(255,0,128,255))
        return
    elseif args[2] == "start" then
        if Level.Loaded == nil then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.StartPosition

        if (Level.Loaded.StartOutpost ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
        end
    elseif args[2] == "end" then
        if Level.Loaded == nil then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.EndPosition

        if (Level.Loaded.EndPosition ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.EndOutpost.Borders.Height) / 2;
        end
    else
        local split = GMT.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                endPos = Vector2(x, y)
            else
                GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
                return
            end
        else
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
            return
        end
    end

    if endPos ~= nil then
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),Color(255,0,255,255))
        sub.SetPosition(endPos);
    end
end)