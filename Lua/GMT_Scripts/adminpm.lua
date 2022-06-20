GMT.AddCommand("adminpm","Sends private message to player",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,3) then return end
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: Not enough arguments provided",client,Color(255,0,128,255))
        return
    end

    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GMTools: Player not found",client,Color(255,0,128,255))
        return
    end

    local msg = ""
    for i = 2, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: Message is too big!",client,Color(255,0,128,255))
    end

    -- For sender
    GMT.SendConsoleMessage("ADMINPM "..client.Name.." (You) --> "..r_client.Name,client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   Private message: \""..msg.."\"",client,Color(255,255,255,255))
    

    -- For recipient
    local chatMsg = ChatMessage.Create("ADMIN PM from "..client.Name,
            "\n"..GMT.ClientLogName(client).." --> "..GMT.ClientLogName(r_client,r_client.Name.." (You)").." "..GMT.FormattedText("\nPrivate message: \""..msg.."\"",{{name="color",value="#fcf0f0"}}).."\n"..GMT.FormattedText("For anwser type '.ahelp <msg>' in console or chat",{{name="color",value="#ababab"}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, r_client)

    GMT.SendConsoleMessage("ADMINPM "..client.Name.." --> "..r_client.Name.." (You)",r_client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   Private message: \""..msg.."\"",r_client,Color(255,255,255,255))
    GMT.SendConsoleMessage("For anwser type '.ahelp <msg>' in console or chat'",r_client,Color(255,255,255,255))


    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if (cl.ID ~= client.ID and cl.ID ~= r_client.ID) and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage("ADMINPM "..client.Name.." --> "..r_client.Name,cl,Color(255,0,0,255))
            GMT.SendConsoleMessage("   Private message: \""..msg.."\"",cl,Color(255,255,255,255))
        end
    end
end,{
{name="target",desc="Who will get private message"},
{name="msg",desc="Message to send"}})

GMT.AddCommand("ahelp","Sends private message to admins",false,function(client,cursor,args)
    if GMT.Config.Vars.ahelp_enabled == false then
        GMT.SendConsoleMessage("GMTools: .ahelp is currently disabled",client,Color(255,0,0,255))
        return
    end

    if GMT.Player.ProcessCooldown(client,GMT.RandomFloat(2,4)) then
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
    GMT.SendConsoleMessage("AHELP "..client.Name.." (You) --> ADMINS",client,Color(255,0,0,255))
    GMT.SendConsoleMessage("   Private message: \""..msg.."\"",client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if cl.ID ~= client.ID and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage("AHELP "..client.Name.." --> ADMINS (Include you)",cl,Color(255,0,0,255))
            GMT.SendConsoleMessage("   Private message: \""..msg.."\"",cl,Color(255,255,255,255))
            GMT.SendConsoleMessage("For anwser type '.adminpm <player> <msg> in console",cl,Color(255,255,255,255))

            local chatMsg = ChatMessage.Create("ADMIN HELP from "..client.Name,
            "\n"..GMT.ClientLogName(client).." --> "..GMT.FormattedText("ADMINS",{{name="color",value="#e1a1a3"}}).." "..GMT.FormattedText("\nPrivate message: \""..msg.."\"",{{name="color",value="#fcf0f0"}}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end)

GMT.AddCommand("toggle_ahelp","Disables/enables .ahelp",false,function(client,cursor,args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: Bad argument. Argument #1 accepts only these values: true, false or switch.",client,Color(255,0,128,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: .ahelp now ENABLED",client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: .ahelp now DISABLED",client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end,{{name="status",desc="Can be true (only enable), false (only disable) or switch (switch between on/off)"}})