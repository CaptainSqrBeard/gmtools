GMT.AddCommand("chardata",GMT.Lang("Help_CharData"),true,nil)

GMT.AssignClientCommand("chardata",function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    -- Searching Character
    local char = GMT.GetCharacterByString(args[1])
    if char == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_CharacterNotFound"),client,Color(255,0,128,255))
        return
    end

    if args[2] == nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_header",{char.Name,char.ID}),client,Color(255,0,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_species",{char.SpeciesName.Value}),client,Color(255,255,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_health",{char.Vitality, char.MaxVitality}),client,Color(255,255,255,255))
        local cl = GMT.GetCharacterClient(char.ID)
        if cl ~= nil then
            GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_controlled",{cl.Name, cl.SessionId}),client,Color(255,255,255,255))
        else
            GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_uncontrolled"),client,Color(255,255,255,255))
        end
        if char.Inventory ~= nil then
            GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_has_inv",{char.ID}),client,Color(255,255,255,255))
        end

        
    elseif args[2] == "see_inv" then
        if char.Inventory == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_CharData_no_inv"),client,Color(255,0,0,255))
            return
        end

        GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_inv_header",{char.Name,char.ID}),client,Color(255,0,255,255))
        for item in char.Inventory.AllItems do
            if item.OwnInventory ~= nil then
                GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_inv_iteminv",{item.Prefab.Identifier.Value, item.ID}),client,Color(255,220,255,255))
            else
                GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_inv_item",{item.Prefab.Identifier.Value, item.ID}),client,Color(255,255,255,255))
            end
        end
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_CharData_UnknownInput"),client,Color(255,0,0,255))
    end
end)

GMT.AssignServerCommand("chardata",function(args)
    if #args == 0 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    -- Searching Character
    local char = GMT.GetCharacterByString(args[1])
    if char == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_CharacterNotFound"),Color(255,0,128,255))
        return
    end

    if args[2] == nil then
        GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_header",{char.Name,char.ID}),Color(255,0,255,255))
        GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_main_species",{char.SpeciesName.Value}),Color(255,255,255,255))
        GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_main_health",{char.Vitality, char.MaxVitality}),Color(255,255,255,255))
        local cl = GMT.GetCharacterClient(char.ID)
        if cl ~= nil then
            GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_main_controlled",{cl.Name, cl.SessionId}),Color(255,255,255,255))
        else
            GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_main_uncontrolled"),Color(255,255,255,255))
        end
        if char.Inventory ~= nil then
            GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_main_has_inv",{char.ID}),Color(255,255,255,255))
        end

        
    elseif args[2] == "see_inv" then
        if char.Inventory == nil then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_CharData_no_inv"),Color(255,0,0,255))
            return
        end

        GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_inv_header",{char.Name,char.ID}),Color(255,0,255,255))
        for item in char.Inventory.AllItems do
            if item.OwnInventory ~= nil then
                GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_inv_iteminv",{item.Prefab.Identifier.Value, item.ID}),Color(255,220,255,255))
            else
                GMT.NewConsoleMessage(GMT.Lang("CMD_CharData_inv_item",{item.Prefab.Identifier.Value, item.ID}),Color(255,255,255,255))
            end
        end
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_CharData_UnknownInput"),Color(255,0,0,255))
    end
end)