local function sendAdminPMToPlayer(sender,recipient,msg)
    local chatMsg = ChatMessage.Create(GMT.Lang("CMD_AdminPM_msg_for_player_name",{sender.Name}), GMT.Lang("CMD_AdminPM_msg_for_player_text",{sender.SteamID,sender.Name,recipient.SteamID,recipient.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L1",{sender.Name,recipient.Name}),recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L2",{msg}),recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L3"),recipient,Color(255,255,255,255))
end

local function sendConsolePMToPlayer(recipient,msg)
    local chatMsg = ChatMessage.Create(GMT.Lang("CMD_AdminPM_msg_for_player_name",{GMT.Lang("Console")}), GMT.Lang("CMD_AdminPM_msg_for_player_text",{-1,GMT.Lang("Console"),recipient.SteamID,recipient.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L1",{GMT.Lang("Console"),recipient.Name}),recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L2",{msg}),recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L3"),recipient,Color(255,255,255,255))
end

GMT.AddCommand("adminpm",GMT.Lang("Help_AdminPM"),false,nil,{
{name="target",desc=GMT.Lang("Args_AdminPM_target")},
{name="msg",desc=GMT.Lang("Args_AdminPM_msg")}})


GMT.AssignClientCommand("adminpm", function(client,cursor,args)
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 2, #args, 1 do
        msg = msg..args[i].." "
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,0,255))
        return
    end
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end
    
    -- Custom event
    -- gmtools.adminpm.sent(sender, target, message)
    Hook.Call("gmtools.adminpm.sent", client, r_client, msg)

    -- For sender
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L1",{client.Name,r_client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),client,Color(255,255,255,255))

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if (cl.SessionId ~= client.SessionId and cl.SessionId ~= r_client.SessionId) and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L1",{client.Name,r_client.Name}),cl,Color(255,0,0,255))
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
        end
    end
    
    -- For recipient
    sendAdminPMToPlayer(client,r_client,msg)
end)

GMT.AssignServerCommand("adminpm", function(args)
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
        return
    end

    local msg = ""
    for i = 2, #args, 1 do
        msg = msg..args[i].." "
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if string.len(msg) > 200 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),Color(255,0,0,255),false)
        return
    end
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),Color(255,0,0,255),false)
        return
    end
    
    -- Custom event
    -- gmtools.adminpm.sent(sender, target, message)
    Hook.Call("gmtools.adminpm.sent", client, r_client, msg)

    -- For sender
    GMT.NewConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L1",{GMT.Lang("Console"),r_client.Name}),Color(255,0,0,255),false)
    GMT.NewConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),Color(255,255,255,255),false)

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L1",{GMT.Lang("Console"),r_client.Name}),cl,Color(255,0,0,255))
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
        end
    end
    
    -- For recipient
    sendConsolePMToPlayer(r_client,msg)
end)