GMT.AddCommand("giveperm",GMT.Lang("Help_GivePerm"),false,nil,{
    {name="player",desc=GMT.Lang("Args_GivePerm_player")},
    {name="commands",desc=GMT.Lang("Args_GivePerm_commands")}
})

GMT.AssignSharedCommand("giveperm",function (args, interface)
    if #args < 2 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255))
        return
    end
    
    -- Get client
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Granting all perms if parameter is 'all'
    if args[2] == "all" then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_GivePerm_all",{r_client.Name}),Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = GMT.ListAllCommands()
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    interface.showMessage(GMT.Lang("CMD_GivePerm_header",{r_client.Name}),Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local error = false  -- World if Lua has 'continue'...

        -- If already has this command
        if GMT.Contains(perms, cmd) then
            interface.showMessage(GMT.Lang("CMD_GivePerm_alreadyhas",{cmd}),Color(255,200,200,255))
            error = true
        end
        -- If not a GMTools command
        if not error and not GMT.Contains(GMT.AllCommands, cmd) then
            interface.showMessage(GMT.Lang("CMD_GivePerm_notexists",{cmd}),Color(255,200,200,255))
            error = true
        end

        -- Everything okay, adding command
        if not error then
            interface.showMessage(GMT.Lang("CMD_GivePerm_added",{cmd}),Color(255,255,255,255))
            table.insert(perms,cmd)
        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end)
