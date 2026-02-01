local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")

command.AddCommand("unjobban",GMT.Lang("Help_UnJobban"),false,nil,{
{name="player",desc=GMT.Lang("Args_UnJobban_player")},
{name="job",desc=GMT.Lang("Args_UnJobban_job")}
})

command.AssignServerCommand("unjobban",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
        return
    end

    local player = utils.GetClientByString(args[1])
    local job = args[2]
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Checking job
    if job ~= nil and JobPrefab.Get(job) == nil then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255),false)
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_All",{name}),Color(255,0,128,255),false)
        GMT.PlayerData.Players[steam_id].Jobbans = {}
        playerdb.Save()
    else
        for i, jb in ipairs(GMT.PlayerData.Players[steam_id].Jobbans) do
            if jb.job == job then
                local name = steam_id
                if player ~= nil then name = player.Name end
                table.remove(GMT.PlayerData.Players[steam_id].Jobbans, i)
                utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_Job",{job,name}),Color(255,0,128,255),false)
                playerdb.Save()
                return
            end
        end
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_NoBan"),Color(255,0,0,255),false)
    end
end)

command.AssignClientCommand("unjobban",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local player = utils.GetClientByString(args[1])
    local job = args[2]
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Checking job
    if job ~= nil and JobPrefab.Get(job) == nil then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),client,Color(255,0,0,255))
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_All",{name}),client,Color(255,0,128,255))
        GMT.PlayerData.Players[steam_id].Jobbans = {}
        playerdb.Save()
    else
        for i, jb in ipairs(GMT.PlayerData.Players[steam_id].Jobbans) do
            if jb.job == job then
                local name = steam_id
                if player ~= nil then name = player.Name end
                -- ТУТ Я ПОШЁЛ КУШАТЬ
                -- ТУТ Я ПОЕЛ
                table.remove(GMT.PlayerData.Players[steam_id].Jobbans, i)
                utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_Job",{job,name}),client,Color(255,0,128,255))
                playerdb.Save()
                return
            end
        end
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_NoBan"),client,Color(255,0,0,255))
    end
    --

end)