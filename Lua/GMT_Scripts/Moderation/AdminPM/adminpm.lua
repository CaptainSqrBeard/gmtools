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

GMT.AssignSharedCommand("adminpm",function (args, interface)
    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),Color(255,0,0,255))
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
        interface.showMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),Color(255,0,0,255))
        return
    end
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),Color(255,0,0,255))
        return
    end
    
    -- Custom event
    -- gmtools.adminpm.sent(sender, target, message)
    Hook.Call("gmtools.adminpm.sent", nil, r_client, msg)

    -- Name of sender
    local sender_name

    -- Differences between PM from host and client
    if interface.executor ~= nil then
        -- Set name of player
        sender_name = interface.executor.Name

        -- Message for recipient
        sendAdminPMToPlayer(interface.executor,r_client,msg)
    else
        -- Set name of host
        sender_name = GMT.Lang("Console")

        -- Message for recipient
        sendConsolePMToPlayer(r_client,msg)
    end

    -- Message for sender
    interface.showMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L1",{sender_name,r_client.Name}),Color(255,0,0,255))
    interface.showMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),Color(255,255,255,255))

    -- Message for other admins
    for i, cl in ipairs(Client.ClientList) do
        if (interface.executor ~= nil and cl.SessionId ~= interface.executor.SessionId) and cl.SessionId ~= r_client.SessionId and GMT.HasPermission(cl, ".adminpm") then
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L1",{sender_name,r_client.Name}),cl,Color(255,0,0,255))
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
        end
    end
end)