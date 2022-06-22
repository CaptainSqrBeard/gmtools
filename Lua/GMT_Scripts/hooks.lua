Hook.Add("client.connected", "GMT.client_connect", function(client)
    GMT.RestorePerms(client)
    GMT.Player.AddInMemory(client)
end)

Hook.Add("client.disconnected", "GMT.client_disconnect", function(client)
    GMT.Player.DeleteFromMemory(client)
end)


Hook.Add("chatMessage", "GMT.chatmessage", function(msg, client)
    -- Chat commands
    if msg:sub(1,1) == "." then
        local split = GMT.SplitCommand(msg)
        local command = GMT.ChatCommands[split[1]]

        if command == nil or command.func == nil then
            local chatMsg = ChatMessage.Create("GM-Tools",GMT.Lang("Chat_Error_UnknownCommand",{split[1]}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, client)
            return true
        end

        local name = split[1]
        table.remove(split,1)

        Game.Log("GM-Tools: "..GMT.ClientLogName(client).." executed ChatCommand: \""..msg:sub(1,200).."\"", ServerLogMessageType.ConsoleUsage)
        local status, err = pcall(function ()
            command.func(client,split)
        end)
        if err ~= nil then
            for i, cl in ipairs(Client.ClientList) do
                GMT.SendConsoleMessage("An Error has occured in ChatCommand \""..name.."\":\n"..err,cl,Color(255,0,0,255))
            end
        end

        return true -- Prevent sending message
    end

    -- Ghost Chat
    if Game.RoundStarted and GMT.CanSpeakGhost(client.Character) then
        for i, cl in ipairs(Client.ClientList) do
            if cl.Character ~= nil and GMT.Player.CanSeeGhostChat(cl) then
                local chatMsg = ChatMessage.Create(client.Name.." ["..GMT.Lang("CMD_SeeGhostChat_forced").."]",msg, ChatMessageType.Dead, nil, nil)
                Game.SendDirectChatMessage(chatMsg, cl)
            end
        end

    end

    
end)

Hook.Add("tryChangeClientName", "GMT.character_change", function(client,newName,newJob,newTeam)
    if client.Name ~= newName then
        if GMT.Player.ProcessCooldown(client,4,GMT.Lang("CD_Warn_NameChanging"),GMT.Lang("CD_Warn_NameChanging_Kick")) then
            return false
        end
        Game.Log("GM-Tools: "..GMT.ClientLogName(client).." changed nickname to "..GMT.ClientLogName(client,newName), ServerLogMessageType.ConsoleUsage)
    end

    if client.PreferredJob ~= newJob then
        local hasBan, expiresAt, reason = GMT.PlayerData.GetJobBanInfo(client,newJob.Value)
        if hasBan then
            local time
            if expiresAt == 0 then
                time = GMT.GetTimeString(0)
            else
                time = GMT.GetTimeString(expiresAt-os.time())
            end
            
            local chatMessage = ChatMessage.Create("", GMT.Lang("CMD_Jobban_Reminder",{time,reason,GMT.Config.Vars.lowest_job}), ChatMessageType.MessageBox, nil, nil)
            chatMessage.Color = Color(255, 60, 60, 255)
            Game.SendDirectChatMessage(chatMessage, client)
            return false
        end
        
    end
end)

Hook.Add("jobsAssigned", "GMT.jobs_assigned", function ()
    for key, value in pairs(Client.ClientList) do
        if GMT.PlayerData.HasJobBan(value, value.AssignedJob.Prefab.Identifier.Value) then
            value.AssignedJob = JobVariant(JobPrefab.Get(GMT.Config.Vars.lowest_job), 0)
            local chatMsg = ChatMessage.Create("JOB-BAN",GMT.Lang("CMD_Jobban_ForcedPlay",{GMT.Config.Vars.lowest_job}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, value)
        end
        
    end
end)


