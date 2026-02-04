local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")
local sanctions = require("GMT_Scripts._UTILS.sanctions")

function module.initialize()
    command.AddCommand("jobban_list",lang.Lang("Help_JobbanList"),false,nil,{
    {name="player",desc=lang.Lang("Args_JobbanList_player")}
    })

    command.AssignSharedCommand("jobban_list",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("jobban_list"),Color(255,0,0,255))
            return
        end

        local player = utils.GetClientByString(args[1])
        local steam_id
        local job = args[2]
        
        -- Checking job
        if job ~= nil and utils.GetJobPrefab(job) == nil then
            interface.showMessage("GMTools: "..lang.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255))
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

        local entry = playerdb.GetEntry(steam_id)
        local jobbans = sanctions.getSanctions(entry, "job_ban")
        
        local name = steam_id
        if player ~= nil then
            name = player.Name
        end

        interface.showMessage(lang.Lang("CMD_JobbanList_header", {name}),Color(255,0,255,255))
        for i, ban in ipairs(jobbans) do
            local bannedJob = ban.additionalData.job
            local banReason = ban.additionalData.reason
            local givenTime = os.date("%d.%m.%y %H:%M:%S", ban.givenAt)
            local durationTime
            if ban.expiresAt == -1 then
                durationTime = lang.GetTimeString(0)
            else
                durationTime = lang.GetTimeString(ban.expiresAt - ban.givenAt)
            end

            if ban.revoked then
                interface.showMessage(lang.Lang("CMD_JobbanList_Entry_Revoked",{i, bannedJob, banReason, givenTime, durationTime}),Color(192,192,192,255))
            elseif not sanctions.isActiveSanction(ban) then
                interface.showMessage(lang.Lang("CMD_JobbanList_Entry_Expired",{i, bannedJob, banReason, givenTime, durationTime}),Color(192,192,192,255))
            else
                interface.showMessage(lang.Lang("CMD_JobbanList_Entry_Active",{i, bannedJob, banReason, givenTime, durationTime}),Color(255,255,255,255))
            end
        end
    end)
end

return module