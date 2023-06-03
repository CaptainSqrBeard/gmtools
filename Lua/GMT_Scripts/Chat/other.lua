GMT.AddChatCommand("fixme",GMT.Lang("HelpChat_FixMe"),function (client, args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    GMT.Player.AddInMemory(client)
    GMT.RestorePerms(client)

    local chatMsg = ChatMessage.Create("GM-Tools", GMT.Lang("Chat_FixMe_attempt"), ChatMessageType.Server, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)

GMT.AddChatCommand("help",GMT.Lang("HelpChat_Help"),function (client, args)
    if GMT.Player.ProcessCooldown(client,3) then return end

    local chatMsg = ChatMessage.Create("GM-Tools", GMT.FormattedText(GMT.Lang("Chat_Help_help"),{{name="color",value="#ff9cfa"}}), ChatMessageType.Dead, nil, nil, 0, Color(255,0,255,255))
    Game.SendDirectChatMessage(chatMsg, client)
end)

GMT.AddChatCommand("cls",GMT.Lang("HelpChat_Cls"),function (client, args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    local cls = ""
    for i = 1, 60, 1 do
        cls = cls.."\n"
    end
    local chatMsg = ChatMessage.Create("", cls, ChatMessageType.Dead, nil, nil, Color(0,0,0,0))
    Game.SendDirectChatMessage(chatMsg, client)
end)