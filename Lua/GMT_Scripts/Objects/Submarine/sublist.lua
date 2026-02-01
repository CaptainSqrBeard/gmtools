local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("sublist",lang.Lang("Help_SubmarineList"),true,nil)

command.AssignClientCommand("sublist",function(client,cursor,args)
    utils.SendConsoleMessage(lang.Lang("CMD_SubmarineList_header"),client,Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = lang.Lang(GMT.SubmarineTypes[sub.Info.Type+1])
        if sub == Game.RespawnManager.RespawnShuttle then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_mainsub")
        end
        utils.SendConsoleMessage(lang.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), client, Color(255,255,255,255))
    end
end)

command.AssignServerCommand("sublist",function(args)
    utils.NewConsoleMessage(lang.Lang("CMD_SubmarineList_header"),Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = lang.Lang(GMT.SubmarineTypes[sub.Info.Type+1])
        if sub == Game.RespawnManager.RespawnShuttle then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_mainsub")
        end
        utils.NewConsoleMessage(lang.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), Color(255,255,255,255))
    end
end)