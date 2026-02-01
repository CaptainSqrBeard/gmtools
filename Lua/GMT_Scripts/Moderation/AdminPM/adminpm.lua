local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local permissions = require("GMT_Scripts._UTILS.permissions")

local function sendAdminPMToPlayer(sender,recipient,msg)
    local chatMsg = ChatMessage.Create(lang.Lang("CMD_AdminPM_msg_for_player_name",{sender.Name}), lang.Lang("CMD_AdminPM_msg_for_player_text",{sender.SteamID,sender.Name,recipient.SteamID,recipient.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L1",{sender.Name,recipient.Name}),recipient,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L2",{msg}),recipient,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L3"),recipient,Color(255,255,255,255))
end

local function sendConsolePMToPlayer(recipient,msg)
    local chatMsg = ChatMessage.Create(lang.Lang("CMD_AdminPM_msg_for_player_name",{lang.Lang("Console")}), lang.Lang("CMD_AdminPM_msg_for_player_text",{-1,lang.Lang("Console"),recipient.SteamID,recipient.Name,msg}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, recipient)

    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L1",{lang.Lang("Console"),recipient.Name}),recipient,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L2",{msg}),recipient,Color(255,255,255,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_player_L3"),recipient,Color(255,255,255,255))
end

command.AddCommand("adminpm",lang.Lang("Help_AdminPM"),false,nil,{
{name="target",desc=lang.Lang("Args_AdminPM_target")},
{name="msg",desc=lang.Lang("Args_AdminPM_msg")}})


command.AssignClientCommand("adminpm", function(client,cursor,args)
    if #args < 2 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_PlayerNotFound"),client,Color(255,0,0,255))
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
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),client,Color(255,0,0,255))
        return
    end
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),client,Color(255,0,0,255))
        return
    end

    -- For sender
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_admin_L1",{client.Name,r_client.Name}),client,Color(255,0,0,255))
    utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),client,Color(255,255,255,255))

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if (cl.SessionId ~= client.SessionId and cl.SessionId ~= r_client.SessionId) and permissions.HasPermission(cl,".adminpm") then
            utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_to_other_L1",{client.Name,r_client.Name}),cl,Color(255,0,0,255))
            utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
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
end)

command.AssignServerCommand("adminpm", function(args)
    local r_client = utils.GetClientByString(args[1])
    if r_client == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_PlayerNotFound"),Color(255,0,0,255),false)
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
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_TooLongMessage"),Color(255,0,0,255),false)
        return
    end
    msg = msg:sub(1, msg:len()-1)
    if msg:len() == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_AdminPM_NoMessage"),Color(255,0,0,255),false)
        return
    end

    -- For sender
    utils.NewConsoleMessage(lang.Lang("CMD_AdminPM_con_for_admin_L1",{lang.Lang("Console"),r_client.Name}),Color(255,0,0,255),false)
    utils.NewConsoleMessage(lang.Lang("CMD_AdminPM_con_for_admin_L2",{msg}),Color(255,255,255,255),false)

    -- For other admins
    for i, cl in ipairs(Client.ClientList) do
        if permissions.HasPermission(cl,".adminpm") then
            utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_to_other_L1",{lang.Lang("Console"),r_client.Name}),cl,Color(255,0,0,255))
            utils.SendConsoleMessage(lang.Lang("CMD_AdminPM_con_to_other_L2",{msg}),cl,Color(255,255,255,255))
        end
    end

    
    -- For recipient
    sendConsolePMToPlayer(r_client,msg)
    if GMT.ForcedLaunch == false and GMT.Config.Vars.do_bwoink == true then -- THE BWOINK SOUND
        local bwoink_chr = r_client.Character

        -- It will works only if player controls character.
        if bwoink_chr ~= nil and bwoink_chr.IsDead == false then
            local bwoinkAff = AfflictionPrefab.Prefabs["gmtbwoink"]
            r_client.Character.CharacterHealth.ApplyAffliction(bwoink_chr.AnimController.MainLimb, bwoinkAff.Instantiate(1))
        end
    end
end)