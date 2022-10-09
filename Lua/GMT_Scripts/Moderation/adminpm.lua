local function sendAHelpToAdmins(sender,recipient,msg)
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L1",{sender.Name}),recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L2",{msg}),recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_admin_L3",{sender.SessionId}),recipient,Color(255,255,255,255))

    local chatMsg = ChatMessage.Create(GMT.Lang("CMD_AHelp_msg_for_admin_name"), GMT.Lang("CMD_AHelp_msg_for_admin_text",{sender.SteamID,sender.Name,msg,sender.SessionId}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)
end

local function sendAdminPMToPlayer(sender,recipient,msg)
    local chatMsg = ChatMessage.Create(GMT.Lang("CMD_AdminPM_msg_for_player_name",{sender.Name}), GMT.Lang("CMD_AdminPM_msg_for_player_text",{sender.SteamID,sender.Name,recipient.SteamID,recipient.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L1",{sender.Name,recipient.Name}),recipient,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L2",{msg}),recipient,Color(255,255,255,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_player_L3"),recipient,Color(255,255,255,255))
end



GMT.AddCommand("adminpm",GMT.Lang("Help_AdminPM"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if #args < 2 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local r_client = GMT.GetClientByString(args[1])
    if r_client == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 2, #args, 1 do
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
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    -- For sender
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L1",{client.Name,r_client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),client,Color(255,255,255,255))

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if (cl.SessionId ~= client.SessionId and cl.SessionId ~= r_client.ID) and GMT.HasPermission(cl,".adminpm") then
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L1",{client.Name,r_client.Name}),cl,Color(255,0,0,255))
            GMT.SendConsoleMessage(GMT.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
        end
    end

    
    -- For recipient
    sendAdminPMToPlayer(client,r_client,msg)
    if GMT.ForcedLaunch == false and GMT.Config.Vars.do_bwoink == true then -- THE BWOINK SOUND
        local bwoink_chr = r_client.Character

        -- It will works only if player controls character.
        if bwoink_chr ~= nil and bwoink_chr.IsDead == false then
            local bwoinkAff = AfflictionPrefab.Prefabs["gmtbwoink"]
            r_client.Character.CharacterHealth.ApplyAffliction(bwoink_chr.AnimController.MainLimb, bwoinkAff.Instantiate(1))
        end
    end
end,{
{name="target",desc=GMT.Lang("Args_AdminPM_target")},
{name="msg",desc=GMT.Lang("Args_AdminPM_msg")}})

GMT.AddCommand("ahelp",GMT.Lang("Help_AHelp"),false,function(client,cursor,args)
    if GMT.Config.Vars.ahelp_enabled == false then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AHelp_disabled"),client,Color(255,0,0,255))
        return
    end

    if GMT.Player.ProcessCooldown(client,2) then
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_TooLongMessage"),client,Color(255,0,0,255))
        return
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
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end,{{name="msg",desc=GMT.Lang("Args_AHelp_msg")}})


GMT.AddChatCommand("ahelp",GMT.Lang("Help_AHelp"),function (client,args)
    if GMT.Player.ProcessCooldown(client,2) then return end
    if GMT.Config.Vars.ahelp_enabled == false then
        local chatMsg = ChatMessage.Create("ADMIN HELP",GMT.Lang("CMD_AHelp_disabled"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        GMT.SendConsoleMessage("GMTools: Message is too big!",client,Color(255,0,128,255))
    end
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    local S_chatMsg = ChatMessage.Create(GMT.Lang("CMD_AHelp_msg_for_player_name"),
        GMT.Lang("CMD_AHelp_msg_for_player_text",{client.SessionId,client.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(S_chatMsg, client)

    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    GMT.SendConsoleMessage(GMT.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end)




GMT.AddCommand("toggle_ahelp",GMT.Lang("Help_ToggleAHelp"),false,function(client,cursor,args)
    local status = GMT.Config.Vars.ahelp_enabled
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleAHelp_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.ahelp_enabled = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_enabled"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleAHelp_disabled"),client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end,{{name="status",desc=GMT.Lang("Args_ToggleAHelp_status")}})



GMT.AddCommand("toggle_bwoink",GMT.Lang("Help_ToggleBwoink"),false,function(client,cursor,args)
    local status = GMT.Config.Vars.do_bwoink
    -- Getting Status
    if args[1] == "true" then
        status = true
    elseif args[1] == "false" then
        status = false
    elseif args[1] == "switch" or args[1] == nil then
        status = not status
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ToggleBwoink_badargument"),client,Color(255,0,0,255))
        return
    end

    GMT.Config.Vars.do_bwoink = status
    if status == true then
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_enabled"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_ToggleBwoink_disabled"),client,Color(255,0,255,255))
    end
    
    GMT.Config.Save()
end,{{name="status",desc=GMT.Lang("Args_ToggleBwoink_status")}})