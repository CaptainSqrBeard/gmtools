local function sendAHelpToAdmins(sender,recipient,msg)
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L1",{sender.Name}),recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L2",{msg}),recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L3",{sender.SessionId}),recipient,Color(255,255,255,255))

    local chatMsg = ChatMessage.Create(GMT.Lang("CMD_AHelp_msg_for_admin_name"), GMT.Lang("CMD_AHelp_msg_for_admin_text",{sender.SteamID,sender.Name,msg,sender.SessionId}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)
end

GMT.AddCommand("ahelp",GMT.Lang("Help_AHelp"),false,nil,{{name="msg",desc=GMT.Lang("Args_AHelp_msg")}})

GMT.AssignClientCommand("ahelp",function(client,cursor,args)
    if GMT.Config.Vars.ahelp_enabled == false then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AHelp_disabled"),client,Color(255,0,0,255))
        return
    end

    if GMT.Player.ProcessCooldown(client,2) then
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage").."\n"..GMT.GetCommandUsageHelp("ahelp"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,0,255))
        return
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if msg:len() == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end)

GMT.AssignServerCommand("ahelp",function(args)
    GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_bad_console"),Color(255,0,0,255)) -- how you will adminPM something that isn't a client?
end)



-- Chat Command
GMT.AddChatCommand("ahelp",GMT.Lang("Help_AHelp"),function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if GMT.Config.Vars.ahelp_enabled == false then
        local chatMsg = ChatMessage.Create("ADMIN HELP",GMT.Lang("CMD_AHelp_disabled"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if #args == 0 then
        local chatMsg = ChatMessage.Create("ADMIN HELP",GMT.Lang("CMD_AdminPM_NoMessage").."\n"..GMT.GetCommandUsageHelp("ahelp"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        local chatMsg = ChatMessage.Create("ADMIN HELP",GMT.Lang("Error_TooLongMessage"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    end
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    local S_chatMsg = ChatMessage.Create(GMT.Lang("CMD_AHelp_msg_for_player_name"),
        GMT.Lang("CMD_AHelp_msg_for_player_text",{client.SessionId,client.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(S_chatMsg, client)

    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end)