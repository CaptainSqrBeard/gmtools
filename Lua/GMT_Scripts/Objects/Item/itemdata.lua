GMT.AddCommand("itemdata",GMT.Lang("Help_ItemData"),true,nil,{
{name="id",desc=GMT.Lang("Args_ItemData_id")},
{name="data",desc=GMT.Lang("Args_ItemData_data")},optional=true})

GMT.AssignSharedCommand("itemdata",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments").."\n"..GMT.GetCommandUsageHelp("itemdata"),Color(255,0,128,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_id"),Color(255,0,128,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = GMT.GetItemByID(id)
    if item == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),Color(255,0,128,255))
        return
    end

    -- No parameter: Show everything
    if args[2] == nil then
        interface.showMessage(GMT.Lang("CMD_ItemData_header",{id,item.Prefab.Identifier.Value}),Color(255,0,255,255))
        interface.showMessage(GMT.Lang("CMD_ItemData_main_condition",{item.Condition}),Color(255,255,255,255))
        interface.showMessage(GMT.Lang("CMD_ItemData_main_tags",{item.Tags}),Color(255,255,255,255))
        if item.OwnInventory ~= nil then
            interface.showMessage(GMT.Lang("CMD_ItemData_main_has_inv",{id}),Color(255,220,255,255))
        end
        if item.ParentInventory ~= nil then
            local owner = item.ParentInventory.Owner
            local owner_name = "Unknown"
            if not pcall(function ()
                owner_name = "'"..owner.Prefab.Identifier.Value.."'"
            end) then
                owner_name = tostring(owner)
            end
            interface.showMessage(GMT.Lang("CMD_ItemData_main_contained",{owner_name,owner.ID}),Color(255,220,255,255))
        end
    
    -- Tags: Show you condition
    elseif args[2] == "condition" then
        interface.showMessage(GMT.Lang("CMD_ItemData_condition",{item.Prefab.Identifier.Value,item.ID,item.Condition}),Color(255,0,255,255))
    
    -- Tags: Show you all tags
    elseif args[2] == "tags" then
        interface.showMessage(GMT.Lang("CMD_ItemData_tags",{id,item.Prefab.Identifier.Value}),Color(255,0,255,255))
        interface.showMessage(GMT.Lang("CMD_ItemData_rawtags",{item.Tags}),Color(255,255,255,255))
        for i, tag in ipairs(GMT.Split(item.Tags,",")) do
            interface.showMessage(GMT.Lang("CMD_ItemData_onetag",{i,tag}),Color(190,190,190,255))
        end

    elseif args[2] == "see_inv" then
        if item.OwnInventory == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemData_no_inv",{item.Prefab.Identifier.Value,id}),Color(255,0,0,255))
            return
        end

        -- Item can have multiply containers (Like deconstructor)
        local item_containers = {}
        for i, component in ipairs(item.Components) do
            if component.Name == "ItemContainer" then
                table.insert(item_containers, component)
            end
        end
        
        interface.showMessage(GMT.Lang("CMD_ItemData_inventory",{item.Prefab.Identifier.Value,id}),Color(255,0,255,255))
        for i, container in ipairs(item_containers) do
            interface.showMessage(GMT.Lang("CMD_ItemData_container",{i}),Color(255,220,255,255))
            for i_item in container.Inventory.AllItems do
                if i_item.OwnInventory ~= nil then
                    interface.showMessage(GMT.Lang("CMD_ItemData_inv_item_winv",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),Color(255,255,255,255))
                else
                    interface.showMessage(GMT.Lang("CMD_ItemData_inv_item",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),Color(255,255,255,255))
                end
                
            end
        end
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemData_UnknownInput"),Color(255,0,0,255))
    end
end)