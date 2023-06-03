GMT.AddCommand("itemdata",GMT.Lang("Help_ItemData"),true,nil,{
{name="id",desc=GMT.Lang("Args_ItemData_id")},
{name="data",desc=GMT.Lang("Args_ItemData_data")}})

GMT.AssignClientCommand("itemdata",function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_id"),client,Color(255,0,128,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = GMT.GetItemByID(id)
    if item == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),client,Color(255,0,128,255))
        return
    end

    -- No parameter: Show everything
    if args[2] == nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_header",{id,item.Prefab.Identifier.Value}),client,Color(255,0,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_main_condition",{item.Condition}),client,Color(255,255,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_main_tags",{item.Tags}),client,Color(255,255,255,255))
        if item.OwnInventory ~= nil then
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_main_has_inv",{id}),client,Color(255,220,255,255))
        end
        if item.ParentInventory ~= nil then
            local owner = item.ParentInventory.Owner
            local owner_name = "Unknown"
            if not pcall(function ()
                owner_name = "'"..owner.Prefab.Identifier.Value.."'"
            end) then
                owner_name = tostring(owner)
            end
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_main_contained",{owner_name,owner.ID}),client,Color(255,220,255,255))
        end
    
    -- Tags: Show you condition
    elseif args[2] == "condition" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_condition",{item.Prefab.Identifier.Value,item.ID,item.Condition}),client,Color(255,0,255,255))
    
    -- Tags: Show you all tags
    elseif args[2] == "tags" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_tags",{id,item.Prefab.Identifier.Value}),client,Color(255,0,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_rawtags",{item.Tags}),client,Color(255,255,255,255))
        for i, tag in ipairs(GMT.Split(item.Tags,",")) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_onetag",{i,tag}),client,Color(190,190,190,255))
        end

    elseif args[2] == "see_inv" then
        if item.OwnInventory == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemData_no_inv",{item.Prefab.Identifier.Value,id}),client,Color(255,0,0,255))
            return
        end

        -- Item can have multiply containers (Like deconstructor)
        local item_containers = {}
        for i, component in ipairs(item.Components) do
            if component.Name == "ItemContainer" then
                table.insert(item_containers, component)
            end
        end
        
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_inventory",{item.Prefab.Identifier.Value,id}),client,Color(255,0,255,255))
        for i, container in ipairs(item_containers) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_container",{i}),client,Color(255,220,255,255))
            for i_item in container.Inventory.AllItems do
                if i_item.OwnInventory ~= nil then
                    GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_inv_item_winv",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),client,Color(255,255,255,255))
                else
                    GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_inv_item",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),client,Color(255,255,255,255))
                end
                
            end
        end
        
    
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemData_UnknownInput"),client,Color(255,0,0,255))
    end
end)

GMT.AssignServerCommand("itemdata",function(args)
    if #args == 0 then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_bad_id"),Color(255,0,128,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = GMT.GetItemByID(id)
    if item == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),Color(255,0,128,255))
        return
    end

    -- No parameter: Show everything
    if args[2] == nil then
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_header",{id,item.Prefab.Identifier.Value}),Color(255,0,255,255))
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_main_condition",{item.Condition}),Color(255,255,255,255))
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_main_tags",{item.Tags}),Color(255,255,255,255))
        if item.OwnInventory ~= nil then
            GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_main_has_inv",{id}),Color(255,220,255,255))
        end
        if item.ParentInventory ~= nil then
            local owner = item.ParentInventory.Owner
            local owner_name = "Unknown"
            if not pcall(function ()
                owner_name = "'"..owner.Prefab.Identifier.Value.."'"
            end) then
                owner_name = tostring(owner)
            end
            GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_main_contained",{owner_name,owner.ID}),Color(255,220,255,255))
        end
    
    -- Tags: Show you condition
    elseif args[2] == "condition" then
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_condition",{item.Prefab.Identifier.Value,item.ID,item.Condition}),Color(255,0,255,255))
    
    -- Tags: Show you all tags
    elseif args[2] == "tags" then
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_tags",{id,item.Prefab.Identifier.Value}),Color(255,0,255,255))
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_rawtags",{item.Tags}),Color(255,255,255,255))
        for i, tag in ipairs(GMT.Split(item.Tags,",")) do
            GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_onetag",{i,tag}),Color(190,190,190,255))
        end

    elseif args[2] == "see_inv" then
        if item.OwnInventory == nil then
            GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemData_no_inv",{item.Prefab.Identifier.Value,id}),Color(255,0,0,255))
            return
        end

        -- Item can have multiply containers (Like deconstructor)
        local item_containers = {}
        for i, component in ipairs(item.Components) do
            if component.Name == "ItemContainer" then
                table.insert(item_containers, component)
            end
        end
        
        GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_inventory",{item.Prefab.Identifier.Value,id}),Color(255,0,255,255))
        for i, container in ipairs(item_containers) do
            GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_container",{i}),Color(255,220,255,255))
            for i_item in container.Inventory.AllItems do
                if i_item.OwnInventory ~= nil then
                    GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_inv_item_winv",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),Color(255,255,255,255))
                else
                    GMT.NewConsoleMessage(GMT.Lang("CMD_ItemData_inv_item",{i_item.Prefab.Identifier.value,i_item.ID,i_item.Condition}),Color(255,255,255,255))
                end
                
            end
        end
        
    
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemData_UnknownInput"),Color(255,0,0,255))
    end
end)