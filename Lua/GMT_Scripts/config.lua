local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local config = require("GMT_Scripts._UTILS.config")
local lang = require("GMT_Scripts._UTILS.lang")


command.AssignSharedCommand("save_data",function (args, interface)
    interface.showMessage("GM-Tools: "..lang.Lang("CMD_SaveData_init"),Color(255,0,255,255))
    config.Save()
    playerdb.Save()
    interface.showMessage("GM-Tools: "..lang.Lang("CMD_SaveData_end"),Color(255,0,255,255))
end)

command.AddCommand("reload_config",lang.Lang("Help_ReloadConfig"),false,nil)

command.AssignSharedCommand("reload_config",function (args, interface)
    interface.showMessage("GM-Tools: "..lang.Lang("CMD_ReloadConfig_init"),Color(255,0,255,255))
    if config.Load() == true then
        interface.showMessage("GM-Tools: "..lang.Lang("CMD_ReloadConfig_end"),Color(255,0,255,255))
    end
end)