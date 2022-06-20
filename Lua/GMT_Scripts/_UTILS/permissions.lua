function GMT.RestorePerms(client)
    local playerCommands = GMT.Config.Vars.player_commands
    local list = {}
    local add_list = {}

    for i, cmd in ipairs(Game.Commands) do
        if GMT.Contains(playerCommands, cmd.names[1]) then
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
    local playerCommands = GMT.Config.Vars.player_commands
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end
    if client.HasPermission(ClientPermissions.All) then return true end

    if GMT.Contains(playerCommands,command) then return true end

    for cmd in client.PermittedConsoleCommands do
        if cmd == GMT.GetCommandByString(command) then return true end
    end
    return false
end