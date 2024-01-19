GMT.AddCommand("sublist",GMT.Lang("Help_SubmarineList"),true,nil)

GMT.AssignClientCommand("sublist",function(client,cursor,args)
    GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineList_header"),client,Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = GMT.Lang(GMT.SubmarineTypes[sub.Info.Type+1])
        if sub == Game.RespawnManager.RespawnShuttle then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_mainsub")
        end
        GMT.SendConsoleMessage(GMT.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), client, Color(255,255,255,255))
    end
end)

GMT.AssignServerCommand("sublist",function(args)
    GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineList_header"),Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = GMT.Lang(GMT.SubmarineTypes[sub.Info.Type+1])
        if sub == Game.RespawnManager.RespawnShuttle then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_mainsub")
        end
        GMT.NewConsoleMessage(GMT.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), Color(255,255,255,255))
    end
end)