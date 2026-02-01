local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("chardata",lang.Lang("Help_CharData"),true,nil,{
    {name="character",desc=lang.Lang("Args_CharData_character")}})

command.AssignClientCommand("chardata",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    -- Searching Character
    local char = utils.GetCharacterByString(args[1])
    if char == nil then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_CharacterNotFound"),client,Color(255,0,128,255))
        return
    end

    if args[2] == nil then
        utils.SendConsoleMessage(lang.Lang("CMD_CharData_header",{char.Name,char.ID}),client,Color(255,0,255,255))
        utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_species",{char.SpeciesName.Value}),client,Color(255,255,255,255))
        utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_team",{GMT.GetLocalizedTeam(char.TeamID)}),client,Color(255,255,255,255))
        utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_health",{char.Vitality, char.MaxVitality}),client,Color(255,255,255,255))
        local cl = utils.GetCharacterClient(char.ID)
        if cl ~= nil then
            utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_controlled",{cl.Name, cl.SessionId}),client,Color(255,255,255,255))
        else
            utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_uncontrolled"),client,Color(255,255,255,255))
        end
        if char.Inventory ~= nil then
            utils.SendConsoleMessage(lang.Lang("CMD_CharData_main_has_inv",{char.ID}),client,Color(255,255,255,255))
        end

        
    elseif args[2] == "see_inv" then
        if char.Inventory == nil then
            utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_CharData_no_inv"),client,Color(255,0,0,255))
            return
        end

        utils.SendConsoleMessage(lang.Lang("CMD_CharData_inv_header",{char.Name,char.ID}),client,Color(255,0,255,255))
        for item in char.Inventory.AllItems do
            if item.OwnInventory ~= nil then
                utils.SendConsoleMessage(lang.Lang("CMD_CharData_inv_iteminv",{item.Prefab.Identifier.Value, item.ID}),client,Color(255,220,255,255))
            else
                utils.SendConsoleMessage(lang.Lang("CMD_CharData_inv_item",{item.Prefab.Identifier.Value, item.ID}),client,Color(255,255,255,255))
            end
        end
    else
        utils.SendConsoleMessage("GMTools: "..lang.Lang("CMD_CharData_UnknownInput"),client,Color(255,0,0,255))
    end
end)

command.AssignServerCommand("chardata",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    -- Searching Character
    local char = utils.GetCharacterByString(args[1])
    if char == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_CharacterNotFound"),Color(255,0,128,255))
        return
    end

    if args[2] == nil then
        utils.NewConsoleMessage(lang.Lang("CMD_CharData_header",{char.Name,char.ID}),Color(255,0,255,255))
        utils.NewConsoleMessage(lang.Lang("CMD_CharData_main_species",{char.SpeciesName.Value}),Color(255,255,255,255))
        utils.NewConsoleMessage(lang.Lang("CMD_CharData_main_health",{char.Vitality, char.MaxVitality}),Color(255,255,255,255))
        local cl = utils.GetCharacterClient(char.ID)
        if cl ~= nil then
            utils.NewConsoleMessage(lang.Lang("CMD_CharData_main_controlled",{cl.Name, cl.SessionId}),Color(255,255,255,255))
        else
            utils.NewConsoleMessage(lang.Lang("CMD_CharData_main_uncontrolled"),Color(255,255,255,255))
        end
        if char.Inventory ~= nil then
            utils.NewConsoleMessage(lang.Lang("CMD_CharData_main_has_inv",{char.ID}),Color(255,255,255,255))
        end

        
    elseif args[2] == "see_inv" then
        if char.Inventory == nil then
            utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_CharData_no_inv"),Color(255,0,0,255))
            return
        end

        utils.NewConsoleMessage(lang.Lang("CMD_CharData_inv_header",{char.Name,char.ID}),Color(255,0,255,255))
        for item in char.Inventory.AllItems do
            if item.OwnInventory ~= nil then
                utils.NewConsoleMessage(lang.Lang("CMD_CharData_inv_iteminv",{item.Prefab.Identifier.Value, item.ID}),Color(255,220,255,255))
            else
                utils.NewConsoleMessage(lang.Lang("CMD_CharData_inv_item",{item.Prefab.Identifier.Value, item.ID}),Color(255,255,255,255))
            end
        end
    else
        utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_CharData_UnknownInput"),Color(255,0,0,255))
    end
end)