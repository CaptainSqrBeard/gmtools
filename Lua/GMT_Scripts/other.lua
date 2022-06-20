GMT.AddCommand("cls","Clears console",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end
    local cls = ""
    for i = 1, 100, 1 do
        cls = cls..".\n"
    end
    GMT.SendConsoleMessage(cls,client,Color(0,0,0,0))
end)

GMT.AddCommand("ping","Pong!",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,1) then
        return
    end

    GMT.SendConsoleMessage("GM-Tools: Pong!",client,Color(255,200,255,255))
end)


GMT.AddCommand("list","Sends list of players on server",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end

    GMT.SendConsoleMessage("Client list:",client,Color(255,0,255,255))
    for i, cl in ipairs(Client.ClientList) do
        local name
        if cl.Character ~= nil then
            name = cl.Character.Name.." ["..cl.Character.ID.."]"
        else
            name = "None"
        end
        GMT.SendConsoleMessage("* Name: "..cl.Name..", ID: "..cl.ID..", Character: "..name..", SteamID: "..cl.SteamID,client)
    end
end)