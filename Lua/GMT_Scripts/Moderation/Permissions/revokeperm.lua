local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local permissions = require("GMT_Scripts._UTILS.permissions")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    command.AddCommand("revokeperm",lang.Lang("Help_RevokePerm"),false,nil,{
        {name="player",desc=lang.Lang("Args_RevokePerm_player")},
        {name="commands",desc=lang.Lang("Args_RevokePerm_commands")}
    })

    command.AssignSharedCommand("revokeperm",function (args, interface)
        if #args < 2 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("revokeperm"),Color(255,0,0,255))
            return
        end

        -- Get client
        local r_client = utils.GetClientByString(args[1])
        if r_client == nil then
            interface.showMessage("GM-Tools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
            return
        end

        local playerdata = playerdb.GetEntry(r_client.SteamID)

        local ishost = interface.isServer or (not Game.IsDedicated and interface.executor.SessionId == 1)

        -- Check if player is immune
        if playerdb.HasPermission(r_client.SteamID, "jobban_immune") and not ishost then
            interface.showMessage("GM-Tools: "..lang.Lang("CMD_RevokePerm_AdminIssue"),Color(255,0,0,255))
            return
        end

        -- Revoking all perms if parameter is 'all'
        if args[2] == "all" then
            interface.showMessage("GM-Tools: "..lang.Lang("CMD_RevokePerm_all",{r_client.Name}),Color(255,0,255,255))
            playerdata.command_permissions = {}
            permissions.RestorePerms(r_client)
            playerdb.Save()
            return
        end

        local command_perms = playerdata.command_permissions
        local perms = playerdata.permissions

        interface.showMessage(lang.Lang("CMD_RevokePerm_header",{r_client.Name}),Color(255,0,255,255))
        -- Getting perms
        for i = 2, #args, 1 do
            local removedPerm = args[i]
            local found = false

            if string.sub(removedPerm, 1, 1) ~= "." then
                -- If not a GMTools command
                if not permissions.availablePermissions[removedPerm] == nil then
                    interface.showMessage(lang.Lang("CMD_RevokePerm_notexists",{removedPerm}),Color(255,200,200,255))
                else
                    -- Searching perms for current command
                    for pi, foundPerm in ipairs(perms) do
                        if foundPerm == removedPerm then
                            table.remove(perms,pi)
                            found = true
                            interface.showMessage(lang.Lang("CMD_RevokePerm_revoked",{removedPerm}),Color(255,255,255,255))
                            break
                        end
                    end

                    if not found then
                        interface.showMessage(lang.Lang("CMD_RevokePerm_donthave",{removedPerm}),Color(255,200,200,255))
                    end

                end
            else
                -- If not a GMTools permission
                if not utils.Contains(command.ConsoleCommands, removedPerm) then
                    interface.showMessage(lang.Lang("CMD_RevokePerm_command_notexists",{removedPerm}),Color(255,200,200,255))
                else
                    -- Searching perms for current permission
                    for pi, foundCmdPerm in ipairs(command_perms) do
                        if foundCmdPerm == removedPerm then
                            table.remove(command_perms,pi)
                            found = true
                            interface.showMessage(lang.Lang("CMD_RevokePerm_command_revoked",{removedPerm}),Color(255,255,255,255))
                            break
                        end
                    end
                
                    if not found then
                        interface.showMessage(lang.Lang("CMD_RevokePerm_command_donthave",{removedPerm}),Color(255,200,200,255))
                    end
                
                end
            end

            
        end

        playerdata.command_permissions = command_perms
        permissions.RestorePerms(r_client)
        playerdb.SavePlayer(r_client.SteamID)
    end)
end

return module