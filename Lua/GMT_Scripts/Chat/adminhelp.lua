GMT.AddChatCommand("ahelp",GMT.Lang("Help_AHelp"),function (client,args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    if GMT.Config.Vars.ahelp_enabled == false then
        local chatMsg = ChatMessage.Create("ADMIN HELP","AHelp is currently disabled", ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if GMT.Player.ProcessCooldown(client,4) then
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: No message provided",client,Color(255,0,128,255))
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
    local S_chatMsg = ChatMessage.Create("ADMIN HELP from "..client.Name,
    "From "..GMT.ClientLogName(client,client.Name.." (YOU)").." to "..GMT.FormattedText("ADMINS",{{name="color",value="#e1a1a3"}}).." "..GMT.FormattedText("\nPrivate message: \""..msg.."\"",{{name="color",value="#fcf0f0"}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(S_chatMsg, client)
    GMT.SendConsoleMessage("AHELP "..client.Name.." (You) --> ADMINS",client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   Private message: \""..msg.."\"",client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage("AHELP "..client.Name.." --> ADMINS (Include you)",cl,Color(255,0,0,255))
            GMT.SendConsoleMessage("   Private message: \""..msg.."\"",cl,Color(255,255,255,255))
            GMT.SendConsoleMessage("For anwser type '.adminpm <player> <msg> in console",cl,Color(255,255,255,255))

            local chatMsg = ChatMessage.Create("ADMIN HELP from "..client.Name,
            "\n".."From "..GMT.ClientLogName(client).." to "..GMT.FormattedText("ADMINS (Include you)",{{name="color",value="#e1a1a3"}}).." "..GMT.FormattedText("\nPrivate message: \""..msg.."\"",{{name="color",value="#fcf0f0"}}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
    Game.Log("GM-Tools: "..GMT.ClientLogName(client).." executed ChatCommand \".adminhelp\" with text \"msg\"", ServerLogMessageType.ConsoleUsage)
end)

