GMT.AddCommand("sublist",GMT.Lang("Help_SubmarineList"),true,nil)

GMT.AssignSharedCommand("sublist",function (args, interface)
    interface.showMessage(GMT.Lang("CMD_SubmarineList_header"),Color(255,0,255,255))
    for i, sub in ipairs(Submarine.Loaded) do
        local tags = GMT.Lang(GMT.SubmarineTypes[sub.Info.Type+1])
        if sub.IsRespawnShuttle  then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_respawn_shuttle")
        end
        if sub == Submarine.MainSub then
            tags = tags..", "..GMT.Lang("CMD_SubmarineList_mainsub")
        end
        interface.showMessage(GMT.Lang("CMD_SubmarineList_sub",{i, sub.Info.Name, tags}), Color(255,255,255,255))
    end
end)