GMT.AddCommand("chardata",GMT.Lang("Help_CharData"),true,nil,{
    {name="character",desc=GMT.Lang("Args_CharData_character")}})

GMT.AssignSharedCommand("chardata",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    -- Searching Character
    local char = GMT.GetCharacterByString(args[1])
    if char == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_CharacterNotFound"),Color(255,0,128,255))
        return
    end

    if args[2] == nil then
        interface.showMessage(GMT.Lang("CMD_CharData_header",{char.Name,char.ID}),Color(255,0,255,255))
        interface.showMessage(GMT.Lang("CMD_CharData_main_species",{char.SpeciesName.Value}),Color(255,255,255,255))
        interface.showMessage(GMT.Lang("CMD_CharData_main_team",{GMT.GetLocalizedTeam(char.TeamID)}),Color(255,255,255,255))
        interface.showMessage(GMT.Lang("CMD_CharData_main_health",{char.Vitality, char.MaxVitality}),Color(255,255,255,255))
        local cl = GMT.GetCharacterClient(char.ID)
        if cl ~= nil then
            interface.showMessage(GMT.Lang("CMD_CharData_main_controlled",{cl.Name, cl.SessionId}),Color(255,255,255,255))
        else
            interface.showMessage(GMT.Lang("CMD_CharData_main_uncontrolled"),Color(255,255,255,255))
        end
        if char.Inventory ~= nil then
            interface.showMessage(GMT.Lang("CMD_CharData_main_has_inv",{char.ID}),Color(255,255,255,255))
        end

        
    elseif args[2] == "see_inv" then
        if char.Inventory == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_CharData_no_inv"),Color(255,0,0,255))
            return
        end

        interface.showMessage(GMT.Lang("CMD_CharData_inv_header",{char.Name,char.ID}),Color(255,0,255,255))
        for item in char.Inventory.AllItems do
            if item.OwnInventory ~= nil then
                interface.showMessage(GMT.Lang("CMD_CharData_inv_iteminv",{item.Prefab.Identifier.Value, item.ID}),Color(255,220,255,255))
            else
                interface.showMessage(GMT.Lang("CMD_CharData_inv_item",{item.Prefab.Identifier.Value, item.ID}),Color(255,255,255,255))
            end
        end
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_CharData_UnknownInput"),Color(255,0,0,255))
    end
end)