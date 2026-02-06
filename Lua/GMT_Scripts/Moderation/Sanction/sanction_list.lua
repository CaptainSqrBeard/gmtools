local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")
local sanctions = require("GMT_Scripts._UTILS.sanctions")

function module.initialize()
    command.AddCommand("sanction_list",lang.Lang("Help_SanctionList"),false,nil,{
    {name="player",desc=lang.Lang("Args_SanctionList_player")}
    })

    command.AssignSharedCommand("sanction_list",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("jobban_list"),Color(255,0,0,255))
            return
        end

        local player = utils.GetClientByString(args[1])
        local steam_id

        -- Checking player
        if player == nil then
            steam_id = string.match(args[1],'%d+')
            if steam_id:len() ~= 17 then
                interface.showMessage("GMTools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
                return
            end
        else
            steam_id = player.SteamID
        end

        local entry = playerdb.GetEntry(steam_id)
        
        local name = steam_id
        if player ~= nil then
            name = player.Name
        end

        interface.showMessage(lang.Lang("CMD_SanctionList_header", {name}),Color(255,0,255,255))
        for i, sanction in ipairs(entry.sanctions) do
            local visualized = sanctions.getAsString(sanction)
            if sanction.revoked then
                interface.showMessage(lang.Lang("CMD_SanctionList_Entry_Revoked",{i, visualized}),Color(192,192,192,255))
            elseif not sanctions.isActiveSanction(sanction) then
                interface.showMessage(lang.Lang("CMD_SanctionList_Entry_Expired",{i, visualized}),Color(192,192,192,255))
            else
                interface.showMessage(lang.Lang("CMD_SanctionList_Entry_Active",{i, visualized}),Color(255,255,255,255))
            end
        end
    end)
end

return module