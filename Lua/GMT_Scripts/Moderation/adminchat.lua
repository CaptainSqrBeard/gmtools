local ADMIN_CHAT_PREFIX = "[GMT ADMIN CHAT] "

GMT.AddChatCommand("admin",GMT.Lang("Help_AdminChat"),function (client,args)
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
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("CMD_AdminPM_NoMessage").."\n"..GMT.GetChatCommandUsageHelp(".admin"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if string.len(msg) > 200 then
        local chatMsg = ChatMessage.Create("GM-Tools",GMT.FormattedText(GMT.Lang("Error_TooLongMessage"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    Game.Log(ADMIN_CHAT_PREFIX..GMT.ClientLogName(client)..": "..msg, ServerLogMessageType.Chat)
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(nil, GMT.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, client.Character, client)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end,"<msg>")

GMT.AddCommand("adminchat",GMT.Lang("Help_AdminChat"),false,nil,{{name="msg",desc=GMT.Lang("Args_AdminChat_msg")}},nil)

GMT.AssignSharedCommand("adminchat",function (args, interface)
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
        interface.showMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage").."\n"..GMT.GetCommandUsageHelp("adminchat"),Color(255,0,0,255))
        return
    end

    if string.len(msg) > 200 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),Color(255,0,128,255))
    end

    if interface.executor ~= nil then
        Game.Log(ADMIN_CHAT_PREFIX..GMT.ClientLogName(interface.executor)..": "..msg, ServerLogMessageType.Chat)
        for i, cl in ipairs(Client.ClientList) do
            if GMT.HasGMTPermission(cl,".adminchat") then
                local chatMsg = ChatMessage.Create(nil, GMT.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, interface.executor.Character, interface.executor)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end
    else
        Game.Log(ADMIN_CHAT_PREFIX.."HOST: "..msg, ServerLogMessageType.Chat)
        for i, cl in ipairs(Client.ClientList) do
            if GMT.HasGMTPermission(cl,".adminchat") then
                local chatMsg = ChatMessage.Create(GMT.Lang("Console"), GMT.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end
    end
end)