GMT.AddCommand("permlist",GMT.Lang("Help_PermList"),false,nil,{
    {name="player",desc=GMT.Lang("Args_PermList_player")}
})

GMT.AssignSharedCommand("permlist",function (args, interface)
    -- Get client
    local r_client
    if args[1] == nil then
        -- Can't apply permlist on console :)
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments").."\n"..GMT.GetCommandUsageHelp("permlist"),Color(255,0,0,255))
        return
    else
        -- Try to apply on specified player
        r_client = GMT.GetClientByString(args[1])
        if r_client == nil then
            interface.showMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
            return
        end
    end
    GMT.PlayerData.Create(r_client)

    local perms = GMT.PlayerData.Players[r_client.SteamID].Permissions

    interface.showMessage(GMT.Lang("CMD_PermList_header",{r_client.Name}),Color(255,0,255,255))
    for i, cmd in ipairs(perms) do
        interface.showMessage(GMT.Lang("CMD_PermList_item",{cmd}),Color(255,255,255,255))
    end
end)