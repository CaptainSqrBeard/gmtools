local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local player = require("GMT_Scripts._UTILS.player")
local lang = require("GMT_Scripts._UTILS.lang")
local permissions = require("GMT_Scripts._UTILS.permissions")

local function sendAHelpToAdmins(sender,recipient,msg)
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_admin_L1",{sender.Name}),recipient,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_admin_L2",{msg}),recipient,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_admin_L3",{sender.SessionId}),recipient,Color(255,255,255,255))

    local chatMsg = ChatMessage.Create(lang.Lang("CMD_AHelp_msg_for_admin_name"), lang.Lang("CMD_AHelp_msg_for_admin_text",{sender.SteamID,sender.Name,msg,sender.SessionId}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)
end

command.AddCommand("ahelp",lang.Lang("Help_AHelp"),false,nil,{{name="msg",desc=lang.Lang("Args_AHelp_msg")}})

command.AssignClientCommand("ahelp",function(client,cursor,args)
    if GMT.Config.Vars.ahelp_enabled == false then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_AHelp_disabled"),client,Color(255,0,0,255))
        return
    end

    if player.ProcessCooldown(client,2) then
        return
    end

    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),client,Color(255,0,0,255))
        return
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
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if permissions.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end)

command.AssignServerCommand("ahelp",function(args)
    utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_bad_console"),Color(255,0,0,255),false) -- how you will adminPM something that isn't a client?
end)



-- Chat Command
command.AddChatCommand("ahelp",lang.Lang("Help_AHelp"),function (client,args)
    if player.ProcessCooldown(client,2) then return end
    if GMT.Config.Vars.ahelp_enabled == false then
        local chatMsg = ChatMessage.Create("ADMIN HELP",lang.Lang("CMD_AHelp_disabled"), ChatMessageType.Error, nil, nil)
        Game.SendDirectChatMessage(chatMsg, client)
        return
    end

    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    local msg = ""
    for i = 1, #args, 1 do
        msg = msg..args[i].." "
    end
    if string.len(msg) > 200 then
        utils.SendConsoleMessage("GMTools: Message is too big!",client,Color(255,0,128,255))
    end
    msg = msg:sub(1, msg:len()-1)

    -- For sender
    local S_chatMsg = ChatMessage.Create(lang.Lang("CMD_AHelp_msg_for_player_name"),
        lang.Lang("CMD_AHelp_msg_for_player_text",{client.SessionId,client.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(S_chatMsg, client)

    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_player_L1",{client.Name}),client,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AHelp_con_for_player_L2",{msg}),client,Color(255,255,255,255))

    -- For recipients
    for i, cl in ipairs(Client.ClientList) do
        if permissions.HasPermission(cl,".adminpm") then
            sendAHelpToAdmins(client,cl,msg)
        end
    end
end)