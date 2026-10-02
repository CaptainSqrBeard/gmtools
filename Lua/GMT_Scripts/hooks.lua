local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local player = require("GMT_Scripts._UTILS.player")
local playerdb = require("GMT_Scripts._UTILS.playerdb")
local permissions = require("GMT_Scripts._UTILS.permissions")
local lang = require("GMT_Scripts._UTILS.lang")
local command = require("GMT_Scripts._UTILS.command")
local config = require("GMT_Scripts._UTILS.config")

function module.initialize()
    local DebugConsole = LuaUserData.CreateStatic('Barotrauma.DebugConsole', true)

    Hook.Add("client.connected", "GMT.client_connect", function(client)
        local playerData = playerdb.GetEntry(client.SteamID)
        
        if not Game.IsDedicated and client.SessionId == 1 then
            -- All perms to host
            playerData.command_permissions = command.ListAllCommands()
            playerData.permissions = permissions.ListAllPermissions()
            playerdb.SavePlayer(client.SteamID)
        end

        permissions.RestorePerms(client)
        player.AddInMemory(client)

    end)

    Hook.Add("client.disconnected", "GMT.client_disconnect", function(client)
        player.DeleteFromMemory(client)
    end)


    Hook.Add("chatMessage", "GMT.chatmessage", function(msg, client)
        -- Chat commands
        if msg:sub(1,1) == "." then
            local split = command.SplitCommand(msg)
            local command = command.ChatCommands[split[1]]

            if command == nil or command.func == nil then
                local chatMsg = ChatMessage.Create("GM-Tools",lang.Lang("Chat_Error_UnknownCommand",{split[1]}), ChatMessageType.Error, nil, nil)
                Game.SendDirectChatMessage(chatMsg, client)
                return true
            end

            local name = split[1]
            table.remove(split,1)

            Game.Log("GM-Tools: "..utils.ClientLogName(client).." executed ChatCommand: \""..msg:sub(1,200).."\"", ServerLogMessageType.ConsoleUsage)
            local status, err = pcall(function ()
                command.func(client,split)
            end)
            if err ~= nil then
                for i, cl in ipairs(Client.ClientList) do
                    utils.SendConsoleMessage("An Error has occured in ChatCommand \""..name.."\":\n"..err,cl,Color(255,0,0,255))
                end
            end
            return true -- Prevent sending message
        end

        -- Ghost Chat
        if (Game.RoundStarted) and (msg:sub(1,2) == "d;" or msg:sub(1,5) == "dead;" or utils.CanSpeakGhost(client.Character)) then
            local out_msg = msg

            -- Removing dead chat prefix and spaces at start of the message
            if out_msg:sub(1,2) == "d;" then
                out_msg = out_msg:sub(3, out_msg:len() )
            elseif msg:sub(1,5) == "dead;" then
                out_msg = out_msg:sub(6, out_msg:len() )
            end
            for i = 1, out_msg:len(), 1 do
                if out_msg:sub(i,i) ~= " " then
                    out_msg = out_msg:sub(i, out_msg:len() )
                    break
                end
            end

            for i, cl in ipairs(Client.ClientList) do
                if (cl.Character ~= nil and not cl.Character.IsDead and cl.Character.SpeechImpediment < 100) and (player.CanSeeGhostChat(cl)) then
                    local chatMsg = ChatMessage.Create(nil, out_msg, ChatMessageType.Dead, client.Character, client)
                    Game.SendDirectChatMessage(chatMsg, cl)
                end
            end

        end
    end)

    Hook.Add("tryChangeClientName", "GMT.character_change", function(client,newName,newJob,newTeam)
        local playerData = player.playerMemory[client.SessionId]

        if playerData.LastJob ~= newJob then
            playerData.LastJob = newJob
            local jobBan = playerdb.GetJobBan(client.SteamID, newJob.Value)
            if jobBan ~= nil then
                local time
                if jobBan.expiresAt == -1 then
                    time = lang.GetTimeString(0)
                else
                    time = lang.GetTimeString(jobBan.expiresAt - os.time())
                end

                local chatMessage = ChatMessage.Create("", lang.Lang("CMD_Jobban_Reminder",{time,jobBan.additionalData.reason, config.configValues.lowest_job}), ChatMessageType.MessageBox, nil, nil)
                chatMessage.Color = Color(255, 60, 60, 255)
                Game.SendDirectChatMessage(chatMessage, client)
                return false
            end
        end
    end)

    Hook.Add("jobsAssigned", "GMT.jobs_assigned", function ()
        for key, value in pairs(Client.ClientList) do
            if value.AssignedJob ~= nil and playerdb.GetJobBan(value.SteamID, value.AssignedJob.Prefab.Identifier.Value) ~= nil then
                value.AssignedJob = JobVariant(JobPrefab.Get(config.configValues.lowest_job), 0)
                local chatMsg = ChatMessage.Create("JOB-BAN",lang.Lang("CMD_Jobban_ForcedPlay",{config.configValues.lowest_job}), ChatMessageType.Error, nil, nil)
                Game.SendDirectChatMessage(chatMsg, value)
            end
        end
    end)

    
	-- Hook on GMTools load
	Hook.Add("gmtools.loaded", "gmt_bwoink_load", function(contentPackage, forcedLaunch)
		for i, mod in ipairs(Game.GetEnabledContentPackages()) do
			-- Load only if registration was approved
			if path == mod.Dir and addons.RegisterAddon(mod) then
				loadAddon()
				break
			end
		end
	end)

	Hook.Patch("Barotrauma.DebugConsole", "ExecuteClientCommand",
	function(instance, ptable)
        if not config.configValues.patch_console then
            return nil
        end

        local client = ptable["client"]
        local cursor = ptable["cursorWorldPos"]
        local consoleInput = ptable["command"]

        local executedCommand = command.GetCommandFromConsoleInput(consoleInput)

        -- Custom execution for our commands
        if (command.IsGMTCommand(executedCommand)) then
            local givenCommand = command.GetCommandByName(executedCommand)
            local firstName = utils.GetFirstElement(givenCommand.names)
            if givenCommand ~= nil then
                if permissions.HasGMTCommandPermission(client, firstName.value) then
                    ptable.PreventExecution = true
                    local splitCommand = command.SplitCommand(consoleInput)
                    table.remove(splitCommand, 1)
                    
                    local success, err = pcall(function()
                        givenCommand.ServerExecuteOnClientRequest(client, cursor, splitCommand);
                        Game.Log("GM-Tools: Console command \"" .. consoleInput .. "\" executed by " .. utils.ClientLogName(client) .. ".", ServerLogMessageType.ConsoleUsage);
                    end)
                end
            end
        end

		return nil
	end, Hook.HookMethodType.Before)

    Hook.Patch("Barotrauma.Networking.GameServer", "ClientReadServerCommand",
	function(instance, ptable)
        if not config.configValues.patch_console then
            return nil
        end

        local inc = ptable["inc"]

        local sender
        for i, client in ipairs(Game.Server.ConnectedClients) do
            if client.Connection == inc.Sender then
                sender = client
                break
            end
        end

        if sender == nil then
            return nil
        end

        local cmd = ClientPermissions.None
        local preCmdInitialPos = inc.BitPosition
        cmd = inc.ReadUInt16()

        -- Make our commands be executable without console command permissions
        if cmd == ClientPermissions.ConsoleCommands then
            local preInputInitialPos = inc.BitPosition
            consoleInput = inc.ReadString()
            inc.BitPosition = preInputInitialPos

            local executedCommand = command.GetCommandFromConsoleInput(consoleInput)

            local playerCommands = config.configValues.player_commands

            if utils.Contains(playerCommands, executedCommand) and command.IsGMTCommand(executedCommand) then
                ptable.PreventExecution = true
                DebugConsole.ServerRead(inc, sender)
            end
        end

        -- it is important to set bit position back, otherwise stuff will break
        inc.BitPosition = preCmdInitialPos

        return nil
	end, Hook.HookMethodType.Before)
end

return module