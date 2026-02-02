local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local player = require("GMT_Scripts._UTILS.player")
local permissions = require("GMT_Scripts._UTILS.permissions")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    command.AddChatCommand("fixme",lang.Lang("HelpChat_FixMe"),function (client, args)
        if player.ProcessCooldown(client,3) then return end
        player.AddInMemory(client)
        permissions.RestorePerms(client)

        local chatMsg = ChatMessage.Create("GM-Tools", lang.Lang("Chat_FixMe_attempt"), ChatMessageType.Server, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
    end)

    command.AddChatCommand("help",lang.Lang("HelpChat_Help"),function (client, args)
        if player.ProcessCooldown(client,3) then return end

        local chatMsg = ChatMessage.Create("GM-Tools", utils.FormattedText(lang.Lang("Chat_Help_help"),{{name="color",value="#ff9cfa"}}), ChatMessageType.Dead, nil, nil, 0, Color(255,0,255,255))
        Game.SendDirectChatMessage(chatMsg, client)
    end)

    command.AddChatCommand("cls",lang.Lang("HelpChat_Cls"),function (client, args)
        if player.ProcessCooldown(client,4) then return end
        local cls = ""
        for i = 1, 60, 1 do
            cls = cls.."\n"
        end
        local chatMsg = ChatMessage.Create("", cls, ChatMessageType.Dead, nil, nil, nil, Color(0,0,0,0))
        Game.SendDirectChatMessage(chatMsg, client)
    end)
end

return module