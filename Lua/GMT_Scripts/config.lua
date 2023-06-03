GMT.AddCommand("save_data",GMT.Lang("Help_SaveData"),false,nil)

GMT.AssignClientCommand("save_data",function(client,cursor,args)
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),client,Color(255,0,255,255))
    GMT.Config.Save()
    GMT.PlayerData.Save()
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),client,Color(255,0,255,255))
end)

GMT.AssignServerCommand("save_data",function(args)
    GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),Color(255,0,255,255))
    GMT.Config.Save()
    GMT.PlayerData.Save()
    GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),Color(255,0,255,255))
end)



GMT.AddCommand("reload_config",GMT.Lang("Help_ReloadConfig"),false,nil)

GMT.AssignClientCommand("reload_config",function(client,cursor,args)
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),client,Color(255,0,255,255))
    if GMT.Config.Load() == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),client,Color(255,0,255,255))
    end
end)

GMT.AssignServerCommand("reload_config",function(args)
    GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),Color(255,0,255,255))
    if GMT.Config.Load() == true then
        GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),Color(255,0,255,255))
    end
end)