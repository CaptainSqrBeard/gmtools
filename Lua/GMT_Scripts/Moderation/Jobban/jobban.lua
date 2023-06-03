local STEAM_ID_LENGTH = 17

GMT.AddCommand("jobban",GMT.Lang("Help_Jobban"),false,nil,{
{name="player",desc=GMT.Lang("Args_Jobban_player")},
{name="job",desc=GMT.Lang("Args_Jobban_job")},
{name="duration",desc=GMT.Lang("Args_Jobban_duration")},
{name="reason",desc=GMT.Lang("Args_Jobban_reason")}

})

GMT.AssignClientCommand("jobban",function(client,cursor,args)
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
        if steam_id:len() ~= STEAM_ID_LENGTH then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Can't jobban player with permission to jobban
    if GMT.HasGMTPermissionOffline(steam_id, ".jobban") then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_AdminIssue"),client,Color(255,0,0,255))
        return
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
end)

GMT.AssignServerCommand("jobban",function(args)
    if #args < 2 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
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
        if steam_id:len() ~= STEAM_ID_LENGTH then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Can't jobban player with permission to jobban
    if GMT.HasGMTPermissionOffline(steam_id, ".jobban") then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_AdminIssue"),Color(255,0,0,255),false)
        return
    end

    -- Checking job
    if JobPrefab.Get(job) == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255),false)
        return
    end
    if job == GMT.Config.Vars.lowest_job then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_BanLowest"),Color(255,0,0,255),false)
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

    -- Checking reason
    if args[reason_start] ~= nil then
        reason = ""
        for i = reason_start, #args, 1 do
            reason = reason..args[i].." "
        end
        reason = reason:sub(1,reason:len()-1)
    end
    
    if player ~= nil then
        GMT.NewConsoleMessage(GMT.Lang("CMD_Jobban_ConsoleOut",{job,player.Name,reason,GMT.GetTimeString(duration)}),Color(255,0,128,255),false)
        GMT.PlayerData.JobBan(player,job,duration,reason)
    elseif steam_id ~= nil then
        GMT.NewConsoleMessage(GMT.Lang("CMD_Jobban_ConsoleOut",{job,steam_id,reason,GMT.GetTimeString(duration)}),Color(255,0,128,255),false)
        GMT.PlayerData.JobBanSteam(steam_id,job,duration,reason)
    end
end)