GMT.AddCommand("toggle_ahelp",GMT.Lang("Help_ToggleAHelp"),false,nil,{{name="status",desc=GMT.Lang("Args_ToggleAHelp_status")}})

GMT.AssignClientCommand("toggle_ahelp", function(client,cursor,args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleAHelp_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_enabled"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_disabled"),client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end)

GMT.AssignServerCommand("toggle_ahelp", function(args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleAHelp_badargument"),Color(255,0,0,255),false)
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_enabled"),Color(255,0,255,255),false)
    else
        GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_disabled"),Color(255,0,255,255),false)
    end
    
    GMT.Config.Save()
end)

--[[
GMT.AddCommand("toggle_bwoink",GMT.Lang("Help_ToggleBwoink"),false,nil,{{name="status",desc=GMT.Lang("Args_ToggleBwoink_status")}})

GMT.AssignClientCommand("toggle_bwoink",function(client,cursor,args)
    local status = GMT.Config.Vars.do_bwoink
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleBwoink_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.do_bwoink = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_enabled"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_disabled"),client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end)

GMT.AssignServerCommand("toggle_bwoink",function(args)
    local status = GMT.Config.Vars.do_bwoink
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleBwoink_badargument"),Color(255,0,0,255),false)
        return
    end

    GMT.Config.Vars.do_bwoink = status
    if status == true then
        GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_enabled"),Color(255,0,255,255),false)
    else
        GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_disabled"),Color(255,0,255,255),false)
    end
    
    GMT.Config.Save()
end)
--]]