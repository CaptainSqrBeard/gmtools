local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local lang = require("GMT_Scripts._UTILS.lang")
local config = require("GMT_Scripts._UTILS.config")
local permissions = require("GMT_Scripts._UTILS.permissions")

-- Here is temporary memory!
module.playerMemory = {}

function module.AddInMemory(client)
    if module.playerMemory[client.SessionId] == nil then
        module.playerMemory[client.SessionId] = {
            SeeGhostChat=false,
            Cooldown=Timer.Time,
            Spam=0,
            LastJob=client.PreferredJob
        }
        return true
    end
    return false
end

-- Returns true if player on cooldown, false if not.
-- Also applies cooldown to player
function module.ProcessCooldown(client,time,warn_msg,kick_msg)
    utils.Expect(2, time, "number")
    utils.Expect(3, warn_msg, "string", "nil")
    utils.Expect(4, kick_msg, "string", "nil")
    module.AddInMemory(client)

    --if client.HasPermission(ClientPermissions.All) then return false end

    if Timer.Time > module.playerMemory[client.SessionId].Cooldown then 
        module.playerMemory[client.SessionId].Spam = 0
    end

    -- Doing cooldown things
    if time == nil then time = math.random()*2+2 end
    module.playerMemory[client.SessionId].Cooldown = Timer.Time + time
    module.playerMemory[client.SessionId].Spam = module.playerMemory[client.SessionId].Spam+1

    -- If Client spamming too much
    if module.playerMemory[client.SessionId].Spam >= 5 then
        module.playerMemory[client.SessionId].Spam = 0
        if kick_msg == nil then kick_msg = lang.Lang("CD_Warn_CMDSpam_Kick") end
        client.Kick("GMTools: "..kick_msg)
        return true
    end

    -- If Client triggered CD more than 3 times
    if module.playerMemory[client.SessionId].Spam >= 3 then
        if warn_msg == nil then warn_msg = lang.Lang("CD_Warn_CMDSpam") end
        local chatMessage = ChatMessage.Create("", lang.Lang("CD_Warn",{warn_msg}), ChatMessageType.MessageBox, nil, nil)
        chatMessage.Color = Color(255, 60, 60, 255)
        Game.SendDirectChatMessage(chatMessage, client)
        utils.SendConsoleMessage(lang.Lang("CD_Warn",{warn_msg}),client,Color(255, 60, 60, 255))
        return true
    end

    return false
end

function module.DeleteFromMemory(client)
    module.playerMemory[client.SessionId] = nil
end

function module.CanSeeGhostChat(client)
    module.AddInMemory(client)
    if module.playerMemory[client.SessionId].SeeGhostChat == nil then
        module.playerMemory[client.SessionId].SeeGhostChat = false
    end
    return module.playerMemory[client.SessionId].SeeGhostChat
end

return module