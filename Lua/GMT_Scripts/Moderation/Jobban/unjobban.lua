GMT.AddCommand("unjobban",GMT.Lang("Help_UnJobban"),false,nil,{
{name="player",desc=GMT.Lang("Args_UnJobban_player")},
{name="job",desc=GMT.Lang("Args_UnJobban_job")}
})

GMT.AssignServerCommand("unjobban",function(args)
    if #args == 0 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
        return
    end

    local player = GMT.GetClientByString(args[1])
    local job = args[2]
    local steam_id

    -- Checking player
    if player == nil then
        steam_id = string.match(args[1],'%d+')
        if steam_id:len() ~= 17 then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
            return
        end
    else
        steam_id = player.SteamID
    end

    -- Checking job
    if job ~= nil and JobPrefab.Get(job) == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Jobban_UnknownJob"),Color(255,0,0,255),false)
        return
    end

    if job == nil then
        local name = steam_id
        if player ~= nil then name = player.Name end
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_All",{name}),Color(255,0,128,255),false)
        GMT.PlayerData.Players[steam_id].Jobbans = {}
        GMT.PlayerData.Save()
    else
        for i, jb in ipairs(GMT.PlayerData.Players[steam_id].Jobbans) do
            if jb.job == job then
                local name = steam_id
                if player ~= nil then name = player.Name end
                table.remove(GMT.PlayerData.Players[steam_id].Jobbans, i)
                GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_Job",{job,name}),Color(255,0,128,255),false)
                GMT.PlayerData.Save()
                return
            end
        end
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_UnJobban_NoBan"),Color(255,0,0,255),false)
    end
end)

GMT.AssignClientCommand("unjobban",function(client,cursor,args)
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

end)