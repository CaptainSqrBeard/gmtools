GMT.AddCommand("toggle_ahelp",GMT.Lang("Help_ToggleAHelp"),false,nil,{{name="status",desc=GMT.Lang("Args_ToggleAHelp_status"),optional=true}})

GMT.AssignSharedCommand("toggle_ahelp",function (args, interface)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ToggleAHelp_badargument"),Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        interface.showMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_enabled"),Color(255,0,255,255))
    else
        interface.showMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_disabled"),Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end)