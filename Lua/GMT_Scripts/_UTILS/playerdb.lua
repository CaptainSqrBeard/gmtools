local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local lang = require("GMT_Scripts._UTILS.lang")
local command = require("GMT_Scripts._UTILS.command")
local config = require("GMT_Scripts._UTILS.config")
local files = require("GMT_Scripts._UTILS.files")
local legacyPlayerdb = require("GMT_Scripts.Migration.legacyPlayerdb")
local sanctions = require("GMT_Scripts._UTILS.sanctions")
local main = require("GMT_Scripts.main")

local legacyPlayersPath = files.getPath().."players.txt"
local playerDataPath = files.getPath().."Players/"

local cachedPlayers = {}

-- Loads player data
function module.Load()
    files.validateFolder(playerDataPath)

    -- Migration: Try to save old player data
    if File.Exists(legacyPlayersPath) then
        -- Load old data
        utils.SendConsoleMessageAdminLevel('GM-Tools: Migrating from legacy player database',Color(255,128,0,255))
        local oldPlayers = legacyPlayerdb.Load(File.Read(legacyPlayersPath))

        -- Save data
        if oldPlayers ~= nil then
            for steamid, data in pairs(oldPlayers) do
                File.Write(playerDataPath..steamid..".json", json.serialize(module.ValidatePlayerData(data)))
            end
        end

        -- Backup and delete old player data
        files.backupFile(legacyPlayersPath)
        File.Delete(legacyPlayersPath)
    end

    -- Cache every connected client
    for i, client in ipairs(Client.ClientList) do
        module.GetEntry(client.SteamID)
    end
end

-- Creates table of default player data
function module.GetDefaultPlayerData(name)
    return {name=name, command_permissions={}, permissions={}, sanctions={}}
end

-- Retrieves player data entry. Caches it too
function module.GetEntry(steamid)
    -- Try use cached entry if present
    if cachedPlayers[steamid] == nil then
        -- Load player data from file
        local dataPath = playerDataPath..steamid..".json"
        if File.Exists(dataPath) then
            local parsedTable
            local content = File.Read(dataPath)
            local status, err = pcall(function ()
                parsedTable = json.parse(content)
            end)
        
            -- If parse failed, backup player data and load default one
            if err ~= nil then
                local backupName, backupPath = files.backupFile(dataPath, "Players")
                main.SendWarningMessage('GM-Tools: Could not parse player data of '..steamid..'. Loading default player data:\n|   '..err..'\nBackup of old player data was made: '..backupPath..backupName)
                cachedPlayers[steamid] = module.GetDefaultPlayerData()
            else
                cachedPlayers[steamid] = module.ValidatePlayerData(parsedTable)
            end
        else
            cachedPlayers[steamid] = module.GetDefaultPlayerData()
        end
    end
    
    return cachedPlayers[steamid]
end

-- Validates player data
function module.ValidatePlayerData(playerData)
    local validatedData = {}
    validatedData.data_version = 1
    validatedData.command_permissions = {}
    validatedData.permissions = {}
    validatedData.sanctions = {}

    if type(playerData.name) == "string" then
        validatedData.name = playerData.name
    end

    if playerData.command_permissions ~= nil then
        validatedData.command_permissions = playerData.command_permissions
    end

    if playerData.permissions ~= nil then
        validatedData.permissions = playerData.permissions
    end

    if playerData.sanctions ~= nil then
        for i, sanction in ipairs(playerData.sanctions) do
            local validatedSanction = sanctions.validateSanction(sanction)
            if validatedSanction ~= nil then
                table.insert(validatedData.sanctions, validatedSanction)
            end
        end
    end

    return validatedData
end

-- Saves all cached player data
function module.Save()
    for steamid, data in pairs(cachedPlayers) do
        File.Write(playerDataPath..steamid..".json", json.serialize(data))
    end
end


-- Saves data of one particular player
function module.SavePlayer(steamid)
    -- No changes in uncached player data
    if cachedPlayers[steamid] == nil then
        return
    end
    File.Write(playerDataPath..steamid..".json", json.serialize(cachedPlayers[steamid]))
end

-- Applies job ban to player
function module.JobBan(client,job_id,period,reason)
    if not module.JobBanSteam(client.SteamID, job_id, period, reason) then
        return false
    end

    local chatMessage = ChatMessage.Create("", lang.Lang("CMD_Jobban_Box",{job_id,lang.GetTimeString(period),reason}), ChatMessageType.MessageBox, nil, nil)
    chatMessage.Color = Color(255, 60, 60, 255)
    Game.SendDirectChatMessage(chatMessage, client)

    return true
end

-- Applies job ban by steam id
function module.JobBanSteam(client_steam,job_id,period,reason)
    utils.Expect(1, client_steam, "string")
    utils.Expect(2, job_id, "string")
    utils.Expect(3, period, "number")
    utils.Expect(4, reason, "string")
    
    if job_id == config.configValues.lowest_job or module.HasPermission(client_steam, "jobban_immune") then
        return false
    end

    if reason == nil then reason = "No reason" end

    local entry = module.GetEntry(client_steam)

    local currentTime = os.time()

    local expiresAt
    if period ~= nil and period ~= 0 then
        expiresAt = math.floor(currentTime + period)
    else
        expiresAt = -1
    end

    local oldJobban = module.GetJobBan(client_steam, job_id)
    if config.configValues.stack_job_bans and oldJobban ~= nil and oldJobban.expiresAt > 0 then
        oldJobban.revoked = true
        expiresAt = expiresAt + (oldJobban.expiresAt - currentTime)
        reason = reason.." + "..oldJobban.additionalData.reason
    end
    
    local sanction = sanctions.createSanction("job_ban", expiresAt, {reason=reason, job=job_id})
    table.insert(entry.sanctions, sanction)

    module.SavePlayer(client_steam)
    return true
end

-- Gets job ban on specified job
function module.GetJobBan(client_steam,job_id)
    if job_id == config.configValues.lowest_job or module.HasPermission(client_steam, "jobban_immune") then
        return
    end

    local entry = module.GetEntry(client_steam)
    local active_jobbans = sanctions.getActiveSanctions(entry, "job_ban")

    local longestBan

    for i, jobban in ipairs(active_jobbans) do
        if jobban.additionalData.job == job_id then
            if longestBan == nil then
                longestBan = jobban
            elseif jobban.expiresAt == -1 then
                return jobban
            elseif jobban.expiresAt > longestBan.expiresAt then
                longestBan = jobban
            end
        end
    end

    return longestBan
end

-- Gets all job bans
function module.GetJobBans(client_steam,job_id)
    if job_id == config.configValues.lowest_job or module.HasPermission(client_steam, "jobban_immune") then
        return {}
    end

    local entry = module.GetEntry(client_steam)

    local found = {}
    local active_jobbans = sanctions.getActiveSanctions(entry, "job_ban")

    for i, jobban in ipairs(active_jobbans) do
        if jobban.additionalData.job == job_id then
            table.insert(found, jobban)
        end
    end
    
    return found
end

-- this method also exists in permissions module :|
function module.HasPermission(steamid, requiredPermissions)
    utils.Expect(2, requiredPermissions, "string")

    local playerCommands = config.configValues.player_commands

    if utils.Contains(playerCommands, requiredPermissions) then return true end

    if utils.Contains(module.GetEntry(steamid).permissions, requiredPermissions) then return true end
    return false
end

return module