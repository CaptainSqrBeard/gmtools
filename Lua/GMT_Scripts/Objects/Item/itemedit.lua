local actions = {}

local function newAction(component,name,helpstring,func)
    if actions[component] == nil then
        actions[component] = {}
    end
    actions[component][name] = {help=helpstring,func=func}
end


-- Door
newAction("Door", "open", "Opens or closes door",function (interface, item, component, args)
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
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),Color(255,0,255,255))
    end
end)

-- Quality
newAction("Quality", "level", GMT.Lang("CMD_ItemEdit_Quality_level_Help"),function (interface, item, component, args)
    --QualityLevel
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_info",{component.QualityLevel,component.MaxQuality}),Color(255,0,128,255))
    else
        local level = tonumber(args[1])
        if level == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_badlevel"),Color(255,0,255,255))
            return
        end
        if level < 0 or level > component.MaxQuality then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_outofrange"),Color(255,0,255,255))
            return
        end
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Quality_level_warn"),Color(255,128,0,255))
        component.QualityLevel = level
    end
end)

--[[
newAction("Holdable", "list", "test",function (interface, item, component, args)
    for k, val in pairs(item.SerializableProperties) do
        print(k)
    end
end)
]]

-- Holdable
newAction("Holdable", "pick", GMT.Lang("CMD_ItemEdit_Holdable_pick_Help"),function (interface, item, component, args)
    local char = GMT.GetCharacterByString(args[1])
    if char == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_CharacterNotFound"),Color(255,0,255,255))
        return
    end
    component.Pick(char)
end)

newAction("Holdable", "attach", GMT.Lang("CMD_ItemEdit_Holdable_attach_Help"),function (interface, item, component, args)
    if not component.Attachable then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_unable"),Color(255,0,255,255))
        return
    end
    if not component.Attached then
        component.AttachToWall()
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_attached"),Color(255,0,255,255))
    else
        component.DeattachFromWall()
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Holdable_attach_deattached"),Color(255,0,255,255))
    end
end)


-- PowerContainer
newAction("PowerContainer", "power", GMT.Lang("CMD_ItemEdit_PowerContainer_power_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_power_info",{component.Charge,component.Capacity}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.Charge = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_power_set",{component.Charge,component.Capacity}),Color(255,0,255,255))
        
end)

newAction("PowerContainer", "capacity", GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_info",{component.Capacity}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.Capacity = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_set",{component.Capacity}),Color(255,0,255,255))
    if component.Charge > component.Capacity then
        component.Charge = component.Capacity
    end
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerContainer_capacity_warn"),Color(255,0,128,255))
    item.CreateServerEvent(component, component)
end)

-- PowerTransfer
newAction("PowerTransfer", "can_overload", GMT.Lang("CMD_ItemEdit_PowerTransfer_canoverload_Help"),function (interface, item, component, args)
    if args[1] == nil then
        component.CanBeOverloaded = not component.CanBeOverloaded
    elseif args[1] == "true" then
        component.CanBeOverloaded = true
    elseif args[1] == "false" then
        component.CanBeOverloaded = false
    else
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),Color(255,0,255,255))
        return
    end

    if component.CanBeOverloaded then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_canoverload_on"),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_PowerTransfer_canoverload_off"),Color(255,0,255,255))
    end
end)

-- Engine
newAction("Engine", "force", GMT.Lang("CMD_ItemEdit_Engine_force_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_force_info",{component.Force}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.Force = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_force_set",{component.Force}),Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Engine", "max_force", GMT.Lang("CMD_ItemEdit_Engine_maxforce_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_maxforce_info",{component.MaxForce}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.MaxForce = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Engine_maxforce_set",{component.MaxForce}),Color(255,0,255,255))
end)

-- Deconstructor
newAction("Deconstructor", "speed", GMT.Lang("CMD_ItemEdit_Deconstructor_speed_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_info",{component.DeconstructionSpeed}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.DeconstructionSpeed = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_set",{component.DeconstructionSpeed}),Color(255,0,255,255))
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Deconstructor_speed_warn"),Color(255,0,128,255))
    item.CreateServerEvent(component, component)
end)

-- Fabricator
newAction("Fabricator", "skill", GMT.Lang("CMD_ItemEdit_Fabricator_skill_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_info",{component.SkillRequirementMultiplier}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.SkillRequirementMultiplier = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_set",{component.SkillRequirementMultiplier}),Color(255,0,255,255))
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Fabricator_skill_warn"),Color(255,0,128,255))
end)

-- OxygenGenerator
newAction("OxygenGenerator", "produce", GMT.Lang("CMD_ItemEdit_OxygenGenerator_produce_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_OxygenGenerator_produce_info",{component.GeneratedAmount}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.GeneratedAmount = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_OxygenGenerator_produce_set",{component.GeneratedAmount}),Color(255,0,255,255))
end)

-- Pump
newAction("Pump", "maxflow", GMT.Lang("CMD_ItemEdit_Pump_maxflow_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_info",{component.MaxFlow}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.MaxFlow = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_set",{component.MaxFlow}),Color(255,0,255,255))
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_maxflow_warn"),Color(255,0,128,255))
end)

newAction("Pump", "percentage", GMT.Lang("CMD_ItemEdit_Pump_percentage_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_percentage_info",{component.FlowPercentage}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.FlowPercentage = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Pump_percentage_set",{component.FlowPercentage}),Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

-- Reactor
newAction("Reactor", "toggle", GMT.Lang("CMD_ItemEdit_Reactor_toggle_Help"),function (interface, item, component, args)
    if args[1] == nil then
        component.PowerOn = not component.PowerOn
    elseif args[1] == "true" then
        component.PowerOn = true
    elseif args[1] == "false" then
        component.PowerOn = false
    else
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),Color(255,0,255,255))
        return
    end

    if component.PowerOn then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_toggle_on"),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_toggle_off"),Color(255,0,255,255))
    end
    item.CreateServerEvent(component, component)
end)
newAction("Reactor", "auto", GMT.Lang("CMD_ItemEdit_Reactor_auto_Help"),function (interface, item, component, args)
    if args[1] == nil then
        component.AutoTemp = not component.AutoTemp
    elseif args[1] == "true" then
        component.AutoTemp = true
    elseif args[1] == "false" then
        component.AutoTemp = false
    else
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),Color(255,0,255,255))
        return
    end

    if component.AutoTemp then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_auto_on"),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_auto_off"),Color(255,0,255,255))
    end
    item.CreateServerEvent(component, component)
end)
newAction("Reactor", "maxpower", GMT.Lang("CMD_ItemEdit_Reactor_maxpower_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_maxpower_info",{component.MaxPowerOutput}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.MaxPowerOutput = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_maxpower_set",{component.MaxPowerOutput}),Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "meltdown_delay", GMT.Lang("CMD_ItemEdit_Reactor_meltdowndelay_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_meltdowndelay_info",{component.MeltdownDelay}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.MeltdownDelay = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_meltdowndelay_set",{component.MeltdownDelay}),Color(255,0,255,255))
end)

newAction("Reactor", "fire_delay", GMT.Lang("CMD_ItemEdit_Reactor_firedelay_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_firedelay_info",{component.FireDelay}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.FireDelay = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_firedelay_set",{component.FireDelay}),Color(255,0,255,255))
end)

newAction("Reactor", "fission", GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_info",{component.FissionRate}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.FissionRate = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_set",{component.FissionRate}),Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "turbine", GMT.Lang("CMD_ItemEdit_Reactor_fissionrate_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_turbineoutput_info",{component.TurbineOutput}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.TurbineOutput = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_turbineoutput_set",{component.TurbineOutput}),Color(255,0,255,255))
    item.CreateServerEvent(component, component)
end)

newAction("Reactor", "fuelrate", GMT.Lang("CMD_ItemEdit_Reactor_fuelrate_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fuelrate_info",{component.FuelConsumptionRate}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.FuelConsumptionRate = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Reactor_fuelrate_set",{component.FuelConsumptionRate}),Color(255,0,255,255))
end)

-- Vent
newAction("Vent", "oxygen", GMT.Lang("CMD_ItemEdit_Vent_oxygen_Help"),function (interface, item, component, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Vent_oxygen_info",{component.OxygenFlow}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    component.OxygenFlow = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Vent_oxygen_set",{component.OxygenFlow}),Color(255,0,255,255))
end)

-- DockingPort
newAction("DockingPort", "dock", GMT.Lang("CMD_ItemEdit_DockingPort_dock_Help"),function (interface, item, component, args)
    local docked = not component.Docked
    component.Docked = docked
    if component.Docked ~= docked then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_DockingPort_dock_error"),Color(255,0,255,255))
    end
end)

-----------------------

local basicActions = {}
local function newBasicAction(name,helpstring,func)
    basicActions[name] = {help=helpstring,func=func}
end

newBasicAction("condition",GMT.Lang("CMD_ItemEdit_Basic_condition_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_condition_info",{item.Condition}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    item.Condition = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_condition_set",{item.Condition}),Color(255,0,255,255))
end)

newBasicAction("tags",GMT.Lang("CMD_ItemEdit_Basic_tags_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_tags_info",{item.Tags}),Color(255,0,255,255))
        return
    end
    item.Tags = args[1]
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_tags_set",{item.Tags}),Color(255,0,255,255))
    local property = item.SerializableProperties[Identifier("Tags")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

newBasicAction("scale",GMT.Lang("CMD_ItemEdit_Basic_scale_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_scale_info",{item.Scale}),Color(255,0,255,255))
        return
    end
    local number = tonumber(args[1])
    if number == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_value"),Color(255,0,255,255))
        return
    end
    item.Scale = number
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_scale_set",{item.Scale}),Color(255,0,255,255))
    local property = item.SerializableProperties[Identifier("Scale")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

newBasicAction("interactable",GMT.Lang("CMD_ItemEdit_Basic_interactable_Help"),function (interface, item, args)
    if args[1] == nil then
        item.NonInteractable = not item.NonInteractable
    elseif args[1] == "true" then
        item.NonInteractable = false
    elseif args[1] == "false" then
        item.NonInteractable = true
    else
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_boolean"),Color(255,0,255,255))
        return
    end

    if item.NonInteractable then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_interactable_off"),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_interactable_on"),Color(255,0,255,255))
    end

    local property = item.SerializableProperties[Identifier("NonInteractable")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

LuaUserData.MakeMethodAccessible(Descriptors["Barotrauma.Item"], "set_InventoryIconColor")
newBasicAction("color",GMT.Lang("CMD_ItemEdit_Basic_color_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_color_info",{tostring(item.SpriteColor)}),Color(255,0,255,255))
        return
    end
    ---- Color assembly
    -- Red
    local r = tonumber(args[1])
    if r == nil then r = 255 end
    -- Green (or *Saul*)
    local g = tonumber(args[2])
    if g == nil then g = 255 end
    -- Blue
    local b = tonumber(args[3])
    if b == nil then b = 255 end
    -- Alpha
    local a = tonumber(args[4])
    if a == nil then a = 255 end

    local color = Color(r,g,b,a)

    item.SpriteColor = color
    item.set_InventoryIconColor(color)
    
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_color_set",{tostring(item.SpriteColor)}),Color(255,0,255,255))
    local property = item.SerializableProperties[Identifier("SpriteColor")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
    local property = item.SerializableProperties[Identifier("InventoryIconColor")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

newBasicAction("color_inv",GMT.Lang("CMD_ItemEdit_Basic_colorinv_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_colorinv_info",{tostring(item.InventoryIconColor)}),Color(255,0,255,255))
        return
    end
    ---- Color assembly
    -- Red
    local r = tonumber(args[1])
    if r == nil then r = 255 end
    -- Green (or *Saul*)
    local g = tonumber(args[2])
    if g == nil then g = 255 end
    -- Blue
    local b = tonumber(args[3])
    if b == nil then b = 255 end
    -- Alpha
    local a = tonumber(args[4])
    if a == nil then a = 255 end

    local color = Color(r,g,b,a)

    item.set_InventoryIconColor(color)
    
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_colorinv_set",{tostring(item.InventoryIconColor)}),Color(255,0,255,255))
    local property = item.SerializableProperties[Identifier("InventoryIconColor")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

newBasicAction("color_sprite",GMT.Lang("CMD_ItemEdit_Basic_colorsprite_Help"),function (interface, item, args)
    if args[1] == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_colorsprite_info",{tostring(item.SpriteColor)}),Color(255,0,255,255))
        return
    end
    ---- Color assembly
    -- Red
    local r = tonumber(args[1])
    if r == nil then r = 255 end
    -- Green (or *Saul*)
    local g = tonumber(args[2])
    if g == nil then g = 255 end
    -- Blue
    local b = tonumber(args[3])
    if b == nil then b = 255 end
    -- Alpha
    local a = tonumber(args[4])
    if a == nil then a = 255 end

    local color = Color(r,g,b,a)

    item.SpriteColor = color
    
    interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_Basic_colorsprite_set",{tostring(item.SpriteColor)}),Color(255,0,255,255))
    local property = item.SerializableProperties[Identifier("SpriteColor")]
    Networking.CreateEntityEvent(item, Item.ChangePropertyEventData.__new(property, item))
end)

GMT.AddCommand("itemedit",GMT.Lang("Help_ItemEdit"),true,nil,{
{name="id",desc=GMT.Lang("Args_ItemEdit_id")},
{name="component",desc=GMT.Lang("Args_ItemEdit_component"),optional=true},
{name="action",desc=GMT.Lang("Args_ItemEdit_action"),optional=true},
{name="args",desc=GMT.Lang("Args_ItemEdit_args"),optional=true}})

GMT.AssignSharedCommand("itemedit",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments".."\n"..GMT.GetCommandUsageHelp("itemedit")),Color(255,0,0,255))
        return
    end

    local id = tonumber(args[1])
    
    -- Checking ID
    if id == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_bad_id"),Color(255,0,0,255))
        return
    end
    id = math.floor(id)

    -- Searching Item
    local item = GMT.GetItemByID(id)
    if item == nil then
        interface.showMessage("GMTools: "..GMT.Lang("Error_ItemNotFound"),Color(255,0,0,255))
        return
    end

    -- Get component
    if args[2] == nil then
        interface.showMessage(GMT.Lang("CMD_ItemEdit_c_header",{item.Prefab.Identifier.Value,item.ID}),Color(255,0,128,255))
        for i, component in ipairs(item.Components) do
            interface.showMessage(GMT.Lang("CMD_ItemEdit_c_element",{i,component.Name}),Color(255,255,255,255))
        end
        interface.showMessage(GMT.Lang("CMD_ItemEdit_c_basic"),Color(128,128,128,255))
    
    elseif args[2] == "0" or args[2] == "Basic" then
        -- Basic actions
        if args[3] == nil then
            interface.showMessage(GMT.Lang("CMD_ItemEdit_basic_header",{item.Prefab.Identifier.Value, item.ID}),Color(255,0,128,255))
            for k, act in pairs(basicActions) do
                interface.showMessage(GMT.Lang("CMD_ItemEdit_basic_element",{k,act.help}),Color(255,255,255,255))
            end
            return
        end

        local action = string.lower(args[3])
        if basicActions[action] == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_badaction"),Color(255,0,0,255))
            return
        end

        local func = basicActions[action].func
        local a_args = {}
        for i = 4, #args, 1 do
            table.insert(a_args, args[i])
        end
        --(interface, item, args)
        func(interface, item, a_args)

    else
        local index = tonumber(args[2])
        if index ~= nil then index = math.floor(index) end
        local component
        -- Try get component by Index
        if item.Components[index] ~= nil then
            component = item.Components[index]
        -- Try get component by Name
        elseif item.GetComponentString(args[2]) ~= nil then
            component = item.GetComponentString(args[2])
        else
            -- Component not found
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_nocomponent"),Color(255,0,0,255))
            return
        end

        local category = component.Name
        if actions[category] == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_noactions"),Color(255,0,0,255))
            return
        end
        
        -- Checking action
        if args[3] == nil then
            interface.showMessage(GMT.Lang("CMD_ItemEdit_act_header",{category}),Color(255,0,128,255))
            for k, act in pairs(actions[category]) do
                interface.showMessage(GMT.Lang("CMD_ItemEdit_act_element",{k,act.help}),Color(255,255,255,255))
            end
            return
        end

        local action = string.lower(args[3])
        if actions[category][action] == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_ItemEdit_badaction"),Color(255,0,0,255))
            return
        end

        local func = actions[category][action].func
        local a_args = {}
        for i = 4, #args, 1 do
            table.insert(a_args, args[i])
        end
        --(interface, item, component, args)
        func(interface, item, component, a_args)
    end
end)