local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")

command.AddCommand("giveperm",GMT.Lang("Help_GivePerm"),false,nil,{
    {name="player",desc=GMT.Lang("Args_GivePerm_player")},
    {name="commands",desc=GMT.Lang("Args_GivePerm_commands")}
})

command.AssignServerCommand("giveperm",function (args)
    if #args < 2 then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
        return
    end
    
    -- Get client
    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Granting all perms if parameter is 'all'
    if args[2] == "all" then
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_GivePerm_all",{r_client.Name}),Color(255,0,255,255),false)
        GMT.PlayerData.Players[r_client.SteamID].Permissions = GMT.AllCommands
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.NewConsoleMessage(GMT.Lang("CMD_GivePerm_header",{r_client.Name}),Color(255,0,255,255),false)
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local error = false  -- World if Lua has 'continue'...

        -- If already has this command
        if utils.Contains(perms, cmd) then
            utils.NewConsoleMessage(GMT.Lang("CMD_GivePerm_alreadyhas",{cmd}),Color(255,200,200,255),false)
            error = true
        end
        -- If not a GMTools command
        if not error and not utils.Contains(GMT.AllCommands, cmd) then
            utils.NewConsoleMessage(GMT.Lang("CMD_GivePerm_notexists",{cmd}),Color(255,200,200,255),false)
            error = true
        end

        -- Everything okay, adding command
        if not error then
            utils.NewConsoleMessage(GMT.Lang("CMD_GivePerm_added",{cmd}),Color(255,255,255,255),false)
            table.insert(perms,cmd)
        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end)

command.AssignClientCommand("giveperm",function (client,cursor,args)
    if #args < 2 then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end
    
    -- Get client
    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end
    GMT.PlayerData.Create(r_client)

    -- Granting all perms if parameter is 'all'
    if args[2] == "all" then
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_GivePerm_all",{r_client.Name}),client,Color(255,0,255,255))
        GMT.PlayerData.Players[r_client.SteamID].Permissions = GMT.AllCommands
        GMT.RestorePerms(r_client)
        GMT.PlayerData.Save()
        return
    end

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.SendConsoleMessage(GMT.Lang("CMD_GivePerm_header",{r_client.Name}),client,Color(255,0,255,255))
    -- Getting perms
    for i = 2, #args, 1 do
        local cmd = args[i]
        local error = false  -- World if Lua has 'continue'...

        -- If already has this command
        if utils.Contains(perms, cmd) then
            utils.SendConsoleMessage(GMT.Lang("CMD_GivePerm_alreadyhas",{cmd}),client,Color(255,200,200,255))
            error = true
        end
        -- If not a GMTools command
        if not error and not utils.Contains(GMT.AllCommands, cmd) then
            utils.SendConsoleMessage(GMT.Lang("CMD_GivePerm_notexists",{cmd}),client,Color(255,200,200,255))
            error = true
        end

        -- Everything okay, adding command
        if not error then
            utils.SendConsoleMessage(GMT.Lang("CMD_GivePerm_added",{cmd}),client,Color(255,255,255,255))
            table.insert(perms,cmd)
        end
    end

    GMT.PlayerData.Players[r_client.SteamID].Permissions = perms
    GMT.RestorePerms(r_client)
    GMT.PlayerData.Save()
end)