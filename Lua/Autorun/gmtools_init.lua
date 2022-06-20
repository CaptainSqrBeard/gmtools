GMT_PATH = table.pack(...)[1]

GMT = {}
GMT.HelpData = {}
GMT.ChatCommands = {}

if SERVER then
    -- Base
    require("GMT_Scripts._UTILS.utils")
    require("GMT_Scripts._UTILS.command")
    require("GMT_Scripts._UTILS.config")
    require("GMT_Scripts._UTILS.player")
    require("GMT_Scripts._UTILS.playerdb")
    require("GMT_Scripts._UTILS.permissions")
    require("GMT_Scripts.hooks")

    -- Console commands
    require("GMT_Scripts.help")
    require("GMT_Scripts.item")
    require("GMT_Scripts.adminpm")
    require("GMT_Scripts.other")
    require("GMT_Scripts.ghostchat")
    require("GMT_Scripts.config")
    require("GMT_Scripts.jobban")
    require("GMT_Scripts.smite")
    require("GMT_Scripts.adminchat")

    -- Chat commands
    require("GMT_Scripts.Chat.adminhelp")
    require("GMT_Scripts.Chat.other")

    -- Debug
    require("GMT_Scripts.debug")

    -- Load config and playerdata
    GMT.Config.Load()
    GMT.PlayerData.Load()


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