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

GMT.AddCommand("ping",GMT.Lang("Help_Ping"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,1) then
        return
    end

    GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("CMD_Ping_pong"),client,Color(255,200,255,255))
end)


GMT.AddCommand("list",GMT.Lang("Help_List"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end

    GMT.SendConsoleMessage(GMT.Lang("CMD_ClientList_header"),client,Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        GMT.SendConsoleMessage(GMT.Lang("CMD_ClientList_client",{cl.Name,cl.ID,name,cl.SteamID}),client)
    end
end)

local lang = {"ru","en"}
GMT.AddCommand("lang",GMT.Lang("Help_Lang"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,3) then
        return
    end

    if args[1] == nil or string.lower(args[1]) == "all" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_Lang_header"),client,Color(255,0,255,255))
        for i, lang in ipairs(lang) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_Lang_element",{lang}),client,Color(255,255,255,255))
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
end,{{name="language",desc=GMT.Lang("Args_Lang_language")}})