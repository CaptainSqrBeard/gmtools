local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local permissions = require("GMT_Scripts._UTILS.permissions")

local ADMIN_CHAT_PREFIX = "[GMT ADMIN CHAT] "

command.AddChatCommand("admin",lang.Lang("Help_AdminChat"),function (client,args)
    if not permissions.HasPermission(client,".adminchat") then
        local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("Error_NotEnoughPermissions"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    
    if msg:len() == 0 then
        local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("CMD_AdminPM_NoMessage"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if string.len(msg) > 200 then
        local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("Error_TooLongMessage"),{{name="color",value="#ff8589"}}), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    Game.Log(ADMIN_CHAT_PREFIX..utils.ClientLogName(client)..": "..msg, ServerLogMessageType.Chat)
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(nil, utils.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, client.Character, client)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end)

command.AddCommand("adminchat",lang.Lang("Help_AdminChat"),false,nil,{{name="msg",desc=lang.Lang("Args_AdminChat_msg")}})

command.AssignClientCommand("adminchat",function(client,cursor,args)
    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if msg:len() == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    if string.len(msg) > 200 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),client,Color(255,0,128,255))
    end

    Game.Log(ADMIN_CHAT_PREFIX..utils.ClientLogName(client)..": "..msg, ServerLogMessageType.Chat)
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(nil, utils.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, client.Character, client)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end)

command.AssignServerCommand("adminchat",function(args)
    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    for i = 1, msg:len(), 1 do
        if msg:sub(i,i) ~= " " then
            msg = msg:sub(i, msg:len() )
            break
        end
    end
    if msg:len() == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),Color(255,0,0,255),false)
        return
    end

    if string.len(msg) > 200 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),Color(255,0,0,128),false)
    end

    Game.Log(ADMIN_CHAT_PREFIX.."CONSOLE: "..msg, ServerLogMessageType.Chat)
    for i, cl in ipairs(Client.ClientList) do
        if GMT.HasGMTPermission(cl,".adminchat") then
            local chatMsg = ChatMessage.Create(lang.Lang("Console"), utils.FormattedText(msg,{{name="color",value="#cc4a4e"}}), ChatMessageType.Error, nil, nil)
            Game.SendDirectChatMessage(chatMsg, cl)
        end
    end
end)