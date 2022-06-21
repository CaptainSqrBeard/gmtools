


GMT.AddCommand("save_data",GMT.Lang("Help_SaveData"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,6) then return end
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),client,Color(255,0,255,255))
    GMT.Config.Save()
    GMT.PlayerData.Save()
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),client,Color(255,0,255,255))
end)

GMT.AddCommand("reload_config",GMT.Lang("Help_ReloadConfig"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,6) then return end
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),client,Color(255,0,255,255))
    if GMT.Config.Load() == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),client,Color(255,0,255,255))
    end
end)