GMT.AddCommand("cls",GMT.Lang("Help_Cls"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end
    local cls = ""
    for i = 1, 100, 1 do
        cls = cls..".\n"
    end
    GMT.SendConsoleMessage(cls,client,Color(0,0,0,0))
end)

-- .ping
GMT.AddCommand("ping",GMT.Lang("Help_Ping"),false,nil)

GMT.AssignClientCommand("ping",function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,1) then
        return
    end
    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_Ping_pong"),client,Color(255,200,255,255))
end)

GMT.AssignServerCommand("ping",function(args)
    GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("CMD_Ping_pong"),Color(255,200,255,255))
end)

-- .list
GMT.AddCommand("list",GMT.Lang("Help_List"),false,nil)

GMT.AssignClientCommand("list",function(client,cursor,args)
    GMT.SendConsoleMessage(GMT.Lang("CMD_ClientList_header"),client,Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        GMT.SendConsoleMessage(GMT.Lang("CMD_ClientList_client",{cl.Name,cl.SessionId,name,cl.SteamID}),client)
    end
end)

GMT.AssignServerCommand("list",function(args)
    GMT.NewConsoleMessage(GMT.Lang("CMD_ClientList_header"),Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        GMT.NewConsoleMessage(GMT.Lang("CMD_ClientList_client",{cl.Name,cl.SessionId,name,cl.SteamID}))
    end
end)

-- .clock
local clock = ""..
"      11  12  1\n"..
" 10       ^       2\n"..
"9          |->     3\n"..
" 8                 4\n"..
"      7   6   5\n"
GMT.AddCommand("clock",GMT.Lang("Help_Clock"),false,nil)

GMT.AssignClientCommand("clock",function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,3) then
        return
    end
    GMT.SendConsoleMessage(clock,client,Color(255,250,204,255))
end)

GMT.AssignServerCommand("clock",function(args)
    GMT.NewConsoleMessage(clock,Color(255,250,204,255))
end)



-- .lang
local lang = {"ru","en"}
GMT.AddCommand("lang",GMT.Lang("Help_Lang"),false,nil,{{name="language",desc=GMT.Lang("Args_Lang_language")}})

GMT.AssignClientCommand("lang",function(client,cursor,args)
    if args[1] == nil or string.lower(args[1]) == "all" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_Lang_header"),client,Color(255,0,255,255))
        for i, lan in ipairs(lang) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_Lang_element",{lan}),client,Color(255,255,255,255))
        end
        GMT.SendConsoleMessage(GMT.Lang("CMD_Lang_suggest"),client,Color(255,255,255,255))
        return
    end

    local input = string.lower(args[1])
    if GMT.Contains(lang,input) then
        GMT.Config.Vars.language = input
        GMT.Config.Save()
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_changed",{input}),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_unknown"),client,Color(255,0,0,255))
    end
end)

GMT.AssignServerCommand("lang",function(args)
    if args[1] == nil or string.lower(args[1]) == "all" then
        GMT.NewConsoleMessage(GMT.Lang("CMD_Lang_header"),Color(255,0,255,255))
        for i, lan in ipairs(lang) do
            GMT.NewConsoleMessage(GMT.Lang("CMD_Lang_element",{lan}),Color(255,255,255,255))
        end
        GMT.NewConsoleMessage(GMT.Lang("CMD_Lang_suggest"),Color(255,255,255,255))
        return
    end

    local input = string.lower(args[1])
    if GMT.Contains(lang,input) then
        GMT.Config.Vars.language = input
        GMT.Config.Save()
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_changed",{input}),Color(255,0,255,255))
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Lang_unknown"),Color(255,0,0,255))
    end
end)