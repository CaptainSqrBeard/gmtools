local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local gameInfo = require("GMT_Scripts._UTILS.gameInfo")

command.AssignSharedCommand("humanlist",function (args, interface)
    interface.showMessage(lang.Lang("CMD_HumanList_header"),Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            interface.showMessage(lang.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
        end
    end
end)