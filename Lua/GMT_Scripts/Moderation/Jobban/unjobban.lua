local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")
local sanctions = require("GMT_Scripts._UTILS.sanctions")

function module.initialize()
    command.AddCommand("unjobban",lang.Lang("Help_UnJobban"),false,nil,{
    {name="player",desc=lang.Lang("Args_UnJobban_player")},
    {name="job/ban_id",desc=lang.Lang("Args_UnJobban_job"),optional=true}
    })

    command.AssignSharedCommand("unjobban",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("unjobban"),Color(255,0,0,255))
            return
        end

        local player = utils.GetClientByString(args[1])
        local job_or_id = args[2]
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

        local ban_id = tonumber(job_or_id)

        -- Checking job
        if job_or_id ~= nil and utils.GetJobPrefab(job_or_id) == nil and ban_id == nil then
            interface.showMessage("GMTools: "..lang.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255))
            return
        end

        local entry = playerdb.GetEntry(steam_id)
        local name = steam_id
        if player ~= nil then
            name = player.Name
        end

        if job_or_id == nil then
            -- Remove all job bans
            interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_All",{name}),Color(255,0,128,255))
            for i, ban in ipairs(sanctions.getActiveSanctions(entry, "job_ban")) do
                ban.revoked = true
            end
            playerdb.SavePlayer(steam_id)
        else
            if ban_id == nil then
                -- Remove jobban by job
                interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_Job",{job_or_id,name}),Color(255,0,128,255))
                for i, ban in ipairs(playerdb.GetJobBans(steam_id, job_or_id)) do
                    ban.revoked = true
                end
                playerdb.SavePlayer(steam_id)
            else
                -- Remove jobban by id
                local allBans = sanctions.getSanctions(entry, "job_ban")
                if utils.InRange(ban_id, 1, #allBans) then
                    if not sanctions.isActiveSanction(allBans[ban_id]) then
                        interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_BanInactive"),Color(255,0,0,255))
                        return
                    end
                    interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_Id",{ban_id,name}),Color(255,0,128,255))
                    allBans[ban_id].revoked = true
                    playerdb.SavePlayer(steam_id)
                else
                    interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_OutOfRange"),Color(255,0,0,255))
                    return
                end
            end
        end
    end)
end

return module