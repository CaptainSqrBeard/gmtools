GMT.AddCommand("deleteitem",GMT.Lang("Help_DeleteItem"),true,nil,{{name="id",desc=GMT.Lang("Args_DeleteItem_id")}})

GMT.AssignClientCommand("deleteitem",function(client,cursor,args)
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
end)

GMT.AssignServerCommand("deleteitem",function(args)
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
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),Color(255,0,128,255))
        return
    end

    -- Deleting item
    Entity.Spawner.AddItemToRemoveQueue(item)

    local name = item.Prefab.Identifier.Value
    GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_DeteteItem_deleted",{name,id}),Color(255,0,255,255))
end)