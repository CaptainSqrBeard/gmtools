local function sendAHelpToAdmins(sender,recipient,msg)
    GMT.SendConsoleMessage("AHELP "..sender.Name.." --> "..GMT.Lang("CMD_AdminPM_admins").." ("..GMT.Lang("CMD_AdminPM_include_you")..")",recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage("   "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_note"),recipient,Color(255,255,255,255))

    local chatMsg = ChatMessage.Create("ADMIN HELP "..GMT.Lang("CMD_AdminPM_from").." "..sender.Name,
    "\n"..GMT.Lang("CMD_AdminPM_from").." "..GMT.ClientLogName(sender).." "..GMT.Lang("CMD_AdminPM_to").." "..GMT.FormattedText(GMT.Lang("CMD_AdminPM_admins").." ("..GMT.Lang("CMD_AdminPM_include_you")..")",{{name="color",value="#e1a1a3"}}).." "..GMT.FormattedText("\n"..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",{{name="color",value="#fcf0f0"}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)
end

local function sendAdminPMToPlayer(sender,recipient,msg)
    local chatMsg = ChatMessage.Create("ADMIN PM "..GMT.Lang("CMD_AdminPM_from").." "..sender.Name,
    "\n"..GMT.ClientLogName(sender).." --> "..GMT.ClientLogName(recipient,recipient.Name.." ("..GMT.Lang("CMD_AdminPM_you")..")").." "..GMT.FormattedText("\n    "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",{{name="color",value="#fcf0f0"}}).."\n"..GMT.FormattedText(GMT.Lang("CMD_AdminPM_note"),{{name="color",value="#8a8a8a"}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    GMT.SendConsoleMessage("ADMINPM "..sender.Name.." --> "..recipient.Name.." ("..GMT.Lang("CMD_AdminPM_you")..")",recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage("   "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_note"),recipient,Color(255,255,255,255))
end



GMT.AddCommand("adminpm",GMT.Lang("Help_AdminPM"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: Not enough arguments provided",client,Color(255,0,128,255))
        return
    end

    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,128,255))
        return
    end

    local msg = ""
    for i = 2, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,128,255))
    end

    -- For sender
    GMT.SendConsoleMessage("ADMINPM "..client.Name.." ("..GMT.Lang("CMD_AdminPM_you")..") --> "..r_client.Name,client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",client,Color(255,255,255,255))

    -- For recipient
    sendAdminPMToPlayer(client,r_client,msg)

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if (cl.ID ~= client.ID and cl.ID ~= r_client.ID) and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage("ADMINPM "..client.Name.." --> "..r_client.Name,cl,Color(255,0,0,255))
            GMT.SendConsoleMessage("   Private message: \""..msg.."\"",cl,Color(255,255,255,255))
        end
    end
end,{
{name="target",desc=GMT.Lang("Args_AdminPM_target")},
{name="msg",desc=GMT.Lang("Args_AdminPM_msg")}})

GMT.AddCommand("ahelp",GMT.Lang("Help_AHelp"),false,function(client,cursor,args)
    if GMT.Config.Vars.ahelp_enabled == false then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_disabled"),client,Color(255,0,0,255))
        return
    end

    if GMT.Player.ProcessCooldown(client,GMT.RandomFloat(2,4)) then
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: No message provided",client,Color(255,0,128,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,128,255))
    end

    -- For sender
    GMT.SendConsoleMessage("AHELP "..client.Name.." ("..GMT.Lang("CMD_AdminPM_you")..") --> "..GMT.Lang("CMD_AdminPM_admins"),client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end,{{name="msg",desc=GMT.Lang("Args_AHelp_msg")}})

GMT.AddCommand("toggle_ahelp",GMT.Lang("Help_ToggleAHelp"),false,function(client,cursor,args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: Bad argument. Argument #1 accepts only these values: true, false or switch.",client,Color(255,0,128,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: .ahelp now ENABLED",client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: .ahelp now DISABLED",client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end,{{name="status",desc=GMT.Lang("Args_ToggleAHelp_status")}})



GMT.AddChatCommand("ahelp",GMT.Lang("Help_AHelp"),function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if GMT.Config.Vars.ahelp_enabled == false then
        local chatMsg = ChatMessage.Create("ADMIN HELP",GMT.Lang("CMD_AdminPM_disabled"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if GMT.Player.ProcessCooldown(client,4) then
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: No message provided",client,Color(255,0,128,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: Message is too big!",client,Color(255,0,128,255))
    end

    -- For sender
    local S_chatMsg = ChatMessage.Create("ADMIN HELP",
    GMT.Lang("CMD_AdminPM_from").." "..GMT.ClientLogName(client,client.Name.." ("..GMT.Lang("CMD_AdminPM_you")..")").." to "..GMT.FormattedText(GMT.Lang("CMD_AdminPM_admins"),{{name="color",value="#e1a1a3"}}).." "..GMT.FormattedText("\n"..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",{{name="color",value="#fcf0f0"}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(S_chatMsg, client)
    GMT.SendConsoleMessage("AHELP "..client.Name.." ("..GMT.Lang("CMD_AdminPM_you")..") --> "..GMT.Lang("CMD_AdminPM_admins"),client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   "..GMT.Lang("CMD_AdminPM_pm")..": \""..msg.."\"",client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
    Game.Log("GM-Tools: "..GMT.ClientLogName(client).." executed ChatCommand \".adminhelp\" with text \"msg\"", ServerLogMessageType.ConsoleUsage)
end)

