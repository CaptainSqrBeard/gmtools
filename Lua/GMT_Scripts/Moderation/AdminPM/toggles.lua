local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local config = require("GMT_Scripts._UTILS.config")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("toggle_ahelp",lang.Lang("Help_ToggleAHelp"),false,nil,{{name="status",desc=lang.Lang("Args_ToggleAHelp_status")}})

command.AssignClientCommand("toggle_ahelp", function(client,cursor,args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_ToggleAHelp_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleAHelp_enabled"),client,Color(255,0,255,255))
    else
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleAHelp_disabled"),client,Color(255,0,255,255))
    end
    
    config.Save()
end)

command.AssignServerCommand("toggle_ahelp", function(args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_ToggleAHelp_badargument"),Color(255,0,0,255),false)
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleAHelp_enabled"),Color(255,0,255,255),false)
    else
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleAHelp_disabled"),Color(255,0,255,255),false)
    end
    
    config.Save()
end)




command.AddCommand("toggle_bwoink",lang.Lang("Help_ToggleBwoink"),false,nil,{{name="status",desc=lang.Lang("Args_ToggleBwoink_status")}})

command.AssignClientCommand("toggle_bwoink",function(client,cursor,args)
    local status = GMT.Config.Vars.do_bwoink
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_ToggleBwoink_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.do_bwoink = status
    if status == true then
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleBwoink_enabled"),client,Color(255,0,255,255))
    else
        utils.SendConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleBwoink_disabled"),client,Color(255,0,255,255))
    end
    
    config.Save()
end)

command.AssignServerCommand("toggle_bwoink",function(args)
    local status = GMT.Config.Vars.do_bwoink
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_ToggleBwoink_badargument"),Color(255,0,0,255),false)
        return
    end

    GMT.Config.Vars.do_bwoink = status
    if status == true then
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleBwoink_enabled"),Color(255,0,255,255),false)
    else
        utils.NewConsoleMessage("GM-Tools: "..lang.Lang("CMD_ToggleBwoink_disabled"),Color(255,0,255,255),false)
    end
    
    config.Save()
end)