GMT.AddCommand("humanlist",GMT.Lang("Help_HumanList"),true,nil)

GMT.AssignClientCommand("humanlist",function(client,cursor,args)
    GMT.SendConsoleMessage(GMT.Lang("CMD_HumanList_header"),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            GMT.SendConsoleMessage(GMT.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),client,Color(255,255,255,255))
        end
    end
end)

GMT.AssignServerCommand("humanlist",function(args)
    GMT.NewConsoleMessage(GMT.Lang("CMD_HumanList_header"),Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            GMT.NewConsoleMessage(GMT.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
        end
    end
end)