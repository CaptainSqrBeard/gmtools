local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local player = require("GMT_Scripts._UTILS.player")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local config = require("GMT_Scripts._UTILS.config")

function module.RestorePerms(client)
    local playerCommands = config.configValues.player_commands
    local list = {}
    local add_list = {}

    for i, cmd in ipairs(Game.Commands) do
        if utils.Contains(playerCommands, cmd.names[1]) or utils.Contains(playerdb.GetEntry(client.SteamID).command_permissions, cmd.names[1]) then
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
        if not utils.Contains(command.ConsoleCommands,cmd.names[1]) then
            table.insert(output_list,cmd)
        end
    end

    client.GivePermission(ClientPermissions.ConsoleCommands);
    client.SetPermissions(client.Permissions, utils.Union(output_list, add_list))
end

function module.HasPermission(client, requiredCommand)
    utils.Expect(2, requiredCommand, "string")

    -- Host has permission to everything
    if not Game.IsDedicated and client.SessionId == 1 then
        return true
    end

    local playerCommands = config.configValues.player_commands

    if utils.Contains(playerCommands, requiredCommand) then return true end

    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    for cmd in client.PermittedConsoleCommands do
        if cmd == command.GetCommandByString(requiredCommand) then return true end
    end
    return false
end

function module.HasGMTPermission(client, requiredCommand)
    utils.Expect(2, requiredCommand, "string")

    -- Host has permission to everything
    if not Game.IsDedicated and client.SessionId == 1 then
        return true
    end

    local playerCommands = config.configValues.player_commands

    if utils.Contains(playerCommands, requiredCommand) then return true end
    
    if not client.HasPermission(ClientPermissions.ConsoleCommands) then return false end

    if utils.Contains(playerdb.GetEntry(client.SteamID).command_permissions, requiredCommand) then return true end
    return false
end

function module.HasGMTPermissionOffline(steamid, requiredCommand)
    utils.Expect(2, requiredCommand, "string")
    
    local playerCommands = config.configValues.player_commands

    if utils.Contains(playerCommands, requiredCommand) then return true end

    if utils.Contains(playerdb.GetEntry(steamid).command_permissions, requiredCommand) then return true end
    return false
end

return module