function GMT.RestorePerms(client)
    local playerCommands = GMT.Config.Vars.player_commands
    local list = {}
    local add_list = {}

    GMT.PlayerData.Create(client)

    for i, cmd in ipairs(Game.Commands) do
        if GMT.Contains(playerCommands, cmd.names[1]) or GMT.Contains(GMT.PlayerData.Players[client.SteamID].Permissions, cmd.names[1]) then
            table.insert(add_list,cmd)
        end
    end

    for cmd in client.PermittedConsoleCommands do
        table.insert(list,cmd)
    end

    client.GivePermission(ClientPermissions.ConsoleCommands);
    client.SetPermissions(client.Permissions,GMT.Union(list,add_list))
end

function GMT.HasPermission(client,command)
    -- Host has permission to everything
    if not Game.IsDedicated and client.ID == 1 then
        return true
    end

    local playerCommands = GMT.Config.Vars.player_commands
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    if GMT.Contains(playerCommands,command) then return true end

    for cmd in client.PermittedConsoleCommands do
        if cmd == GMT.GetCommandByString(command) then return true end
    end
    return false
end

function GMT.HasGMTPermission(client,command)
    -- Host has permission to everything
    if not Game.IsDedicated and client.ID == 1 then
        return true
    end

    local playerCommands = GMT.Config.Vars.player_commands
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    if GMT.Contains(playerCommands,command) then return true end

    GMT.PlayerData.Create(client)
    if GMT.Contains(GMT.PlayerData.Players[client.SteamID].Permissions, command) then return true end
    return false
end

function GMT.HasGMTPermissionOffline(steamid,command)
    local playerCommands = GMT.Config.Vars.player_commands

    if GMT.Contains(playerCommands,command) then return true end

    GMT.PlayerData.CreateSteam("Unknown", steamid)
    if GMT.Contains(GMT.PlayerData.Players[steamid].Permissions, command) then return true end
    return false
end