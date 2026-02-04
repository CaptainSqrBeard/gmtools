local module = {}
module.initialized = false

function module.initialize(contentPackage, forcedLaunch, path)
    if module.initialized then
        return
    end

    module.initialized = true

    module.contentPackage = contentPackage
    module.forcedLaunch = forcedLaunch
    module.path = path


    -- Base
    local lang = require("GMT_Scripts._UTILS.lang")
    local player = require("GMT_Scripts._UTILS.player")
    local playerdb = require("GMT_Scripts._UTILS.playerdb")
    local config = require("GMT_Scripts._UTILS.config")
    local permissions = require("GMT_Scripts._UTILS.permissions")
    local gameInfo = require("GMT_Scripts._UTILS.gameInfo")
    local command = require("GMT_Scripts._UTILS.command")
    local addons = require("GMT_Scripts.addons")
    local files = require("GMT_Scripts._UTILS.files")
    local sanctions = require("GMT_Scripts._UTILS.sanctions")
    
    require("GMT_Scripts.hooks").initialize()
    sanctions.initialize()

    files.initialize(config.GetDefaultJSONConfig())

    -- Load config and lang
    config.Load()
    lang.Load(config.configValues.language)

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

    require("GMT_Scripts.Moderation.Jobban.jobban").initialize()
    require("GMT_Scripts.Moderation.Jobban.unjobban").initialize()
    require("GMT_Scripts.Moderation.Jobban.jobban_list").initialize()

    require("GMT_Scripts.Moderation.smite").initialize()
    require("GMT_Scripts.config").initialize()
    require("GMT_Scripts.other").initialize()
    
    -- Chat commands
    require("GMT_Scripts.Chat.other").initialize()
    
    playerdb.Load()
    config.CheckPlayerCommands()

    Timer.Wait(function ()
        -- Init message
        local init = {
            "======== GM-Tools ========",
            "* By CSQRB",
            "Print '.help' to get info",
        } 

        -- List addons
        if #addons.InstalledAddons > 0 then
            table.insert(init, "\nList of addons:")
            for i, addon in ipairs(addons.InstalledAddons) do
                table.insert(init, "- \""..addon.ContentPackage.Name.."\" Ver: "..addon.ContentPackage.ModVersion)
            end
        end

        -- End init message
        table.insert(init, "=========================")
        
        -- Send message
        print("\n"..table.concat(init,"\n").."\n ")

        -- Add all connected clients
        for i, cl in ipairs(Client.ClientList) do
            player.AddInMemory(cl)
            permissions.RestorePerms(cl)
        end
    end, 1000)

    -- Addons API: Call event so addons can register
    if not forcedLaunch then
        -- We call an event only after all mods are loaded so addons could see it
        Hook.Add("loaded", "gmt_loaded", function ()
            Hook.Call("gmtools.loaded", {contentPackage, forcedLaunch})
        end)
    else
        -- Addons are already loaded so we just call an event
        Hook.Call("gmtools.loaded", {contentPackage, forcedLaunch})
    end
end

return module