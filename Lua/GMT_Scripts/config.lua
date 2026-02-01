local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local config = require("GMT_Scripts._UTILS.config")

command.AddCommand("save_data",GMT.Lang("Help_SaveData"),false,nil)

command.AssignClientCommand("save_data",function(client,cursor,args)
    utils.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),client,Color(255,0,255,255))
    config.Save()
    playerdb.Save()
    utils.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),client,Color(255,0,255,255))
end)

command.AssignServerCommand("save_data",function(args)
    utils.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_init"),Color(255,0,255,255))
    config.Save()
    playerdb.Save()
    utils.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_SaveData_end"),Color(255,0,255,255))
end)



command.AddCommand("reload_config",GMT.Lang("Help_ReloadConfig"),false,nil)

command.AssignClientCommand("reload_config",function(client,cursor,args)
    utils.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),client,Color(255,0,255,255))
    if config.Load() == true then
        utils.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),client,Color(255,0,255,255))
    end
end)

command.AssignServerCommand("reload_config",function(args)
    utils.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_init"),Color(255,0,255,255))
    if config.Load() == true then
        utils.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ReloadConfig_end"),Color(255,0,255,255))
    end
end)