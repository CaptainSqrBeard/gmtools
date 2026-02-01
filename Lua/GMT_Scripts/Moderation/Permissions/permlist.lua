local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")

command.AddCommand("permlist",GMT.Lang("Help_PermList"),false,nil,{
    {name="player",desc=GMT.Lang("Args_PermList_player")}
})

command.AssignClientCommand("permlist",function (client,cursor,args)
    -- Get client
    local r_client
    if args[1] == nil then
        -- Player not specified, apply to yourself
        r_client = client
    else
        -- Try to apply on specified player
        r_client = utils.GetClientByString(args[1])
        if r_client == nil then
            utils.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
            return
        end
    end
    playerdb.Create(r_client)

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.SendConsoleMessage(GMT.Lang("CMD_PermList_header",{r_client.Name}),client,Color(255,0,255,255))
    for i, cmd in ipairs(perms) do
        utils.SendConsoleMessage(GMT.Lang("CMD_PermList_item",{cmd}),client,Color(255,255,255,255))
    end
end)

command.AssignServerCommand("permlist",function (args)
    -- Get client
    local r_client
    if args[1] == nil then
        -- Can't apply permlist on console
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
        return
    else
        -- Try to apply on specified player
        r_client = utils.GetClientByString(args[1])
        if r_client == nil then
            utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
            return
        end
    end
    playerdb.Create(r_client)

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    utils.NewConsoleMessage(GMT.Lang("CMD_PermList_header",{r_client.Name}),Color(255,0,255,255),false)
    for i, cmd in ipairs(perms) do
        utils.NewConsoleMessage(GMT.Lang("CMD_PermList_item",{cmd}),Color(255,255,255,255),false)
    end
end)