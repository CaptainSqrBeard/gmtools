GMT_PATH = table.pack(...)[1]

GMT = {}
GMT.HelpData = {}
GMT.ChatCommands = {}

if SERVER then
    -- Base
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
    require("GMT_Scripts.Objects.item")
    require("GMT_Scripts.Objects.itemedit")
    require("GMT_Scripts.Objects.character")
    require("GMT_Scripts.Moderation.adminpm")
    require("GMT_Scripts.Moderation.adminchat")
    require("GMT_Scripts.Moderation.ghostchat")
    require("GMT_Scripts.Moderation.jobban")
    require("GMT_Scripts.Moderation.smite")
    require("GMT_Scripts.Moderation.adminchat")
    require("GMT_Scripts.config")
    require("GMT_Scripts.other")

    -- Chat commands
    require("GMT_Scripts.Chat.other")

    -- Debug
    --require("GMT_Scripts.debug")

    -- Load playerdata
    GMT.PlayerData.Load()

    -- Checking Player Commands in config after adding them
    GMT.CheckPlayerCommands()
    


    Timer.Wait(function ()
        local init = {
            "======== GM-Tools ========",
            "* By CSQRB",
            "Print '.help' to get info",
            "========================="
        } 
        -- Add all connected clients
        for i, cl in ipairs(Client.ClientList) do
            GMT.Player.AddInMemory(cl)
        end
        print("\n"..table.concat(init,"\n").."\n ")
    end, 1000)

end

if CLIENT then 
    --print("Client-Side Lua")
end