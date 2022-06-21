GMT.AddChatCommand("restoreperms","Gives permissions to players commands",function (client,args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    GMT.RestorePerms(client)

    local chatMsg = ChatMessage.Create("GM-Tools", "Your permissions has been successfully restored!", ChatMessageType.Server, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)

GMT.AddChatCommand("fixme","Fixes your data",function (client,args)
    --if GMT.Player.ProcessCooldown(client,3) then return end
    local add = GMT.Player.AddInMemory(client)
    if add then
        local chatMsg = ChatMessage.Create("GM-Tools", "Your data was successfully created", ChatMessageType.Server, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    else
        local chatMsg = ChatMessage.Create("GM-Tools", "You already have your data in memory", ChatMessageType.Server, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    end
end)

GMT.AddChatCommand("help","Says that you need use this command in console",function (client,args)
    if GMT.Player.ProcessCooldown(client,3) then return end

    local chatMsg = ChatMessage.Create("GM-Tools", GMT.FormattedText("Almost all GM-Tools commands executes from console (F3).\n\nYou need use this command in console for actual help",{{name="color",value="#ff9cfa"}}), ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)

end)

GMT.AddChatCommand("cls","Clears chat",function (client,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end
    local cls = ""
    for i = 1, 60, 1 do
        cls = cls.."\n"
    end
    local chatMsg = ChatMessage.Create("",cls, ChatMessageType.Dead, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)