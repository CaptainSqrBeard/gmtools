GMT.AddCommand("jobban","Bans job for player, so he can't play on it",false,function(client,cursor,args)
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: Not enough arguments",client,Color(255,0,0,255))
            return
    end

    local player = GMT.GetClientByString(args[1])
    local job = args[2]
    local duration = 0
    local reason = "No reason"
    
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            GMT.SendConsoleMessage("GMTools: Unknown player",client,Color(255,0,0,255))
            return
        end
    end

    -- Checking job
    if JobPrefab.Get(job) == nil then
        GMT.SendConsoleMessage("GMTools: Job is not exist",client,Color(255,0,0,255))
        return
    end
    if job == GMT.Config.Vars.lowest_job then
        GMT.SendConsoleMessage("GMTools: You can't job-ban the lowest job",client,Color(255,0,0,255))
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
        GMT.SendConsoleMessage("GMTools: Job-banned \""..job.."\" for "..player.Name..".\nReason: "..reason.."\nDuration: "..GMT.GetTimeString(duration),client,Color(255,0,128,255))
        GMT.PlayerData.JobBan(player,job,duration,reason)
    elseif steam_id ~= nil then
        GMT.SendConsoleMessage("GMTools: Job-banned \""..job.."\" for "..steam_id..".\nReason: "..reason.."\nDuration: "..GMT.GetTimeString(duration),client,Color(255,0,128,255))
        GMT.PlayerData.JobBanSteam(steam_id,job,duration,reason)
    end
end,{
{name="player",desc="Name/ID/SteamID of player"},
{name="job",desc="Job that will be banned for this player"},
{name="duration",desc="Duration of job-ban. Leave empty to permanent ban"},
{name="reason",desc="Reason, why player has been job-banned."}

})

GMT.AddCommand("unjobban","Un-Bans job for player",false,function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: Not enough arguments",client,Color(255,0,0,255))
            return
    end

    local player = GMT.GetClientByString(args[1])
    local job = args[2]
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            GMT.SendConsoleMessage("GMTools: Unknown player",client,Color(255,0,0,255))
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Checking job
    if job ~= nil and JobPrefab.Get(job) == nil then
        GMT.SendConsoleMessage("GMTools: Job is not exist",client,Color(255,0,0,255))
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        GMT.SendConsoleMessage("GMTools: Removed all job-bans from player "..name,client,Color(255,0,128,255))
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
                GMT.SendConsoleMessage("GMTools: Removed job-ban on \""..job.."\" for "..name,client,Color(255,0,128,255))
                GMT.PlayerData.Save()
                return
            end
        end
        GMT.SendConsoleMessage("GMTools: Player didn't had job-ban on this job",client,Color(255,0,0,255))
    end
    --

end,{
{name="player",desc="Name/ID/SteamID of player"},
{name="job",desc="Job that will be unbanned for this player"}
})