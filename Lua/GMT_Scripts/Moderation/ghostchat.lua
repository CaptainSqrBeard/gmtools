GMT.AddCommand("see_ghostchat",GMT.Lang("Help_SeeGhostChat"),false,function(client,cursor,args)
    local target

    -- Getting Target
    if args[2] ~= nil then
        target = GMT.GetClientByString(args[2])
        if target == nil then
            GMT.SendConsoleMessage("GMTools: Player not found",client,Color(255,0,128,255))
            return
        end
    else
        target = client
    end
    
    local status = GMT.Player.CanSeeGhostChat(target)

    -- Getting Status
    if args[1] ~= nil then
        if args[1] == "true" then
            status = true
        elseif args[1] == "false" then
            status = false
        elseif args[1] == "switch" then
            status = not status
        else
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SeeGhostchat_badargument"),client,Color(255,0,0,255))
            return
        end
    else
        status = not status
    end

    if status == true then
        GMT.PlayerData[target.SessionId].SeeGhostChat = true
        GMT.SendConsoleMessage("GM-Tools: Forced Ghost Chat ENABLED for "..target.Name,client,Color(255,0,255,255))
    elseif status == false then
        GMT.PlayerData[target.SessionId].SeeGhostChat = false
        GMT.SendConsoleMessage("GM-Tools: Forced Ghost Chat DISABLED for "..target.Name,client,Color(255,0,255,255))
    end
    
end,{{name="status",desc=GMT.Lang("Args_SeeGhostChat_status")},
{name="target",desc=GMT.Lang("Args_SeeGhostChat_target")}})



GMT.AddCommand("deadmsg",GMT.Lang("Help_DeadMsg"),false,function(client,cursor,args)
    if not Game.RoundStarted then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_DeadMsg_inround"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
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
    if msg:len() == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    -- For sender
    local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.SessionId ~= client.SessionId then
            if cl.Character == nil or cl.Character.IsDead or GMT.Player.CanSeeGhostChat(cl) then
                local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end
        
    end
end,{{name="msg",desc=GMT.Lang("Args_DeadMsg_msg")}})


GMT.AddChatCommand("dead",GMT.Lang("Help_DeadMsg"),function (client,args)
    if not GMT.HasPermission(client,".deadmsg") then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_NotEnoughPermissions"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end
    if not Game.RoundStarted then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("CMD_DeadMsg_inround"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if string.len(msg) > 200 then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_TooLongMessage"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end
    if msg:len() == 0 then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_NoMessage"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    -- For sender
    local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.SessionId ~= client.SessionId then
            if cl.Character == nil or cl.Character.IsDead or GMT.Player.CanSeeGhostChat(cl) then
                local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end
        
    end
end)