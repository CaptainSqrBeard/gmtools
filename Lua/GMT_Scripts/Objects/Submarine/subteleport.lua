

GMT.AddCommand("subtp",GMT.Lang("Help_SubmarineTeleport"),true,nil,{
    {name="submarine",desc=GMT.Lang("Args_SubmarineTp_submarine")},
    {name="position",desc=GMT.Lang("Args_SubmarineTp_position")}})

GMT.AssignSharedCommand("subtp",function (args, interface)
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

    local endPos = nil

    if args[2] == nil then
        if interface.cursor ~= nil then
            endPos = interface.cursor
        else
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_NoPosition"),Color(255,0,128,255))
            return
        end
    elseif args[2] == "cursor" then
        if interface.cursor == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_NoCursor"),Color(255,0,128,255))
            return
        else
            endPos = interface.cursor
        end
    elseif args[2] == "start" then
        if Level.Loaded == nil then
            interface.showMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.StartPosition

        if (Level.Loaded.StartOutpost ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
        end
    elseif args[2] == "end" then
        if Level.Loaded == nil then
            interface.showMessage("GMTools: "..GMT.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
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
                interface.showMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
                return
            end
        else
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
            return
        end
    end

    if endPos ~= nil then
        interface.showMessage(GMT.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),Color(255,0,255,255))
        sub.SetPosition(endPos);
    end
end)