local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local config = require("GMT_Scripts._UTILS.config")
local player = require("GMT_Scripts._UTILS.player")

command.AddCommand("cls",GMT.Lang("Help_Cls"),false,function(client,cursor,args)
    if player.ProcessCooldown(client,4) then
        return
    end
    local cls = ""
    for i = 1, 100, 1 do
        cls = cls..".\n"
    end
    utils.SendConsoleMessage(cls,client,Color(0,0,0,0))
end)

-- .ping
command.AddCommand("ping",GMT.Lang("Help_Ping"),false,nil)

command.AssignClientCommand("ping",function(client,cursor,args)
    if player.ProcessCooldown(client,1) then
        return
    end
    utils.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_Ping_pong"),client,Color(255,200,255,255))
end)

command.AssignServerCommand("ping",function(args)
    utils.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_Ping_pong"),Color(255,200,255,255))
end)

-- .list
command.AddCommand("list",GMT.Lang("Help_List"),false,nil)

command.AssignClientCommand("list",function(client,cursor,args)
    utils.SendConsoleMessage(GMT.Lang("CMD_ClientList_header"),client,Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        utils.SendConsoleMessage(GMT.Lang("CMD_ClientList_client",{cl.Name,cl.SessionId,name,cl.SteamID}),client)
    end
end)

command.AssignServerCommand("list",function(args)
    utils.NewConsoleMessage(GMT.Lang("CMD_ClientList_header"),Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        utils.NewConsoleMessage(GMT.Lang("CMD_ClientList_client",{cl.Name,cl.SessionId,name,cl.SteamID}))
    end
end)

-- .clock
local clock = ""..
"      11  12  1\n"..
" 10       ^       2\n"..
"9          |->     3\n"..
" 8                 4\n"..
"      7   6   5\n"
command.AddCommand("clock",GMT.Lang("Help_Clock"),false,nil)

command.AssignClientCommand("clock",function(client,cursor,args)
    if player.ProcessCooldown(client,3) then
        return
    end
    utils.SendConsoleMessage(clock,client,Color(255,250,204,255))
end)

command.AssignServerCommand("clock",function(args)
    utils.NewConsoleMessage(clock,Color(255,250,204,255))
end)



-- .lang
local lang = {"ru","en"}
command.AddCommand("lang",GMT.Lang("Help_Lang"),false,nil,{{name="language",desc=GMT.Lang("Args_Lang_language")}})

command.AssignClientCommand("lang",function(client,cursor,args)
    if args[1] == nil or string.lower(args[1]) == "all" then
        utils.SendConsoleMessage(GMT.Lang("CMD_Lang_header"),client,Color(255,0,255,255))
        for i, lan in ipairs(lang) do
            utils.SendConsoleMessage(GMT.Lang("CMD_Lang_element",{lan}),client,Color(255,255,255,255))
        end
        utils.SendConsoleMessage(GMT.Lang("CMD_Lang_suggest"),client,Color(255,255,255,255))
        return
    end

    local input = string.lower(args[1])
    if utils.Contains(lang,input) then
        GMT.Config.Vars.language = input
        config.Save()
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_changed",{input}),client,Color(255,0,255,255))
    else
        utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_unknown"),client,Color(255,0,0,255))
    end
end)

command.AssignServerCommand("lang",function(args)
    if args[1] == nil or string.lower(args[1]) == "all" then
        utils.NewConsoleMessage(GMT.Lang("CMD_Lang_header"),Color(255,0,255,255))
        for i, lan in ipairs(lang) do
            utils.NewConsoleMessage(GMT.Lang("CMD_Lang_element",{lan}),Color(255,255,255,255))
        end
        utils.NewConsoleMessage(GMT.Lang("CMD_Lang_suggest"),Color(255,255,255,255))
        return
    end

    local input = string.lower(args[1])
    if utils.Contains(lang,input) then
        GMT.Config.Vars.language = input
        config.Save()
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_changed",{input}),Color(255,0,255,255))
    else
        utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_unknown"),Color(255,0,0,255))
    end
end)