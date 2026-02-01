local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("subtp",lang.Lang("Help_SubmarineTeleport"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineTp_submarine")},
    {name="position",desc=lang.Lang("Args_SubmarineTp_position")}})

command.AssignClientCommand("subtp",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),client,Color(255,0,128,255))
        return
    end

    local endPos = nil

    if args[2] == nil or args[2] == "cursor" then
        endPos = cursor
    elseif args[2] == "start" then
        if Level.Loaded == nil then
            utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),client,Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.StartPosition

        if (Level.Loaded.StartOutpost ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
        end
    elseif args[2] == "end" then
        if Level.Loaded == nil then
            utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),client,Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.EndPosition

        if (Level.Loaded.EndPosition ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.EndOutpost.Borders.Height) / 2;
        end
    else
        local split = utils.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                endPos = Vector2(x, y)
            else
                utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_UnknownType"),client,Color(255,0,128,255))
                return
            end
        else
            utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_UnknownType"),client,Color(255,0,128,255))
            return
        end
    end

    if endPos ~= nil then
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),client,Color(255,0,255,255))
        sub.SetPosition(endPos);
    end
end)

command.AssignServerCommand("subtp",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    local endPos = nil

    if args[2] == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_NoPosition"),Color(255,0,128,255))
        return
    elseif args[2] == "cursor" then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_NoCursor"),Color(255,0,128,255))
        return
    elseif args[2] == "start" then
        if Level.Loaded == nil then
            utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.StartPosition

        if (Level.Loaded.StartOutpost ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
        end
    elseif args[2] == "end" then
        if Level.Loaded == nil then
            utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
            return
        end
        endPos = Level.Loaded.EndPosition

        if (Level.Loaded.EndPosition ~= nil) then
            endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.EndOutpost.Borders.Height) / 2;
        end
    else
        local split = utils.Split(args[2], ";")
        if #split == 2 then
            local x = tonumber(split[1])
            local y = tonumber(split[2])
            if x ~= nil and y ~= nil then
                endPos = Vector2(x, y)
            else
                utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
                return
            end
        else
            utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
            return
        end
    end

    if endPos ~= nil then
        utils.NewConsoleMessage(lang.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),Color(255,0,255,255))
        sub.SetPosition(endPos);
    end
end)