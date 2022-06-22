GMT.AddChatCommand("restoreperms",GMT.Lang("HelpChat_RestorePerms"),function (client,args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    GMT.RestorePerms(client)

    local chatMsg = ChatMessage.Create("GM-Tools", GMT.Lang("Chat_RestorePerms_restored"), ChatMessageType.Server, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)

GMT.AddChatCommand("fixme",GMT.Lang("HelpChat_FixMe"),function (client,args)
    --if GMT.Player.ProcessCooldown(client,3) then return end
    local add = GMT.Player.AddInMemory(client)
    if add then
        local chatMsg = ChatMessage.Create("GM-Tools", GMT.Lang("Chat_FixMe_success"), ChatMessageType.Server, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    else
        local chatMsg = ChatMessage.Create("GM-Tools", GMT.Lang("Chat_FixMe_fail"), ChatMessageType.Server, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    end
end)

GMT.AddChatCommand("help",GMT.Lang("HelpChat_Help"),function (client,args)
    if GMT.Player.ProcessCooldown(client,3) then return end

    local chatMsg = ChatMessage.Create("GM-Tools", GMT.FormattedText(GMT.Lang("Chat_Help_help"),{{name="color",value="#ff9cfa"}}), ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

end)

GMT.AddChatCommand("cls",GMT.Lang("HelpChat_Cls"),function (client,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    local cls = ""
    for i = 1, 60, 1 do
        cls = cls.."\n"
    end
    local chatMsg = ChatMessage.Create("",cls, ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)