local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local gameInfo = require("GMT_Scripts._UTILS.gameInfo")

function module.initialize()
    command.AddCommand("humanlist",lang.Lang("Help_HumanList"),true,nil)

    command.AssignSharedCommand("humanlist",function (args, interface)
        interface.showMessage(lang.Lang("CMD_HumanList_header"),Color(255,0,255,255))
        for i, char in ipairs(Character.CharacterList) do
            if char.IsHuman then
                interface.showMessage(lang.Lang("CMD_HumanList_char",{char.Name, char.ID, gameInfo.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
            end
        end
    end)
end

return module