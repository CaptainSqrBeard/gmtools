GMT.AddCommand("see_ghostchat",GMT.Lang("Help_SeeGhostChat"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
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
            GMT.SendConsoleMessage("GMTools: Bad argument. Argument #1 accepts only these values: true, false or switch.",client,Color(255,0,128,255))
            return
        end
    else
        status = not status
    end

    if status == true then
        GMT.PlayerData[target.ID].SeeGhostChat = true
        GMT.SendConsoleMessage("GM-Tools: Forced Ghost Chat ENABLED for "..target.Name,client,Color(255,0,255,255))
    elseif status == false then
        GMT.PlayerData[target.ID].SeeGhostChat = false
        GMT.SendConsoleMessage("GM-Tools: Forced Ghost Chat DISABLED for "..target.Name,client,Color(255,0,255,255))
    end
    
end,{{name="status",desc=GMT.Lang("Args_SeeGhostChat_status")},
{name="target",desc=GMT.Lang("Args_SeeGhostChat_target")}})



GMT.AddCommand("deadmsg",GMT.Lang("Help_DeadMsg"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if not Game.RoundStarted then
        GMT.SendConsoleMessage("GMTools: This command work only in round and you are alive",client,Color(255,0,128,255))
        return
    end
    if GMT.CanSpeakGhost(client.Character) then
        GMT.SendConsoleMessage("GMTools: You character already can't speak or dead. Just use chat normally",client,Color(255,0,128,255))
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
    local chatMsg = ChatMessage.Create(client.Character.Name.." (You)", msg, ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID then
            if cl.Character == nil or cl.Character.IsDead then
                local chatMsg = ChatMessage.Create(client.Character.Name.." (Alive)",msg, ChatMessageType.Dead, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            elseif GMT.Player.CanSeeGhostChat(cl) then
                local chatMsg = ChatMessage.Create(client.Character.Name.."(Alive) [Forced GhostChat]",msg, ChatMessageType.Dead, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end

    end
end,{{name="msg",desc=GMT.Lang("Args_DeadMsg_msg")}})


GMT.AddChatCommand("dead",GMT.Lang("Help_DeadMsg"),function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if not GMT.HasPermission(client,".deadmsg") then
        local chatMsg = ChatMessage.Create("GM-Tools","You don't have permission for this command", ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end
    if not Game.RoundStarted then
        local chatMsg = ChatMessage.Create("GM-Tools","This command work only in round", ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end
    if GMT.CanSpeakGhost(client.Character) then
        local chatMsg = ChatMessage.Create("GM-Tools","You character already can't speak or dead. Just use chat normally", ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
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
    local chatMsg = ChatMessage.Create(client.Character.Name.." (You)", msg, ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID then
            if cl.Character == nil or cl.Character.IsDead then
                local chatMsg = ChatMessage.Create(client.Character.Name.." (Alive)",msg, ChatMessageType.Dead, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            elseif GMT.Player.CanSeeGhostChat(cl) then
                local chatMsg = ChatMessage.Create(client.Character.Name.." (Alive) [Forced GhostChat]",msg, ChatMessageType.Dead, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end
        
    end
end)