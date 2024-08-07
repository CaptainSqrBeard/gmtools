GMT.AddCommand("revokeperm",GMT.Lang("Help_RevokePerm"),false,nil,{
    {name="player",desc=GMT.Lang("Args_RevokePerm_player")},
    {name="commands",desc=GMT.Lang("Args_RevokePerm_commands")}
})

GMT.AssignSharedCommand("revokeperm",function (args, interface)
    -- Get client
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        interface.showMessage("GM-Tools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Revoking all perms if parameter is 'all'
    if args[2] == "all" then
        interface.showMessage("GM-Tools: "..GMT.Lang("CMD_RevokePerm_all",{r_client.Name}),Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = {}
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    interface.showMessage(GMT.Lang("CMD_RevokePerm_header",{r_client.Name}),Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local found = false

        -- If not a GMTools command
        if not GMT.Contains(GMT.AllCommands, cmd) then
            interface.showMessage(GMT.Lang("CMD_RevokePerm_notexists",{cmd}),Color(255,200,200,255))
        else
            -- Searching perms for current command
            for pi, pcmd in ipairs(perms) do
                if pcmd == cmd then
                    table.remove(perms,pi)
                    found = true
                    interface.showMessage(GMT.Lang("CMD_RevokePerm_revoked",{cmd}),Color(255,255,255,255))
                    break
                end
            end
            
            if not found then
                interface.showMessage(GMT.Lang("CMD_RevokePerm_donthave",{cmd}),Color(255,200,200,255))
            end

        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end)