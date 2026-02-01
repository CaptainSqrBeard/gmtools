local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("deleteitem",lang.Lang("Help_DeleteItem"),true,nil,{{name="id",desc=lang.Lang("Args_DeleteItem_id")}})

command.AssignSharedCommand("deleteitem",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("deleteitem"),Color(255,0,128,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        interface.showMessage("GMTools: "..lang.Lang("Error_bad_id"),Color(255,0,128,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = utils.GetItemByID(id)
    if item == nil then
        interface.showMessage("GMTools: "..lang.Lang("Error_ItemNotFound"),Color(255,0,128,255))
        return
    end

    -- Deleting item
    Entity.Spawner.AddItemToRemoveQueue(item)

    local name = item.Prefab.Identifier.Value
    interface.showMessage("GMTools: "..lang.Lang("CMD_DeteteItem_deleted",{name,id}),Color(255,0,255,255))
end)