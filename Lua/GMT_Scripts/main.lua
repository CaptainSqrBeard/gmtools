local module = {}

local DebugConsole = LuaUserData.CreateStatic('Barotrauma.DebugConsole', true)

local messages
local lang
local player
local playerdb
local config
local permissions
local gameInfo
local command
local addons
local files
local sanctions
local utils

module.initialized = false

function module.SendWarningMessage(message)
    Game.Log("GM-Tools: "..message, ServerLogMessageType.Error)
    DebugConsole.NewMessage(message, Color(255, 128, 0, 255), false)
    if config.configValues.admin_warnings then
        for i, cl in ipairs(Client.ClientList) do
            if playerdb.HasPermission(cl.SteamID, "admin_warnings") then
                utils.SendConsoleMessage(message, cl, Color(255, 128, 0, 255))
            end
        end
    else
        for i, cl in ipairs(Client.ClientList) do
            utils.SendConsoleMessage(message, cl, Color(255, 128, 0, 255))
        end
    end
end

function module.initialize(contentPackage, forcedLaunch, path)
    if module.initialized then
        return
    end

    module.initialized = true

    module.contentPackage = contentPackage
    module.forcedLaunch = forcedLaunch
    module.path = path

    -- Base
    messages = require("GMT_Scripts._UTILS.messages")
    lang = require("GMT_Scripts._UTILS.lang")
    player = require("GMT_Scripts._UTILS.player")
    playerdb = require("GMT_Scripts._UTILS.playerdb")
    config = require("GMT_Scripts._UTILS.config")
    permissions = require("GMT_Scripts._UTILS.permissions")
    gameInfo = require("GMT_Scripts._UTILS.gameInfo")
    command = require("GMT_Scripts._UTILS.command")
    addons = require("GMT_Scripts.addons")
    files = require("GMT_Scripts._UTILS.files")
    sanctions = require("GMT_Scripts._UTILS.sanctions")
    utils = require("GMT_Scripts._UTILS.utils")
    
    files.initialize(config.GetDefaultJSONConfig())

    -- Load config and lang
    config.Load()
    config.Save()

    lang.Load(config.configValues.language)

    permissions.initialize()
    require("GMT_Scripts.hooks").initialize()
    sanctions.initialize()

    -- Console commands
    require("GMT_Scripts.help")

    require("GMT_Scripts.Objects.Item.deleteitem").initialize()
    require("GMT_Scripts.Objects.Item.itemdata").initialize()
    require("GMT_Scripts.Objects.Item.itemedit").initialize()
    require("GMT_Scripts.Objects.Item.nearitems").initialize()

    require("GMT_Scripts.Objects.Character.chardata").initialize()
    require("GMT_Scripts.Objects.Character.spawnchar").initialize()
    require("GMT_Scripts.Objects.Character.humanlist").initialize()
    require("GMT_Scripts.Objects.Character.nearchars").initialize()
    
    require("GMT_Scripts.Objects.Submarine.sublist").initialize()
    require("GMT_Scripts.Objects.Submarine.subteleport").initialize()
    require("GMT_Scripts.Objects.Submarine.subdata").initialize()
    require("GMT_Scripts.Objects.Submarine.sublock").initialize()
    require("GMT_Scripts.Objects.Submarine.subgodmode").initialize()
    require("GMT_Scripts.Objects.Submarine.subaddturretai").initialize()
    require("GMT_Scripts.Objects.Submarine.subthrow").initialize()

    require("GMT_Scripts.Moderation.AdminPM.ahelp").initialize()
    require("GMT_Scripts.Moderation.AdminPM.adminpm").initialize()
    require("GMT_Scripts.Moderation.AdminPM.toggles").initialize()

    require("GMT_Scripts.Moderation.adminchat").initialize()
    require("GMT_Scripts.Moderation.ghostchat").initialize()

    require("GMT_Scripts.Moderation.Permissions.giveperm").initialize()
    require("GMT_Scripts.Moderation.Permissions.revokeperm").initialize()
    require("GMT_Scripts.Moderation.Permissions.permlist").initialize()
    require("GMT_Scripts.Moderation.Permissions.permhelper").initialize()

    require("GMT_Scripts.Moderation.Jobban.jobban").initialize()
    require("GMT_Scripts.Moderation.Jobban.unjobban").initialize()
    require("GMT_Scripts.Moderation.Jobban.jobban_list").initialize()
    
    require("GMT_Scripts.Moderation.Sanction.sanction_delete").initialize()
    require("GMT_Scripts.Moderation.Sanction.sanction_list").initialize()

    require("GMT_Scripts.Moderation.smite").initialize()
    require("GMT_Scripts.config").initialize()
    require("GMT_Scripts.other").initialize()
    
    -- Chat commands
    require("GMT_Scripts.Chat.other").initialize()
    
    playerdb.Load()
    playerdb.Save()

    if config.configValues.debug_mode then
        require("GMT_Scripts.debug").initialize()
    end

    -- Add all connected clients
    for i, cl in ipairs(Client.ClientList) do
        player.AddInMemory(cl)
        permissions.RestorePerms(cl)
    end

    Timer.Wait(function ()
        if config.configValues.print_startup_message then
            for i, client in ipairs(Client.ClientList) do
                local startupMessage = lang.Lang("StartupMessage", {module.contentPackage.ModVersion})
                if not string.find(startupMessage, "CSQRB", 1, true) then
                    startupMessage = "|  By CSQRB\n|  Version: "..module.contentPackage.ModVersion
                end

                utils.SendConsoleMessage("===== GM-Tools =====", client, Color(255,128,255,255))
                utils.SendConsoleMessage(startupMessage, client, Color(255,255,255,255))

                -- List addons
                if #addons.InstalledAddons > 0 then
                    local modList = {}
                    for i, addon in ipairs(addons.InstalledAddons) do
                        table.insert(modList, "|  * \""..addon.ContentPackage.Name.."\" Ver: "..addon.ContentPackage.ModVersion)
                    end
                    utils.SendConsoleMessage(lang.Lang("StartupMessage_AddonList"), client, Color(255,128,255,255))
                    utils.SendConsoleMessage(table.concat(modList, "\n").."\n", client, Color(255,255,255,255))
                end
            end
        end

        -- Add all connected clients again (because host could not be on server in its first ticks)
        for i, cl in ipairs(Client.ClientList) do
            player.AddInMemory(cl)
            permissions.RestorePerms(cl)
        end
    end, 1000)

    -- Addons API: Call event so addons can register
    if not forcedLaunch then
        -- We call the hook only after all mods are loaded so addons could see it
        Hook.Add("loaded", "gmt_loaded", function ()
            Hook.Call("gmtools.loaded", {contentPackage, forcedLaunch})
        end)
    else
        -- Addons are already loaded so we just call an event
        Hook.Call("gmtools.loaded", {contentPackage, forcedLaunch})
    end
end

return module