local actions = {}

local function newAction(component,name,helpstring,func)
    if actions[component] == nil then
        actions[component] = {}
    end
    actions[component][name] = {help=helpstring,func=func}
end

-- Door
newAction("Door", "open", "Opens or closes door",function (client, item, component, args)
    if args[1] == nil then
        component.TrySetState(not component.IsOpen, true,true)
        return
    end

    if args[1] == "true" then
        component.TrySetState(true, true,true)
        return
    elseif args[1] == "false" then
        component.TrySetState(false, true,true)
        return
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),client,Color(255,0,0,255))
    end
end)

-- Quality
newAction("Quality", "level", "Changes level of item (Medium desync)",function (client, item, component, args)
    --QualityLevel
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_info",{component.QualityLevel,component.MaxQuality}),client,Color(255,0,128,255))
    else
        local level = tonumber(args[1])
        if level == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_badlevel"),client,Color(255,0,0,255))
            return
        end
        if level < 0 or level > component.MaxQuality then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_outofrange"),client,Color(255,0,0,255))
            return
        end
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_warn"),client,Color(255,128,0,255))
        component.QualityLevel = level
    end
end)

-- i hate syncing
newAction("Quality", "sync", "test",function (client, item, component, args)
    --local eventData = Item.ComponentStateEventData.__new(component, component.ServerGetEventData())
    --if not component.ValidateEventData(component) then return end
    --Networking.CreateEntityEvent(item, eventData)

    print(component)
    item.CreateServerEvent(component, component)

    --local property = item.SerializableProperties[Identifier("SpriteColor")]
    --print(property)
    --Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property))
end)
newAction("Holdable", "list", "test",function (client, item, component, args)
    for k, val in pairs(item.SerializableProperties) do
        print(k)
    end
end)


-- Holdable
newAction("Holdable", "pick", "Makes player pick item",function (client, item, component, args)
    local char = GMT.GetCharacterByString(args[1])
    if char == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_CharacterNotFound"),client,Color(255,0,0,255))
        return
    end
    component.Pick(char)
end)

newAction("Holdable", "attach", "Attach or deattach items from wall",function (client, item, component, args)
    if not component.Attachable then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_unable"),client,Color(255,0,0,255))
        return
    end
    if not component.Attached then
        component.AttachToWall()
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_attached"),client,Color(255,0,255,255))
    else
        component.DeattachFromWall()
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_deattached"),client,Color(255,0,255,255))
    end
end)


-- PowerContainer
newAction("PowerContainer", "power", "Changes contained power in battery",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_power_info",{component.Charge,component.Capacity}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.Charge = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_power_set",{component.Charge,component.Capacity}),client,Color(255,0,255,255))
        
end)

newAction("PowerContainer", "capacity", "Changes max power for battery (Small desync)",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_info",{component.Capacity}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.Capacity = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_set",{component.Capacity}),client,Color(255,0,255,255))
    if component.Charge > component.Capacity then
        component.Charge = component.Capacity
    end
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_warn",{component.Capacity}),client,Color(255,0,128,255))
end)

-- PowerTransfer
newAction("PowerTransfer", "can_overload", "Toggles damage from overload",function (client, item, component, args)
    if args[1] == nil then
        component.CanBeOverloaded = not component.CanBeOverloaded
    elseif args[1] == "true" then
        component.CanBeOverloaded = true
    elseif args[1] == "false" then
        component.CanBeOverloaded = false
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),client,Color(255,0,0,255))
        return
    end

    if component.CanBeOverloaded then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_canoverload_on"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_canoverload_off"),client,Color(255,0,255,255))
    end
end)

newAction("PowerTransfer", "overload_voltage", "How much power need to be supplied to overload. e.x: 2 means twice more than grid load",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_overloadvoltage_info",{component.OverloadVoltage}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.OverloadVoltage = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_overloadvoltage_set",{component.OverloadVoltage}),client,Color(255,0,255,255))
end)











-- ITEM EDIT MOST COOLEST COMMAND !!!
GMT.AddCommand("itemedit",GMT.Lang("Help_ItemEdit"),false,function(client,cursor,args)
    if #args == 0 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_id"),client,Color(255,0,0,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = GMT.GetItemByID(id)
    if item == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),client,Color(255,0,0,255))
        return
    end

    -- Get component
    if args[2] == nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_ItemEdit_c_header",{item.Prefab.Identifier.Value,item.ID}),client,Color(255,0,128,255))
        for i, component in ipairs(item.Components) do
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemEdit_c_element",{i,component.Name}),client,Color(255,255,255,255))
        end
    else
        local index = tonumber(args[2])
        if id == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_badindex"),client,Color(255,0,0,255))
            return
        end
        if item.Components[index] == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_outofrange"),client,Color(255,0,0,255))
            return
        end

        local category = item.Components[index].Name
        if actions[category] == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_noactions"),client,Color(255,0,0,255))
            return
        end
        
        -- Checking action
        if args[3] == nil then
            GMT.SendConsoleMessage(GMT.Lang("CMD_ItemEdit_act_header",{category}),client,Color(255,0,128,255))
            for k, act in pairs(actions[category]) do
                GMT.SendConsoleMessage(GMT.Lang("CMD_ItemEdit_act_element",{k,act.help}),client,Color(255,255,255,255))
            end
            return
        end

        local action = string.lower(args[3])
        if actions[category][action] == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_badaction"),client,Color(255,0,0,255))
            return
        end

        local func = actions[category][action].func
        local a_args = {}
        for i = 4, #args, 1 do
            table.insert(a_args, args[i])
        end
        --(client, item, component, args)
        func(client, item, item.Components[index], a_args)
    end
end,{
{name="id",desc=GMT.Lang("Args_ItemEdit_id")},
{name="index",desc=GMT.Lang("Args_ItemEdit_component")},
{name="action",desc=GMT.Lang("Args_ItemData_action")},
{name="args",desc=GMT.Lang("Args_ItemData_args")}})