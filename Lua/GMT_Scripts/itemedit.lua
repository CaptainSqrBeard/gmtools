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
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_warn"),client,Color(255,0,128,255))
    item.CreateServerEvent(component, component)
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

-- Engine
newAction("Engine", "force", "Changes current force",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_force_info",{component.Force}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.Force = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_force_set",{component.Force}),client,Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Engine", "max_force", "Changes max force",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_maxforce_info",{component.MaxForce}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.MaxForce = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_maxforce_set",{component.MaxForce}),client,Color(255,0,255,255))
end)

-- Deconstructor
newAction("Deconstructor", "speed", "Speed multiplier for deconstructing",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_info",{component.DeconstructionSpeed}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.DeconstructionSpeed = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_set",{component.DeconstructionSpeed}),client,Color(255,0,255,255))
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_warn"),client,Color(255,0,128,255))
    item.CreateServerEvent(component, component)
end)

-- OxygenGenerator
newAction("Fabricator", "skill", "Skill requirment multiplier for crafting (Medium desync)",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_info",{component.SkillRequirementMultiplier}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.SkillRequirementMultiplier = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_set",{component.SkillRequirementMultiplier}),client,Color(255,0,255,255))
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_warn"),client,Color(255,0,128,255))
end)

-- OxygenGenerator
newAction("OxygenGenerator", "produce", "How much oxygen will produce generator",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_OxygenGenerator_produce_info",{component.GeneratedAmount}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.GeneratedAmount = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_OxygenGenerator_produce_set",{component.GeneratedAmount}),client,Color(255,0,255,255))
end)

-- Pump
newAction("Pump", "maxflow", "How fast the item can pump water (Medium desync)",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_info",{component.MaxFlow}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.MaxFlow = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_set",{component.MaxFlow}),client,Color(255,0,255,255))
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_warn"),client,Color(255,0,128,255))
end)

newAction("Pump", "percentage", "How hard pump will work in percentages",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_percentage_info",{component.FlowPercentage}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.FlowPercentage = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_percentage_set",{component.FlowPercentage}),client,Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

-- Reactor
newAction("Reactor", "toggle", "Enables/Disables Reactor",function (client, item, component, args)
    if args[1] == nil then
        component.PowerOn = not component.PowerOn
    elseif args[1] == "true" then
        component.PowerOn = true
    elseif args[1] == "false" then
        component.PowerOn = false
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),client,Color(255,0,0,255))
        return
    end

    if component.PowerOn then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_toggle_on"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_toggle_off"),client,Color(255,0,255,255))
    end
    item.CreateServerEvent(component, component)
end)
newAction("Reactor", "auto", "Enables/Disables Reactor Automatic Control",function (client, item, component, args)
    if args[1] == nil then
        component.AutoTemp = not component.AutoTemp
    elseif args[1] == "true" then
        component.AutoTemp = true
    elseif args[1] == "false" then
        component.AutoTemp = false
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),client,Color(255,0,0,255))
        return
    end

    if component.AutoTemp then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_auto_on"),client,Color(255,0,255,255))
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_auto_off"),client,Color(255,0,255,255))
    end
    item.CreateServerEvent(component, component)
end)
newAction("Reactor", "maxpower", "How much power the reactor generates when operating at full capacity.",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_maxpower_info",{component.MaxPowerOutput}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.MaxPowerOutput = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_maxpower_set",{component.MaxPowerOutput}),client,Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "meltdown_delay", "How long the temperature has to stay critical until a meltdown occurs.",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_meltdowndelay_info",{component.MeltdownDelay}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.MeltdownDelay = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_meltdowndelay_set",{component.MeltdownDelay}),client,Color(255,0,255,255))
end)

newAction("Reactor", "fire_delay", "How long the temperature has to stay critical until the reactor catches fire.",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_firedelay_info",{component.FireDelay}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.FireDelay = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_firedelay_set",{component.FireDelay}),client,Color(255,0,255,255))
end)

newAction("Reactor", "fission", "Current fission rate of the reactor",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_info",{component.FissionRate}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.FissionRate = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_set",{component.FissionRate}),client,Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "turbine", "Current turbine output of the reactor",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_turbineoutput_info",{component.TurbineOutput}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.TurbineOutput = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_turbineoutput_set",{component.TurbineOutput}),client,Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "fuelrate", "How fast the condition of the contained fuel rods deteriorates per second.",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fuelrate_info",{component.FuelConsumptionRate}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.FuelConsumptionRate = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fuelrate_set",{component.FuelConsumptionRate}),client,Color(255,0,255,255))
end)

-- Vent
newAction("Vent", "oxygen", "Amount of oxygen in vent",function (client, item, component, args)
    if args[1] == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Vent_oxygen_info",{component.OxygenFlow}),client,Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_bad_value"),client,Color(255,0,0,255))
        return
    end
    component.OxygenFlow = number
    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Vent_oxygen_set",{component.OxygenFlow}),client,Color(255,0,255,255))
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