GMT.AddCommand("nearitems",GMT.Lang("Help_NearItems"),true,nil,{
{name="size",desc=GMT.Lang("Args_NearItems_size"),optional=true},
{name="ignore_wires",desc=GMT.Lang("Args_NearItems_ignorewires"),optional=true}})

GMT.AssignClientCommand("nearitems",function(client,cursor,args)
    local size = 100
    local ignore_wires = true

    -- Checking size
    if args[1] ~= nil then
        size = tonumber(args[1])
        if size == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_NearItems_badrange"),client,Color(255,0,128,255))
            return
        end
    end
    -- Checking wires
    if args[2] ~= nil and string.lower(args[2]) == "false" then
        ignore_wires = false
    elseif args[2] ~= nil and string.lower(args[2]) ~= "true" then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_NearItems_badwires"),client,Color(255,0,128,255))
        return
    end

    local inves = {}

    GMT.SendConsoleMessage(GMT.Lang("CMD_NearItems_nearitems",{size}),client,Color(255,0,255,255))

    -- lying items
    for i, item in ipairs(Item.ItemList) do
        local pos = item.WorldPosition
        if (GMT.SquaredDistance(cursor.x,cursor.y,pos.x,pos.y) < size*size) and
        (not GMT.IsAttachedWire(item) or not ignore_wires)
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
end)

GMT.AssignServerCommand("nearitems",function(args)
    GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_bad_console"),Color(255,0,0,255))
end)