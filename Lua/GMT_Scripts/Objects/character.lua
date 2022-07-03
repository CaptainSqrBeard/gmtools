GMT.AddCommand("nearchars",GMT.Lang("Help_NearChars"),true,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    local size = 100

    -- Checking size
    if args[1] ~= nil then
        size = tonumber(args[1])
        if size == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_NearChars_badrange"),client,Color(255,0,128,255))
            return
        end
    end
    
    GMT.SendConsoleMessage(GMT.Lang("CMD_NearChars_nearchars",{size}),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        local pos = char.WorldPosition
        if (GMT.InRange(pos.x,cursor.x-size,cursor.x+size)) and (GMT.InRange(pos.y,cursor.y-size,cursor.y+size)) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_NearChars_char",{char.Name, char.ID}),client,Color(255,255,255,255))
        end
    end
end,{
{name="size",desc=GMT.Lang("Args_NearChars_size")}})

GMT.AddCommand("humanlist",GMT.Lang("Help_HumanList"),true,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    
    GMT.SendConsoleMessage(GMT.Lang("CMD_HumanList_header"),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        if char.IsHuman then
            GMT.SendConsoleMessage(GMT.Lang("CMD_HumanList_char",{char.Name, char.ID}),client,Color(255,255,255,255))
        end
    end
end)

GMT.AddCommand("chardata",GMT.Lang("Help_CharData"),true,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    
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
            GMT.SendConsoleMessage(GMT.Lang("CMD_CharData_main_controlled",{cl.Name, cl.ID}),client,Color(255,255,255,255))
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