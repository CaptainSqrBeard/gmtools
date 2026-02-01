local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("unjobban",lang.Lang("Help_UnJobban"),false,nil,{
{name="player",desc=lang.Lang("Args_UnJobban_player")},
{name="job",desc=lang.Lang("Args_UnJobban_job"),optional=true}
})

command.AssignSharedCommand("unjobban",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("unjobban"),Color(255,0,0,255))
        return
    end

    local player = utils.GetClientByString(args[1])
    local job = args[2]
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

    -- Checking job
    if job ~= nil and GMT.GetJobPrefab(job) == nil then
        interface.showMessage("GMTools: "..lang.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255))
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_All",{name}),Color(255,0,128,255))
        GMT.PlayerData.Players[steam_id].Jobbans = {}
        playerdb.Save()
    else
        for i, jb in ipairs(GMT.PlayerData.Players[steam_id].Jobbans) do
            if jb.job == job then
                local name = steam_id
                if player ~= nil then name = player.Name end
                table.remove(GMT.PlayerData.Players[steam_id].Jobbans, i)
                interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_Job",{job,name}),Color(255,0,128,255))
                playerdb.Save()
                return
            end
        end
        interface.showMessage("GMTools: "..lang.Lang("CMD_UnJobban_NoBan"),Color(255,0,0,255))
    end
end)
