local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local player = require("GMT_Scripts._UTILS.player")
local permissions = require("GMT_Scripts._UTILS.permissions")

function module.initialize()
    command.AddCommand("see_ghostchat",lang.Lang("Help_SeeGhostChat"),false,function(client,cursor,args)
        local target

        -- Getting Target
        if args[2] ~= nil then
            target = utils.GetClientByString(args[2])
            if target == nil then
                utils.SendConsoleMessage("GMTools: Player not found",client,Color(255,0,128,255))
                return
            end
        else
            target = client
        end

        local status = player.CanSeeGhostChat(target)

        -- Getting Status
        if args[1] ~= nil then
            if args[1] == "true" then
                status = true
            elseif args[1] == "false" then
                status = false
            elseif args[1] == "switch" then
                status = not status
            else
                utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_SeeGhostchat_badargument"),client,Color(255,0,0,255))
                return
            end
        else
            status = not status
        end

        if status == true then
            player.playerMemory[target.SessionId].SeeGhostChat = true
            utils.SendConsoleMessage("GM-Tools: Forced Ghost Chat ENABLED for "..target.Name,client,Color(255,0,255,255))
        elseif status == false then
            player.playerMemory[target.SessionId].SeeGhostChat = false
            utils.SendConsoleMessage("GM-Tools: Forced Ghost Chat DISABLED for "..target.Name,client,Color(255,0,255,255))
        end

    end,{{name="status",desc=lang.Lang("Args_SeeGhostChat_status")},
    {name="target",desc=lang.Lang("Args_SeeGhostChat_target")}})

    command.AddCommand("deadmsg",lang.Lang("Help_DeadMsg"),false,nil,{{name="msg",desc=lang.Lang("Args_DeadMsg_msg")}})

    command.AssignSharedCommand("deadmsg",function (args, interface)
        if not Game.RoundStarted then
            interface.showMessage("GMTools: "..lang.Lang("CMD_DeadMsg_inround"),Color(255,0,0,255))
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
        if string.len(msg) > 200 then
            interface.showMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),Color(255,0,0,255))
            return
        end
        if msg:len() == 0 then
            interface.showMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage").."\n"..command.GetCommandUsageHelp("deadmsg"),Color(255,0,0,255))
            return
        end

        -- For sender
        if interface.executor ~= nil then
            local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, interface.executor.Character, interface.executor)
            Game.SendDirectChatMessage(chatMsg, interface.executor)
            Game.Server.AddChatMessage(chatMsg)
        else
            local chatMsg = ChatMessage.Create(lang.Lang("Console"), msg, ChatMessageType.Dead, nil, nil)
            Game.Server.AddChatMessage(chatMsg)
        end

        -- For ghosts
        for i, cl in ipairs(Client.ClientList) do
            if interface.executor ~= nil then
                if cl.SessionId ~= interface.executor.SessionId then
                    if cl.Character == nil or cl.Character.IsDead or player.CanSeeGhostChat(cl) then
                        local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, interface.executor.Character, interface.executor)
                        Game.SendDirectChatMessage(chatMsg, cl)
                    end
                end
            else
                if cl.Character == nil or cl.Character.IsDead or player.CanSeeGhostChat(cl) then
                    local chatMsg = ChatMessage.Create(lang.Lang("Console"), msg, ChatMessageType.Dead, nil, nil)
                    Game.SendDirectChatMessage(chatMsg, cl)
                end
            end

        end
    end)

    command.AddChatCommand("dead",lang.Lang("Help_DeadMsg"),function (client,args)
        if not permissions.HasPermission(client,".deadmsg") then
            local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("Error_NotEnoughPermissions"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
            Game.SendDirectChatMessage(chatMsg, client)
            return
        end
        if not Game.RoundStarted then
            local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("CMD_DeadMsg_inround"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
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
        if string.len(msg) > 200 then
            local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("Error_TooLongMessage"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
            Game.SendDirectChatMessage(chatMsg, client)
            return
        end
        if msg:len() == 0 then
            local chatMsg = ChatMessage.Create("GM-Tools",utils.FormattedText(lang.Lang("Error_NoMessage").."\n"..command.GetChatCommandUsageHelp(".dead"),{{name="color",value="#b1cbfc"}}), ChatMessageType.Dead, nil, nil)
            Game.SendDirectChatMessage(chatMsg, client)
            return
        end

        -- For sender
        local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
        Game.SendDirectChatMessage(chatMsg, client)
        Game.Server.AddChatMessage(chatMsg)

        -- For ghosts
        for i, cl in ipairs(Client.ClientList) do
            if cl.SessionId ~= client.SessionId then
                if cl.Character == nil or cl.Character.IsDead or player.CanSeeGhostChat(cl) then
                    local chatMsg = ChatMessage.Create(nil, msg, ChatMessageType.Dead, client.Character, client)
                    Game.SendDirectChatMessage(chatMsg, cl)
                end
            end
        end
    end,"<msg>")
end

return module