local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local permissions = require("GMT_Scripts._UTILS.permissions")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("revokeperm",lang.Lang("Help_RevokePerm"),false,nil,{
    {name="player",desc=lang.Lang("Args_RevokePerm_player")},
    {name="commands",desc=lang.Lang("Args_RevokePerm_commands")}
})

command.AssignClientCommand("revokeperm",function (client,cursor,args)
    if #args < 2 then
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end
    
    -- Get client
    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end
    playerdb.Create(r_client)

    -- Revoking all perms if parameter is 'all'
    if args[2] == "all" then
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("CMD_RevokePerm_all",{r_client.Name}),client,Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = {}
        permissions.RestorePerms(r_client)
        playerdb.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.SendConsoleMessage(lang.Lang("CMD_RevokePerm_header",{r_client.Name}),client,Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local found = false

        -- If not a GMTools command
        if not utils.Contains(GMT.AllCommands, cmd) then
            utils.SendConsoleMessage(lang.Lang("CMD_RevokePerm_notexists",{cmd}),client,Color(255,200,200,255))
        else
            -- Searching perms for current command
            for pi, pcmd in ipairs(perms) do
                if pcmd == cmd then
                    table.remove(perms,pi)
                    found = true
                    utils.SendConsoleMessage(lang.Lang("CMD_RevokePerm_revoked",{cmd}),client,Color(255,255,255,255))
                    break
                end
            end
            
            if not found then
                utils.SendConsoleMessage(lang.Lang("CMD_RevokePerm_donthave",{cmd}),client,Color(255,200,200,255))
            end

        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    permissions.RestorePerms(r_client)
    playerdb.Save()
end)

command.AssignServerCommand("revokeperm",function (args)
    -- Get client
    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
        return
    end
    playerdb.Create(r_client)

    -- Revoking all perms if parameter is 'all'
    if args[2] == "all" then
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("CMD_RevokePerm_all",{r_client.Name}),Color(255,0,255,255),false)
        GMT.PlayerData.Players[r_client.SteamID].Permissions = {}
        permissions.RestorePerms(r_client)
        playerdb.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.NewConsoleMessage(lang.Lang("CMD_RevokePerm_header",{r_client.Name}),Color(255,0,255,255),false)
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local found = false

        -- If not a GMTools command
        if not utils.Contains(GMT.AllCommands, cmd) then
            utils.NewConsoleMessage(lang.Lang("CMD_RevokePerm_notexists",{cmd}),Color(255,200,200,255),false)
        else
            -- Searching perms for current command
            for pi, pcmd in ipairs(perms) do
                if pcmd == cmd then
                    table.remove(perms,pi)
                    found = true
                    utils.NewConsoleMessage(lang.Lang("CMD_RevokePerm_revoked",{cmd}),Color(255,255,255,255),false)
                    break
                end
            end
            
            if not found then
                utils.NewConsoleMessage(lang.Lang("CMD_RevokePerm_donthave",{cmd}),Color(255,200,200,255),false)
            end

        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    permissions.RestorePerms(r_client)
    playerdb.Save()
end)