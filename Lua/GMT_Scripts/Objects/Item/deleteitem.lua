GMT.AddCommand("deleteitem",GMT.Lang("Help_DeleteItem"),true,nil,{{name="id",desc=GMT.Lang("Args_DeleteItem_id")}})

GMT.AssignSharedCommand("deleteitem",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments").."\n"..GMT.GetCommandUsageHelp("deleteitem"),Color(255,0,128,255))
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

    -- Deleting item
    Entity.Spawner.AddItemToRemoveQueue(item)

    local name = item.Prefab.Identifier.Value
    interface.showMessage("GMTools: "..GMT.Lang("CMD_DeteteItem_deleted",{name,id}),Color(255,0,255,255))
end)