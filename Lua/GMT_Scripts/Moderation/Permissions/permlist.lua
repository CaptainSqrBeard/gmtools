local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("permlist",lang.Lang("Help_PermList"),false,nil,{
    {name="player",desc=lang.Lang("Args_PermList_player")}
})

command.AssignSharedCommand("permlist",function (args, interface)
    -- Get client
    local r_client
    if args[1] == nil then
        -- Can't apply permlist on console :)
        interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("permlist"),Color(255,0,0,255))
        return
    else
        -- Try to apply on specified player
        r_client = utils.GetClientByString(args[1])
        if r_client == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
            return
        end
    end
    playerdb.Create(r_client)

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    interface.showMessage(lang.Lang("CMD_PermList_header",{r_client.Name}),Color(255,0,255,255))
    for i, cmd in ipairs(perms) do
        interface.showMessage(lang.Lang("CMD_PermList_item",{cmd}),Color(255,255,255,255))
    end
end)