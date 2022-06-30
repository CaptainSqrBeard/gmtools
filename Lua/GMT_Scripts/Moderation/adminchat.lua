GMT.AddChatCommand("admin",GMT.Lang("Help_AdminChat"),function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end

    if not GMT.HasPermission(client,".adminchat") then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_NotEnoughPermissions"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
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
    
    if msg:len() == 0 then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("CMD_AdminPM_NoMessage"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if string.len(msg) > 200 then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_TooLongMessage"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(nil, GMT.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, client.Character, client)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end)

GMT.AddCommand("adminchat",GMT.Lang("Help_AdminChat"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,1) then return end

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
    if msg:len() == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,128,255))
    end

    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(nil, GMT.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, client.Character, client)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end,{{name="msg",desc=GMT.Lang("Args_AdminChat_msg")}})