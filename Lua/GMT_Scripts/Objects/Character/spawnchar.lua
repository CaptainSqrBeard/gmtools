local functionArgs = {}

local function newArg(id, func, help, args)
    if help == nil then
        help = "CMD_SpawnChar_no_description"
    end
    functionArgs[id] = {func=func, help = help, args = args}
end


GMT.AddCommand("spawnchar",GMT.Lang("Help_SpawnChar"),true,nil,{
{name="id",desc=GMT.Lang("Args_SpawnChar_id")},
{name="args",desc=GMT.Lang("Args_SpawnChar_args"),optional=true}
})

GMT.AssignSharedCommand("spawnchar",function (args, interface)
    if #args < 1 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments").."\n"..GMT.GetCommandUsageHelp("spawnchar"),Color(255,0,0,255))
        return
    end

    if args[1] == "-help" or args[1] == "-h" then
        interface.showMessage(GMT.Lang("CMD_SpawnChar_help_header"),Color(255,0,255,255))
        for k, arg in pairs(functionArgs) do
            if arg.args ~= nil then
                interface.showMessage(GMT.Lang("CMD_SpawnChar_help_entry", {k, arg.args, GMT.Lang(arg.help)}),Color(255,255,255,255))
            else
                interface.showMessage(GMT.Lang("CMD_SpawnChar_help_entry_no_args", {k, GMT.Lang(arg.help)}),Color(255,255,255,255))
            end
        end
        return
    end

    -- Prepare info
    local id = args[1]
    local prefab = CharacterPrefab.FindBySpeciesName(id)
    local info_prefab = prefab
    local character_info = nil
    if prefab == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_species", {id}),Color(255,0,128,255))
        return
    end
    if id == "human" then
        character_info = CharacterInfo(CharacterPrefab.HumanSpeciesName)
    elseif id == "humanhusk" then
        character_info = CharacterInfo(CharacterPrefab.HumanSpeciesName)
        info_prefab = CharacterPrefab.FindBySpeciesName(CharacterPrefab.HumanSpeciesName)
    end
    local info = {prevent_spawn=false, id=id, prefab=prefab, info_prefab=info_prefab, character_info=character_info, pos=interface.cursor, seed="0", post_actions={}}

    -- Check if any arguments are present
    if #args > 1 then
        -- Check if first argument is a header of argument
        local first_sym = string.sub(args[2], 1, 1)
        if first_sym ~= "-" then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_bad_beginning"),Color(255,0,128,255))
            return
        end

        local spawn_args = {}
        local last_arg = {func = nil, sub_args = {}}
        local arg_string = string.sub(args[2], 2, #args[2])
        
        if functionArgs[arg_string] == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_argument", {arg_string}),Color(255,0,128,255))
            return
        end

        last_arg.func = functionArgs[arg_string].func

        -- Look for arguments
        for i = 3, #args, 1 do
            if string.sub(args[i], 1, 1) == "-" then
                -- Put argument into table of arguments and reset it
                spawn_args[#spawn_args+1] = last_arg
                local arg_string_loop = string.sub(args[i], 2, #args[i])
                if functionArgs[arg_string_loop] == nil then
                    interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_argument", {arg_string_loop}),Color(255,0,128,255))
                    return
                end
                last_arg = {func = functionArgs[arg_string_loop].func, sub_args = {}}
            else
                -- Add sub argument into argument
                last_arg.sub_args[#last_arg.sub_args+1] = args[i]
            end
            if i == #args then
                spawn_args[#spawn_args+1] = last_arg
            end
        end

        -- Execute arguments
        for i, arg in ipairs(spawn_args) do
            --print(tostring(arg).." "..arg.sub_args[1])
            arg.func(info, arg.sub_args, interface)

            if info == nil or info.prevent_spawn then
                interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_spawn_cancelled"),Color(255,231,0,255))
                return
            end
        end
    end

    -- Spawn
    if not info.prevent_spawn then
        if info.pos == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_no_pos"),Color(255,231,0,255))
            return
        end
        local char = Character.Create(info.prefab, info.pos, info.seed, info.character_info, 0, false, true, true, nil, true)

        for i, action in ipairs(info.post_actions) do
            action(char)
        end

        interface.showMessage(GMT.Lang("CMD_SpawnChar_result", {char.Name, char.ID}),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_spawn_cancelled"),Color(255,231,0,255))
    end
end)

newArg("name", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"name", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"name", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Set name
    info.character_info.Name = args[1]
    info.name_overriden = true
end, "CMD_SpawnChar_desc_name", "<name>")


newArg("addhumaninfo", function (info, args, interface)
    info.character_info = CharacterInfo("human")
end, "CMD_SpawnChar_desc_addhumandata")


newArg("hairtype", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if not GMT.InRange(index, 1, #info.character_info.Hairs) then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_OutOfRange", {'1', #info.character_info.Hairs})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.HairIndex = index
end, "CMD_SpawnChar_desc_hairtype", "<id>")


newArg("beardtype", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if not GMT.InRange(index, 1, #info.character_info.Beards) then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_OutOfRange", {'1', #info.character_info.Beards})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.BeardIndex = index
end, "CMD_SpawnChar_desc_beardtype", "<id>")


newArg("accessorytype", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"accessorytype", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"accessorytype", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"accessorytype", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if not GMT.InRange(index, 1, #info.character_info.FaceAttachments) then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"accessorytype", GMT.Lang("Error_OutOfRange", {'1', #info.character_info.FaceAttachments})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.FaceAttachmentIndex = index
end, "CMD_SpawnChar_desc_accessorytype", "<id>")


newArg("moustachetype", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if not GMT.InRange(index, 1, #info.character_info.Moustaches) then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_OutOfRange", {'1', #info.character_info.Moustaches})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.MoustacheIndex = index
end, "CMD_SpawnChar_desc_moustachetype", "<id>")

newArg("headtype", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 1 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("Error_OutOfRange_Less", {'1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get head element
    local attribute = info.info_prefab.ConfigElement.GetChildElement('Heads')
    local headElement
    local i = 0

    if attribute == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("CMD_SpawnChar_no_heads")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    for head in attribute.Elements() do
        i = i + 1
        if i == index then
            headElement = head
            break
        end
    end

    if i ~= index then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"headtype", GMT.Lang("Error_OutOfRange", {'1', i})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get head preset
    local headPreset = CharacterInfo.HeadPreset(info.prefab.CharacterInfoPrefab, headElement)

    -- Replace the entire head info to change head preset (because head preset is read-only 🖕)
    local oldHeadInfo = info.character_info.Head
    
    info.character_info.Head = CharacterInfo.HeadInfo(
        info.character_info,
        headPreset,
        oldHeadInfo.HairIndex,
        oldHeadInfo.BeardIndex,
        oldHeadInfo.MoustacheIndex,
        oldHeadInfo.FaceAttachmentIndex
    )
    info.character_info.Head.SkinColor = oldHeadInfo.SkinColor
    info.character_info.Head.HairColor = oldHeadInfo.HairColor
    info.character_info.Head.FacialHairColor = oldHeadInfo.FacialHairColor

    -- If name is not overriden, make a new one
    if not info.name_overriden then
        info.character_info.Name = info.character_info.GetRandomName(RandSync.Unsynced)
    end
end, "CMD_SpawnChar_desc_headtype", "<id>")

newArg("skincolor", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    elseif #args == 1 then
        local index = tonumber(args[1])
        if index == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end
        
        local attribute = info.info_prefab.ConfigElement.GetAttribute('skincolors')
        if attribute == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("CMD_SpawnChar_no_color_skin")}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local data = GMT.ParseTupleArray(attribute.Value, {"#ffffff", 100})
        if not GMT.InRange(index, 1, #data) then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_OutOfRange", {'1', #data})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local new_color = GMT.ParseHexColor(string.sub(data[index][1], 2))
        if new_color == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
        else
            info.character_info.Head.SkinColor = GMT.ParseHexColor(string.sub(data[index][1], 2))
        end
        
        return
    elseif #args > 1 and #args <= 3 then
        ---- Color assembly
        info.character_info.Head.SkinColor = GMT.ColorFromStrings(args[1], args[2], args[3])
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
end, "CMD_SpawnChar_desc_skincolor", "<id> | <r> <g> <b>")

newArg("haircolor", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    elseif #args == 1 then
        local index = tonumber(args[1])
        if index == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end
        
        local attribute = info.info_prefab.ConfigElement.GetAttribute('haircolors')
        if attribute == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("CMD_SpawnChar_no_color_hair")}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local data = GMT.ParseTupleArray(attribute.Value, {"#ffffff", 100})
        if not GMT.InRange(index, 1, #data) then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("Error_OutOfRange", {'1', #data})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local new_color = GMT.ParseHexColor(string.sub(data[index][1], 2))
        if new_color == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
        else
            info.character_info.Head.HairColor = GMT.ParseHexColor(string.sub(data[index][1], 2))
        end
        
        return
    elseif #args > 1 and #args <= 3 then
        ---- Color assembly
        info.character_info.Head.HairColor = GMT.ColorFromStrings(args[1], args[2], args[3])
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"haircolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
end, "CMD_SpawnChar_desc_haircolor", "<id> | <r> <g> <b>")

newArg("beardcolor", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    elseif #args == 1 then
        local index = tonumber(args[1])
        if index == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("Error_BadArgument", {'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end
        
        local attribute = info.info_prefab.ConfigElement.GetAttribute('facialhaircolors')
        if attribute == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("CMD_SpawnChar_no_color_facial_hair")}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local data = GMT.ParseTupleArray(attribute.Value, {"#ffffff", 100})
        if not GMT.InRange(index, 1, #data) then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("Error_OutOfRange", {'1', #data})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local new_color = GMT.ParseHexColor(string.sub(data[index][1], 2))
        if new_color == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
            info.prevent_spawn = true
        else
            info.character_info.Head.FacialHairColor = GMT.ParseHexColor(string.sub(data[index][1], 2))
        end
        
        return
    elseif #args > 1 and #args <= 3 then
        ---- Color assembly
        info.character_info.Head.FacialHairColor = GMT.ColorFromStrings(args[1], args[2], args[3])
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardcolor", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
end, "CMD_SpawnChar_desc_beardcolor", "<id> | <r> <g> <b>")


newArg("ai_seed", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"seed", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.seed = args[1] 
end, "CMD_SpawnChar_desc_ai_seed", "<seed>")


newArg("pos", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"pos", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    if args[1] == "cursor" then
        if interface.cursor == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"pos", GMT.Lang("CMD_SpawnChar_no_cursor")}),Color(255,0,0,255))
            return
        end
        info.cursor = interface.cursor
    else
        local vector2 = GMT.GetVector2FromString(args[2])
        if vector2 == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"pos", GMT.Lang("CMD_SpawnChar_unknown_type")}),Color(255,0,0,255))
            return
        else
            info.position = vector2
        end
    end
end, "CMD_SpawnChar_desc_pos", "<cursor/x;y>")


newArg("jobloadout", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"jobloadout", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get job
    local jobPrefab = GMT.GetJobPrefab(args[1])
    if jobPrefab == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"jobloadout", GMT.Lang("Error_UnknownJob")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    
    -- Get variant
    local variant = 0
    if args[2] ~= nil then
        variant = tonumber(args[2])
        if variant == nil then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"jobloadout", GMT.Lang("Error_BadArgument",{'#2'})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end

        local count = #jobPrefab.ItemSets
        if not GMT.InRange(variant, 0, count) then
            interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"jobloadout", GMT.Lang("Error_OutOfRange", {'0', count})}),Color(255,0,0,255))
            info.prevent_spawn = true
            return
        end
    end

    local job = Job(jobPrefab)
    job.Variant = variant
    
    table.insert(info.post_actions, function (char)
        job.GiveJobItems(char)
    end)
end, "CMD_SpawnChar_desc_jobloadout", "<job_id> [variant]")


newArg("job", function (info, args, interface)
    -- Check for character data
    if info.character_info == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"job", GMT.Lang("CMD_SpawnChar_no_character_info")}),Color(255,231,0,255))
        return
    end

    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"job", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get job
    local jobPrefab = GMT.GetJobPrefab(args[1])
    if jobPrefab == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"job", GMT.Lang("Error_UnknownJob")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    local job = Job(jobPrefab)
    
    info.character_info.Job = job
end, "CMD_SpawnChar_desc_job", "<job_id>")


newArg("team", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"team", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    local team = tonumber(args[1])
    if team == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"team", GMT.Lang("Error_BadArgument",{'#1'})}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    if info.character_info == nil then
        table.insert(info.post_actions, function (char)
            char.TeamID = team
        end)
    else
        info.character_info.TeamID = team
    end
end, "CMD_SpawnChar_desc_team", "<team_id>")

newArg("cancel", function (info, args, interface)
    info.prevent_spawn = true
end, "CMD_SpawnChar_desc_cancel")

    --[[
        args of methods to spawn entities

        Identifier speciesName,
        Vector2 position,
        string seed,
        CharacterInfo characterInfo = null,
        ushort id = Entity.NullEntityID,
        bool isRemotePlayer = false,
        bool hasAi = true,
        bool createNetworkEvent = true, 
        RagdollParams ragdoll = null,
        bool throwErrorIfNotFound = true,
        bool spawnInitialItems = true)

        CharacterPrefab prefab,
        Vector2 position,
        string seed,
        CharacterInfo characterInfo = null,
        ushort id = Entity.NullEntityID,
        bool isRemotePlayer = false,
        bool hasAi = true,
        bool createNetworkEvent = true,
        RagdollParams ragdoll = null,
        bool spawnInitialItems = true)
    ]]