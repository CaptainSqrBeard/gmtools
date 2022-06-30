GMT.AddCommand("giveperm",GMT.Lang("Help_GivePerm"),false,function (client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end
    
    -- Get client
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Granting all perms if parameter is 'all'
    if args[2] == "all" then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_GivePerm_all",{r_client.Name}),client,Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = GMT.AllCommands
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    GMT.SendConsoleMessage(GMT.Lang("CMD_GivePerm_header",{r_client.Name}),client,Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local error = false  -- World if Lua has 'continue'...

        -- If already has this command
        if GMT.Contains(perms, cmd) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_GivePerm_alreadyhas",{cmd}),client,Color(255,200,200,255))
            error = true
        end
        -- If not a GMTools command
        if not error and not GMT.Contains(GMT.AllCommands, cmd) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_GivePerm_notexists",{cmd}),client,Color(255,200,200,255))
            error = true
        end

        -- Everything okay, adding command
        if not error then
            GMT.SendConsoleMessage(GMT.Lang("CMD_GivePerm_added",{cmd}),client,Color(255,255,255,255))
            table.insert(perms,cmd)
        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end,{
    {name="player",desc=GMT.Lang("Args_GivePerm_player")},
    {name="commands",desc=GMT.Lang("Args_GivePerm_commands")}
})

GMT.AddCommand("revokeperm",GMT.Lang("Help_RevokePerm"),false,function (client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if #args < 2 then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end
    
    -- Get client
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Revoking all perms if parameter is 'all'
    if args[2] == "all" then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_RevokePerm_all",{r_client.Name}),client,Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = {}
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    GMT.SendConsoleMessage(GMT.Lang("CMD_RevokePerm_header",{r_client.Name}),client,Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local found = false

        -- If not a GMTools command
        if not GMT.Contains(GMT.AllCommands, cmd) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_RevokePerm_notexists",{cmd}),client,Color(255,200,200,255))
        else
            -- Searching perms for current command
            for pi, pcmd in ipairs(perms) do
                if pcmd == cmd then
                    table.remove(perms,pi)
                    found = true
                    GMT.SendConsoleMessage(GMT.Lang("CMD_RevokePerm_revoked",{cmd}),client,Color(255,255,255,255))
                    break
                end
            end
            
            if not found then
                GMT.SendConsoleMessage(GMT.Lang("CMD_RevokePerm_donthave",{cmd}),client,Color(255,200,200,255))
            end

        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end,{
    {name="player",desc=GMT.Lang("Args_RevokePerm_player")},
    {name="commands",desc=GMT.Lang("Args_RevokePerm_commands")}
})

GMT.AddCommand("permlist",GMT.Lang("Help_PermList"),false,function (client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    
    -- Get client
    local r_client
    if args[1] == nil then
        -- Player not specified, apply to yourself
        r_client = client
    else
        -- Try to apply on specified player
        r_client = GMT.GetClientByString(args[1])
        if r_client == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    end
    GMT.PlayerData.Create(r_client)

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    GMT.SendConsoleMessage(GMT.Lang("CMD_PermList_header",{r_client.Name}),client,Color(255,0,255,255))
    for i, cmd in ipairs(perms) do
        GMT.SendConsoleMessage(GMT.Lang("CMD_PermList_item",{cmd}),client,Color(255,255,255,255))
    end
    
end,{
    {name="player",desc=GMT.Lang("Args_PermList_player")}
})