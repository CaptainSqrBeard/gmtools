local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    command.AddCommand("subtp",lang.Lang("Help_SubmarineTeleport"),true,nil,{
        {name="submarine",desc=lang.Lang("Args_SubmarineTp_submarine")},
        {name="position",desc=lang.Lang("Args_SubmarineTp_position")}})

    command.AssignSharedCommand("subtp",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("subtp"),Color(255,0,128,255))
            return
        end

        local sub_id = tonumber(args[1])
        local sub = Submarine.Loaded[sub_id]
        if sub == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
            return
        end

        local endPos = nil

        if args[2] == nil then
            if interface.cursor ~= nil then
                endPos = interface.cursor
            else
                interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_NoPosition"),Color(255,0,128,255))
                return
            end
        elseif args[2] == "cursor" then
            if interface.cursor == nil then
                interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_NoCursor"),Color(255,0,128,255))
                return
            else
                endPos = interface.cursor
            end
        elseif args[2] == "start" then
            if Level.Loaded == nil then
                interface.showMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
                return
            end
            endPos = Level.Loaded.StartPosition

            if (Level.Loaded.StartOutpost ~= nil) then
                endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.StartOutpost.Borders.Height) / 2;
            end
        elseif args[2] == "end" then
            if Level.Loaded == nil then
                interface.showMessage("GMTools: "..lang.Lang("Error_LevelIsNotLoaded"),Color(255,0,128,255))
                return
            end
            endPos = Level.Loaded.EndPosition

            if (Level.Loaded.EndPosition ~= nil) then
                endPos.y = endPos.y - (sub.Borders.Height + Level.Loaded.EndOutpost.Borders.Height) / 2;
            end
        else
            local vector2 = utils.GetVector2FromString(args[2])
            if vector2 == nil then
                interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_UnknownType"),Color(255,0,128,255))
                return
            else
                endPos = vector2
            end
        end

        if endPos ~= nil then
            interface.showMessage(lang.Lang("CMD_SubmarineTp_Success", {sub.Info.Name, math.floor(sub.WorldPosition.x), math.floor(sub.WorldPosition.y), math.floor(endPos.x), math.floor(endPos.y)}),Color(255,0,255,255))
            sub.SetPosition(endPos);
        end
    end)
end

return module