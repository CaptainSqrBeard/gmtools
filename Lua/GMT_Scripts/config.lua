GMT.AddCommand("save_data",GMT.Lang("Help_SaveData"),false,nil)

GMT.AssignSharedCommand("save_data",function (args, interface)
    interface.showMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),Color(255,0,255,255))
    GMT.Config.Save()
    GMT.PlayerData.Save()
    interface.showMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),Color(255,0,255,255))
end)


GMT.AddCommand("reload_config",GMT.Lang("Help_ReloadConfig"),false,nil)

GMT.AssignSharedCommand("reload_config",function (args, interface)
    interface.showMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),Color(255,0,255,255))
    if GMT.Config.Load() == true then
        interface.showMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),Color(255,0,255,255))
    end
end)