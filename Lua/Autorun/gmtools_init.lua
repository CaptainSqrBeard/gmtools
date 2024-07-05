-- Launching second GM-Tools can occur some bugs
if GMT ~= nil then
    return
end

GMT_PATH = table.pack(...)[1]

GMT = {}
GMT.ForcedLaunch = false
GMT.HelpData = {}
GMT.ChatCommands = {}

if SERVER then
    -- Get current package
    for i, mod in ipairs(Game.GetEnabledContentPackages()) do
        if GMT_PATH.."/filelist.xml" == mod.Path then
            GMT.ContentPackage = mod
        end
    end

    -- Base
    require("GMT_Scripts._UTILS.data")
    require("GMT_Scripts._UTILS.lang")
    require("GMT_Scripts._UTILS.utils")
    require("GMT_Scripts._UTILS.command")
    require("GMT_Scripts._UTILS.config")
    require("GMT_Scripts._UTILS.player")
    require("GMT_Scripts._UTILS.playerdb")
    require("GMT_Scripts._UTILS.permissions")
    require("GMT_Scripts.hooks")

    -- Load config and lang
    GMT.Config.Load()
    GMT.LangFiles.Load(GMT.Config.Vars.language)

    -- Console commands
    require("GMT_Scripts.help")

    require("GMT_Scripts.Objects.Item.deleteitem")
    require("GMT_Scripts.Objects.Item.itemdata")
    require("GMT_Scripts.Objects.Item.itemedit")
    require("GMT_Scripts.Objects.Item.nearitems")

    require("GMT_Scripts.Objects.Character.chardata")
    require("GMT_Scripts.Objects.Character.humanlist")
    require("GMT_Scripts.Objects.Character.nearchars")
    
    require("GMT_Scripts.Objects.Submarine.sublist")
    require("GMT_Scripts.Objects.Submarine.subteleport")
    require("GMT_Scripts.Objects.Submarine.subdata")
    require("GMT_Scripts.Objects.Submarine.sublock")
    require("GMT_Scripts.Objects.Submarine.subgodmode")
    require("GMT_Scripts.Objects.Submarine.subaddturretai")
    require("GMT_Scripts.Objects.Submarine.subthrow")

    require("GMT_Scripts.Moderation.AdminPM.ahelp")
    require("GMT_Scripts.Moderation.AdminPM.adminpm")
    require("GMT_Scripts.Moderation.AdminPM.toggles")

    require("GMT_Scripts.Moderation.adminchat")
    require("GMT_Scripts.Moderation.ghostchat")

    require("GMT_Scripts.Moderation.Permissions.giveperm")
    require("GMT_Scripts.Moderation.Permissions.revokeperm")
    require("GMT_Scripts.Moderation.Permissions.permlist")

    require("GMT_Scripts.Moderation.Jobban.jobban")
    require("GMT_Scripts.Moderation.Jobban.unjobban")

    require("GMT_Scripts.Moderation.smite")
    require("GMT_Scripts.Moderation.adminchat")
    require("GMT_Scripts.config")
    require("GMT_Scripts.other")

    require("GMT_Scripts.Api.addons")

    -- Chat commands
    require("GMT_Scripts.Chat.other")

    -- Debug
    --require("GMT_Scripts.debug")

    -- Load playerdata
    GMT.PlayerData.Load()

    -- Checking Player Commands in config after adding them
    GMT.CheckPlayerCommands()

    Timer.Wait(function ()
        -- Init message
        local init = {
            "======== GM-Tools ========",
            "* By CSQRB",
            "Print '.help' to get info",
        } 

        -- List addons
        if #GMT.Addons > 0 then
            table.insert(init, "\nList of addons:")
            for i, addon in ipairs(GMT.Addons) do
                table.insert(init, "- \""..addon.ContentPackage.Name.."\" Ver: "..addon.ContentPackage.ModVersion)
            end
        end

        -- End init message
        table.insert(init, "=========================")
        
        -- Send message
        print("\n"..table.concat(init,"\n").."\n ")

        -- Add all connected clients
        for i, cl in ipairs(Client.ClientList) do
            GMT.Player.AddInMemory(cl)
            GMT.RestorePerms(cl)
        end
    end, 1000)
end

Hook.Add("loaded", "gmt_loaded", function ()
    -- Addons API: Call event so addons can register
    Hook.Call("gmtools.loaded", {})
end)

if CLIENT then
    --print("Client-Side Lua")
end