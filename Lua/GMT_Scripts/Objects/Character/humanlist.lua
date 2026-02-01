local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("humanlist",lang.Lang("Help_HumanList"),true,nil)

command.AssignClientCommand("humanlist",function(client,cursor,args)
    utils.SendConsoleMessage(lang.Lang("CMD_HumanList_header"),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            utils.SendConsoleMessage(lang.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),client,Color(255,255,255,255))
        end
    end
end)

command.AssignServerCommand("humanlist",function(args)
    utils.NewConsoleMessage(lang.Lang("CMD_HumanList_header"),Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            utils.NewConsoleMessage(lang.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
        end
    end
end)