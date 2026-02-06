local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")
local sanctions = require("GMT_Scripts._UTILS.sanctions")

function module.initialize()
    command.AddCommand("sanction_delete",lang.Lang("Help_SanctionDelete"),false,nil,{
    {name="player",desc=lang.Lang("Args_DelecteSanction_player")},
    {name="sanction_id",desc=lang.Lang("Args_DelecteSanction_id")}
    })

    command.AssignSharedCommand("sanction_delete",function (args, interface)
        if #args < 2 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("unjobban"),Color(255,0,0,255))
            return
        end

        local player = utils.GetClientByString(args[1])
        local sanction_id = args[2]
        local steam_id
        
        local ban_id = tonumber(sanction_id)
        if ban_id == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_bad_id"),Color(255,0,0,255))
            return
        end

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
        
        local name = steam_id
        if player ~= nil then
            name = player.Name
        end

        local entry = playerdb.GetEntry(steam_id)
        local allSanctions = entry.sanctions

        if not utils.InRange(ban_id, 1, #allSanctions) then
            interface.showMessage("GMTools: "..lang.Lang("CMD_SanctionDelete_OutOfRange"),Color(255,0,0,255))
            return
        end

        table.remove(allSanctions, ban_id)
        interface.showMessage(lang.Lang("CMD_SanctionDelete_removed", {ban_id, name}),Color(255,0,255,255))

        playerdb.SavePlayer(steam_id)
    end)
end

return module