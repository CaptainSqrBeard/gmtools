GMT.Player = {}
GMT.PlayerData = {}

function GMT.Player.AddInMemory(client)
    if GMT.PlayerData[client.ID] == nil then
        GMT.PlayerData[client.ID] = {SeeGhostChat=false,Cooldown=Timer.Time,Spam=0}
        return true
    end
    return false
end

-- Returns true if player on cooldown, false if not.
-- Also applies cooldown to player
function GMT.Player.ProcessCooldown(client,time,warn_msg,kick_msg)
    GMT.Player.AddInMemory(client)
    --if client.HasPermission(ClientPermissions.All) then return false end

    if Timer.Time > GMT.PlayerData[client.ID].Cooldown then 
        GMT.PlayerData[client.ID].Spam = 0
    end

    -- Doing cooldown things
    if time == nil then time = math.random()*2+2 end
    GMT.PlayerData[client.ID].Cooldown = Timer.Time+time
    GMT.PlayerData[client.ID].Spam = GMT.PlayerData[client.ID].Spam+1

    -- If Client spamming too much
    if GMT.PlayerData[client.ID].Spam >= 5 then
        GMT.PlayerData[client.ID].Spam = 0
        if kick_msg == nil then kick_msg = GMT.Lang("CD_Warn_CMDSpam_Kick") end
        client.Kick("GMTools: "..kick_msg)
        return true
    end

    -- If Client triggered CD more than 3 times
    if GMT.PlayerData[client.ID].Spam >= 3 then
        if warn_msg == nil then warn_msg = GMT.Lang("CD_Warn_CMDSpam") end
        local chatMessage = ChatMessage.Create("", GMT.Lang("CD_Warn",warn_msg), ChatMessageType.MessageBox, nil, nil)
        chatMessage.Color = Color(255, 60, 60, 255)
        Game.SendDirectChatMessage(chatMessage, client)
        GMT.SendConsoleMessage(GMT.Lang("CD_Warn",warn_msg),client,Color(255, 60, 60, 255))
        return true
    end

    return false
end

function GMT.Player.DeleteFromMemory(client)
    GMT.PlayerData[client.ID] = nil
end

function GMT.Player.CanSeeGhostChat(client)
    GMT.Player.AddInMemory(client)
    if GMT.PlayerData[client.ID].SeeGhostChat == nil then
        GMT.PlayerData[client.ID].SeeGhostChat = false
    end
    return GMT.PlayerData[client.ID].SeeGhostChat
end