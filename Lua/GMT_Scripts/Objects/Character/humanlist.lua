GMT.AddCommand("humanlist",GMT.Lang("Help_HumanList"),true,nil)

GMT.AssignSharedCommand("humanlist",function (args, interface)
    interface.showMessage(GMT.Lang("CMD_HumanList_header"),Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            interface.showMessage(GMT.Lang("CMD_HumanList_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
        end
    end
end)