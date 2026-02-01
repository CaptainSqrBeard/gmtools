
local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local config = require("GMT_Scripts._UTILS.config")
local player = require("GMT_Scripts._UTILS.player")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("cls",lang.Lang("Help_Cls"),false,nil)

command.AssignSharedCommand("cls",function (args, interface)
    if interface.executor ~= nil and player.ProcessCooldown(interface.executor, 4) then
        return
    end
    local cls = ""
    for i = 1, 100, 1 do
        cls = cls..".\n"
    end

    interface.showMessage(cls,Color(0,0,0,0))
end)

-- .ping
command.AddCommand("ping",lang.Lang("Help_Ping"),false,nil)


command.AssignSharedCommand("ping",function (args, interface)
    if interface.executor ~= nil and player.ProcessCooldown(interface.executor,1) then
        return
    end
    interface.showMessage("GM-Tools: "..lang.Lang("CMD_Ping_pong"),Color(255,200,255,255))
end)

-- .list
command.AddCommand("list",lang.Lang("Help_List"),false,nil)


command.AssignSharedCommand("list",function (args, interface)
    interface.showMessage(lang.Lang("CMD_ClientList_header"),Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        interface.showMessage(lang.Lang("CMD_ClientList_client",{cl.Name,cl.SessionId,name,cl.SteamID}))
    end
end)

-- .clock
command.AddCommand("clock",lang.Lang("Help_Clock"),false,nil)

command.AssignClientCommand("clock",function(client,cursor,args)
    if player.ProcessCooldown(client,3) then
        return
    end
    local clock = ""..
    "      11  12  1\n"..
    " 10       ^       2\n"..
    "9          |->     3\n"..
    " 8                 4\n"..
    "      7   6   5\n"
    utils.SendConsoleMessage(clock,client,Color(255,250,204,255))
end)

GMT.AssignServerCommand("clock",function(args)
    local clock = ""..
    "   11 12 1\n"..
    " 10   ^    2\n"..
    "9     |->   3\n"..
    " 8         4\n"..
    "   7  6  5\n"
    utils.NewConsoleMessage(clock,Color(255,250,204,255))
end)

-- .lang
local languages = lang.AvailableLanguages()

command.AssignSharedCommand("lang",function (args, interface)
    if args[1] == nil or string.lower(args[1]) == "all" then
        interface.showMessage(lang.Lang("CMD_Lang_header"),Color(255,0,255,255))
        for i, lan in ipairs(lang) do
            interface.showMessage(lang.Lang("CMD_Lang_element",{lan}),Color(255,255,255,255))
        end
        interface.showMessage(GMT.GetCommandUsageHelp("revokeperm").."\n"..lang.Lang("CMD_Lang_suggest"),Color(255,255,255,255))
        return
    end

    local input = string.lower(args[1])
    if utils.Contains(languages, input) then
        GMT.Config.Vars.language = input
        config.Save()
        interface.showMessage("GMTools: "..lang.Lang("CMD_Lang_changed",{input}),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..lang.Lang("CMD_Lang_unknown"),Color(255,0,0,255))
    end
end)
