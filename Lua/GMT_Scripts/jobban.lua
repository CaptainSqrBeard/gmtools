GMT.AddCommand("jobban",GMT.Lang("Help_Jobban"),false,function(client,cursor,args)
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
            return
    end

    local player = GMT.GetClientByString(args[1])
    local job = args[2]
    local duration = 0
    local reason = GMT.Lang("CMD_Jobban_NoReason")
    
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    end

    -- Checking job
    if JobPrefab.Get(job) == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),client,Color(255,0,0,255))
        return
    end
    if job == GMT.Config.Vars.lowest_job then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_BanLowest"),client,Color(255,0,0,255))
        return
    end

    local reason_start = 3
    -- Checking duration
    for i = 3, #args, 1 do
        local value = tonumber(args[i]:sub(1, args[i]:len()-1))
        local t = args[i]:sub(args[i]:len(), args[i]:len())
        if value == nil then
            reason_start = i
            break
        end
        if t == 'd' then
            duration = duration+value*86400
        elseif t == 'h' then
            duration = duration+value*3600
        elseif t == 'm' then
            duration = duration+value*60
        elseif t == 's' then
            duration = duration+value
        else
            reason_start = i
            break
        end
        reason_start = i+1
    end
    
    print(reason_start)

    -- Checking reason
    if args[reason_start] ~= nil then
        reason = ""
        for i = reason_start, #args, 1 do
            reason = reason..args[i].." "
        end
        reason = reason:sub(1,reason:len()-1)
    end
    
    if player ~= nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_Jobban_ConsoleOut",{job,player.Name,reason,GMT.GetTimeString(duration)}),client,Color(255,0,128,255))
        GMT.PlayerData.JobBan(player,job,duration,reason)
    elseif steam_id ~= nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_Jobban_ConsoleOut",{job,steam_id,reason,GMT.GetTimeString(duration)}),client,Color(255,0,128,255))
        GMT.PlayerData.JobBanSteam(steam_id,job,duration,reason)
    end
end,{
{name="player",desc=GMT.Lang("Args_Jobban_player")},
{name="job",desc=GMT.Lang("Args_Jobban_job")},
{name="duration",desc=GMT.Lang("Args_Jobban_duration")},
{name="reason",desc=GMT.Lang("Args_Jobban_reason")}

})

GMT.AddCommand("unjobban",GMT.Lang("Help_UnJobban"),false,function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local player = GMT.GetClientByString(args[1])
    local job = args[2]
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Checking job
    if job ~= nil and JobPrefab.Get(job) == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),client,Color(255,0,0,255))
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_All",{name}),client,Color(255,0,128,255))
        GMT.PlayerData.Players[steam_id].Jobbans = {}
        GMT.PlayerData.Save()
    else
        for i, jb in ipairs(GMT.PlayerData.Players[steam_id].Jobbans) do
            if jb.job == job then
                local name = steam_id
                if player ~= nil then name = player.Name end
                -- ТУТ Я ПОШЁЛ КУШАТЬ
                -- ТУТ Я ПОЕЛ
                table.remove(GMT.PlayerData.Players[steam_id].Jobbans, i)
                GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_Job",{job,name}),client,Color(255,0,128,255))
                GMT.PlayerData.Save()
                return
            end
        end
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_NoBan"),client,Color(255,0,0,255))
    end
    --

end,{
{name="player",desc=GMT.Lang("Args_UnJobban_player")},
{name="job",desc=GMT.Lang("Args_UnJobban_job")}
})