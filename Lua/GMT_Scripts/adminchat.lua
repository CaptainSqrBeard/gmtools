GMT.AddChatCommand("admin","Sends message in admin chat",function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end

    if not GMT.HasPermission(client,".adminchat") then
        local chatMsg = ChatMessage.Create("GM-Tools","You don't have permission for this command", ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
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
    local chatMsg = ChatMessage.Create("ADMIN CHAT -- "..client.Name, GMT.FormattedText(msg,{{name="color",value="#ff0000"},{name="metadata",value=client.SteamID}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create("ADMIN CHAT "..client.Name, GMT.FormattedText(msg,{{name="color",value="#ff0000"},{name="metadata",value=client.SteamID}}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
        
    end
end)

GMT.AddCommand("adminchat","Sends message in admin chat",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end

    if not GMT.HasPermission(client,".adminchat") then
        local chatMsg = ChatMessage.Create("GM-Tools","You don't have permission for this command", ChatMessageType.Dead, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
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
    local chatMsg = ChatMessage.Create("ADMIN CHAT -- "..client.Name, GMT.FormattedText(msg,{{name="color",value="#ff0000"},{name="metadata",value=client.SteamID}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

    -- For ghosts
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create("ADMIN CHAT -- "..client.Name, GMT.FormattedText(msg,{{name="color",value="#ff0000"},{name="metadata",value=client.SteamID}}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
        
    end
end,{{name="msg",desc="Message to send"}})