local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local gameInfo = require("GMT_Scripts._UTILS.gameInfo")

command.AddCommand("sublist",lang.Lang("Help_SubmarineList"),true,nil)

command.AssignSharedCommand("sublist",function (args, interface)
    interface.showMessage(lang.Lang("CMD_SubmarineList_header"),Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = lang.Lang(gameInfo.GetLocalizedSubmarineType(sub.Info.Type))
        if sub.IsRespawnShuttle then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..lang.Lang("CMD_SubmarineList_mainsub")
        end
        interface.showMessage(lang.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), Color(255,255,255,255))
    end
end)
