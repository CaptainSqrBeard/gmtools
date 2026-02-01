local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local player = require("GMT_Scripts._UTILS.player")
local playerdb = require("GMT_Scripts._UTILS.playerdb")

function module.RestorePerms(client)
    local playerCommands = GMT.Config.Vars.player_commands
    local list = {}
    local add_list = {}

    playerdb.Create(client)

    for i, cmd in ipairs(Game.Commands) do
        if utils.Contains(playerCommands, cmd.names[1]) or utils.Contains(GMT.PlayerData.Players[client.SteamID].Permissions, cmd.names[1]) then
            table.insert(add_list,cmd)
        end
    end

    -- Get all permitted commands to player
    for cmd in client.PermittedConsoleCommands do
        table.insert(list,cmd)
    end

    -- Filter out all GMT commands.
    local output_list = {}
    for i, cmd in ipairs(list) do
        if not utils.Contains(GMT.AllCommands,cmd.names[1]) then
            table.insert(output_list,cmd)
        end
    end

    client.GivePermission(ClientPermissions.ConsoleCommands);
    client.SetPermissions(client.Permissions, utils.Union(output_list, add_list))
end

function module.HasPermission(client,command)
    utils.Expect(2, command, "string")

    -- Host has permission to everything
    if not Game.IsDedicated and client.SessionId == 1 then
        return true
    end

    local playerCommands = GMT.Config.Vars.player_commands

    if utils.Contains(playerCommands,command) then return true end

    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    for cmd in client.PermittedConsoleCommands do
        if cmd == command.GetCommandByString(command) then return true end
    end
    return false
end

function module.HasGMTPermission(client,command)
    utils.Expect(2, command, "string")

    -- Host has permission to everything
    if not Game.IsDedicated and client.SessionId == 1 then
        return true
    end

    local playerCommands = GMT.Config.Vars.player_commands

    if utils.Contains(playerCommands,command) then return true end
    
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    playerdb.Create(client)
    if utils.Contains(GMT.PlayerData.Players[client.SteamID].Permissions, command) then return true end
    return false
end

function module.HasGMTPermissionOffline(steamid,command)
    utils.Expect(2, command, "string")
    
    local playerCommands = GMT.Config.Vars.player_commands

    if utils.Contains(playerCommands,command) then return true end

    playerdb.CreateSteam("Unknown", steamid)
    if utils.Contains(GMT.PlayerData.Players[steamid].Permissions, command) then return true end
    return false
end

return module