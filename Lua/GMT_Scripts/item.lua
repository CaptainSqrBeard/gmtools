GMT.AddCommand("nearitems",GMT.Lang("Help_NearItems"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
    local size = 100
    local ignore_wires = true

    -- Checking size
    if args[1] ~= nil then
        size = tonumber(args[1])
        if size == nil then
            GMT.SendConsoleMessage("GMTools:",client,Color(255,0,128,255))
            return
        end
    end
    -- Checking wires
    if args[2] ~= nil and string.lower(args[2]) == "false" then
        ignore_wires = false
    elseif args[2] ~= nil and string.lower(args[2]) ~= "true" then
        GMT.SendConsoleMessage("GMTools: ",client,Color(255,0,128,255))
        return
    end

    local inves = {}
    local output_item = {}
    local output_inv = {}

    GMT.SendConsoleMessage(GMT.Lang("CMD_NearItems_nearitems",{size}),client,Color(255,0,255,255))

    -- lying items
    for i, item in ipairs(Item.ItemList) do
        local pos = item.WorldPosition
        if (GMT.InRange(pos.x,cursor.x-size,cursor.x+size)) and (GMT.InRange(pos.y,cursor.y-size,cursor.y+size)) and
        (not GMT.IsWire(item) or not ignore_wires)
        then
            -- Getting items in containers
            if item.ParentInventory ~= nil then
                local index = item.ParentInventory.Owner.ID
                if inves[index] == nil then
                    inves[index] = {}
                    inves[index].owner = item.ParentInventory.Owner
                    inves[index].count = 0
                end
                local value = inves[index].count
                inves[index].count = value+1
            else
                -- Getting lying items
                local name = item.Prefab.Identifier.Value
                GMT.SendConsoleMessage(GMT.Lang("CMD_NearItems_item",{name,item.ID,item.Condition}),client)
            end
        end
    end

    --Output items
    for i, inv in pairs(inves) do
        local owner = inv.owner
        local owner_name = GMT.Lang("CMD_NearItems_unknown")
        
        if not pcall(function ()
            owner_name = "'"..owner.Prefab.Identifier.Value.."'"
        end) then
            owner_name = tostring(owner)
        end

        GMT.SendConsoleMessage(GMT.Lang("CMD_NearItems_contained_item",{inv.count,owner.ID,owner_name}),client)
    end
end,{
{name="size",desc=GMT.Lang("Args_NearItems_size")},
{name="ignore_wires",desc=GMT.Lang("Args_NearItems_ignorewires")}})




GMT.AddCommand("deleteitem",GMT.Lang("Help_DeleteItem"),false,function(client,cursor,args)
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

    -- Deleting item
    Entity.Spawner.AddItemToRemoveQueue(item)

    local name = item.Prefab.Identifier.Value
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_DeteteItem_deleted",{name,id}),client,Color(255,0,255,255))
end,{{name="id",desc=GMT.Lang("Args_DeleteItem_id")}})




GMT.AddCommand("itemdata",GMT.Lang("Help_ItemData"),false,function(client,cursor,args)
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
        local tags_table = {}

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
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_condition",{item.Prefab.Identifier.Value,id,item.Condition}),client,Color(255,0,255,255))
    
    -- Tags: Show you all tags
    elseif args[2] == "tags" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_tags",{id,item.Prefab.Identifier.Value}),client,Color(255,0,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_rawtags",{item.Tags}),client,Color(255,255,255,255))
        for i, tag in ipairs(GMT.Split(item.Tags,",")) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemData_onetag",{i,tag}),client,Color(190,190,190,255))
        end
    
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemData_UnknownInput"),client,Color(255,0,0,255))
    end
end,{
{name="id",desc=GMT.Lang("Args_ItemData_id")},
{name="data",desc=GMT.Lang("Args_ItemData_data")}})