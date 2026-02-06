local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local permissions = require("GMT_Scripts._UTILS.permissions")
local lang = require("GMT_Scripts._UTILS.lang")

local function applyPermissions(cmds, perms, target, interface, ishost)
    local validCmds = cmds
    local validPerms = perms

    local playerdata = playerdb.GetEntry(target.SteamID)

    if not ishost then
        local giverEntry = playerdb.GetEntry(interface.executor.SteamID)
        validCmds = utils.Intersect(cmds, giverEntry.command_permissions)
        validPerms = utils.Intersect(perms, giverEntry.permissions)
    end

    playerdata.command_permissions = utils.Union(validCmds, playerdata.command_permissions)
    playerdata.permissions = utils.Union(validPerms, playerdata.permissions)

    permissions.RestorePerms(target)
    playerdb.SavePlayer(target.SteamID)
end

function module.initialize()
    command.AddCommand("giveperm",lang.Lang("Help_GivePerm"),false,nil,{
        {name="player",desc=lang.Lang("Args_GivePerm_player")},
        {name="commands",desc=lang.Lang("Args_GivePerm_commands")}
    })

    command.AssignSharedCommand("giveperm",function (args, interface)
        if #args < 2 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("giveperm"),Color(255,0,0,255))
            return
        end

        -- Get client
        local r_client = utils.GetClientByString(args[1])
        if r_client == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
            return
        end

        -- Granting all perms if parameter is 'all'
        local playerdata = playerdb.GetEntry(r_client.SteamID)

        local command_perms = {}
        local perms = {}

        local ishost = interface.isServer or (not Game.IsDedicated and interface.executor.SessionId == 1)

        if args[2] == "all" then
            interface.showMessage("GMTools: "..lang.Lang("CMD_GivePerm_all",{r_client.Name}),Color(255,0,255,255))
            command_perms = command.ListAllCommands()
            perms = permissions.ListAllPermissions()

            applyPermissions(command_perms, perms, r_client, interface, ishost)
            return
        end

        interface.showMessage(lang.Lang("CMD_GivePerm_header",{r_client.Name}),Color(255,0,255,255))
        
        local giverdata
        if not interface.isServer then
            giverdata = playerdb.GetEntry(interface.executor.SteamID)
        end

        -- Getting perms
        for i = 2, #args, 1 do
            local given_perm = args[i]
            local error = false  -- World if Lua has 'continue'...

            if string.sub(given_perm, 1, 1) ~= "." then
                -- If giver dont have permissions
                if not ishost and utils.Contains(giverdata.permissions, given_perm) then
                    interface.showMessage(lang.Lang("CMD_GivePerm_donthave",{given_perm}),Color(255,200,200,255))
                    error = true
                end

                -- If already has this permission
                if utils.Contains(playerdata.permissions, given_perm) then
                    interface.showMessage(lang.Lang("CMD_GivePerm_alreadyhas",{given_perm}),Color(255,200,200,255))
                    error = true
                end

                -- If unknown permissions
                if not error and permissions.availablePermissions[given_perm] == nil then
                    interface.showMessage(lang.Lang("CMD_GivePerm_notexists",{given_perm}),Color(255,200,200,255))
                    error = true
                end

                -- Everything okay, adding command
                if not error then
                    interface.showMessage(lang.Lang("CMD_GivePerm_added",{given_perm}),Color(255,255,255,255))
                    table.insert(perms,given_perm)
                end
            else
                -- If giver dont have permissions
                if not ishost and utils.Contains(giverdata.command_permissions, given_perm) then
                    interface.showMessage(lang.Lang("CMD_GivePerm_command_donthave",{given_perm}),Color(255,200,200,255))
                    error = true
                end

                -- If already has this command
                if utils.Contains(playerdata.command_permissions, given_perm) then
                    interface.showMessage(lang.Lang("CMD_GivePerm_command_alreadyhas",{given_perm}),Color(255,200,200,255))
                    error = true
                end
                -- If not a GMTools command
                if not error and not utils.Contains(command.ConsoleCommands, given_perm) then
                    interface.showMessage(lang.Lang("CMD_GivePerm_command_notexists",{given_perm}),Color(255,200,200,255))
                    error = true
                end

                -- Everything okay, adding command
                if not error then
                    interface.showMessage(lang.Lang("CMD_GivePerm_command_added",{given_perm}),Color(255,255,255,255))
                    table.insert(command_perms,given_perm)
                end
            end
        end

        applyPermissions(command_perms, perms, r_client, interface, ishost)

        permissions.RestorePerms(r_client)
        playerdb.SavePlayer(r_client.SteamID)
    end)
end


return module