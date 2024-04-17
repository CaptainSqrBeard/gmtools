local functionArgs = {}

local function newArg(id, func, help, args)
    if help == nil then
        help = "CMD_SpawnChar_no_description"
    end
    functionArgs[id] = {func=func, help = help, args = args}
end


GMT.AddCommand("spawnchar",GMT.Lang("Help_SpawnChar"),true,nil,{
{name="id",desc=GMT.Lang("Args_SpawnChar_id")}})


GMT.AssignClientCommand("spawnchar",function(client,cursor,args)
    if #args < 1 then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    if args[1] == "-help" or args[1] == "-h" then
        GMT.SendConsoleMessage(GMT.Lang("CMD_SpawnChar_help_header"),client,Color(255,0,255,255))
        for k, arg in pairs(functionArgs) do
            if arg.args ~= nil then
                GMT.SendConsoleMessage(GMT.Lang("CMD_SpawnChar_help_entry", {k, arg.args, GMT.Lang(arg.help)}),client,Color(255,255,255,255))
            else
                GMT.SendConsoleMessage(GMT.Lang("CMD_SpawnChar_help_entry_no_args", {k, GMT.Lang(arg.help)}),client,Color(255,255,255,255))
            end
        end
        return
    end

    -- Prepare info
    local id = args[1]
    local prefab = CharacterPrefab.FindBySpeciesName(id)
    local character_info = nil
    if prefab == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_species"),client,Color(255,0,128,255))
        return
    end
    if id == "humanhusk" or id == "human" then
        character_info = CharacterInfo(CharacterPrefab.HumanSpeciesName)
    end
    local info = {prevent_spawn=false, id=id, prefab=prefab, character_info=character_info, pos=cursor, seed="0", post_actions={}}

    -- Check if any arguments are present
    if #args > 1 then
        -- Check if first argument is a header of argument
        local first_sym = string.sub(args[2], 1, 1)
        if first_sym ~= "-" then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_bad_beginning"),client,Color(255,0,128,255))
            return
        end

        local spawn_args = {}
        local last_arg = {func = nil, sub_args = {}}
        local arg_string = string.sub(args[2], 2, #args[2])
        last_arg.func = functionArgs[arg_string].func
        if last_arg.func == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_argument", {arg_string}),client,Color(255,0,128,255))
            return
        end
        spawn_args[1] = last_arg

        -- Look for arguments
        for i = 3, #args, 1 do
            if string.sub(args[i], 1, 1) == "-" then
                -- Put argument into table of arguments and reset it
                spawn_args[#spawn_args+1] = last_arg
                local arg_string_loop = string.sub(args[i], 2, #args[i])
                last_arg = {func = functionArgs[arg_string_loop].func, sub_args = {}}
                if last_arg.func == nil then
                    GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_argument", {arg_string_loop}),client,Color(255,0,128,255))
                    return
                end
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
            local temp_info = arg.func(info, arg.sub_args, client)
            if temp_info ~= nil then
                info = temp_info
            end
            if info.prevent_spawn then
                GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_spawn_cancelled"),client,Color(255,231,0,255))
                return
            end
        end
    end

    -- Spawn
    if not info.prevent_spawn then
        --Character.Create(info.id, info.pos, info.seed, info.character_info, 0, false, true, true, nil, true, true)
        local char = Character.Create(info.prefab, info.pos, info.seed, info.character_info, 0, false, true, true, nil, true)
        --Entity.Spawner.AddCharacterToSpawnQueue(info.id, info.pos, info.character_info, nil)

        for i, action in ipairs(info.post_actions) do
            
        end
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_spawn_cancelled"),client,Color(255,231,0,255))
    end
end)

GMT.AssignServerCommand("spawnchar",function(args)
    
end)


newArg("name", function (input_info, args, client)
    local info = input_info

    -- Check for character data
    if info.character_info == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"name", GMT.Lang("CMD_SpawnChar_no_character_info")}),client,Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"name", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Set name
    info.character_info.Name = args[1]
    return info
end, "CMD_SpawnChar_desc_name", "<name>")


newArg("addhumaninfo", function (input_info, args, client)
    local info = input_info
    info.character_info = CharacterInfo("human")
    return info
end, "CMD_SpawnChar_desc_addhumandata")


newArg("hairtype", function (input_info, args, client)
    local info = input_info

    -- Check for character data
    if info.character_info == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("CMD_SpawnChar_no_character_info")}),client,Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_BadArgument")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Hairs then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_OutOfRange")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.HairIndex = index

    return info
end, "CMD_SpawnChar_desc_hairtype", "<index>")


newArg("beardtype", function (input_info, args, client)
    local info = input_info

    -- Check for character data
    if info.character_info == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("CMD_SpawnChar_no_character_info")}),client,Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_BadArgument")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Beards then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_OutOfRange")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.BeardIndex = index

    return info
end, "CMD_SpawnChar_desc_beardtype", "<index>")


newArg("moustachetype", function (input_info, args, client)
    local info = input_info

    -- Check for character data
    if info.character_info == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("CMD_SpawnChar_no_character_info")}),client,Color(255,231,0,255))
        return
    end

    -- Check for arguments
    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    -- Get index
    local index = tonumber(args[1])
    if index == nil then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_BadArgument")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Moustaches then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_OutOfRange")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.MoustacheIndex = index

    return info
end, "CMD_SpawnChar_desc_moustachetype", "<index>")


newArg("skincolor", function (input_info, args, client)
    local info = input_info

    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    elseif #args == 1 then
        -- TODO Index
    elseif #args > 1 and #args <= 3 then
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

        info.character_info.Head.SkinColor = Color(r, g, b, 255)
        return info
    else
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_BadArgument")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    for color in info.character_info.SkinColors do
        print(color)
    end
end, "CMD_SpawnChar_desc_skincolor", "<index> | <r> <g> <b>")


newArg("seed", function (input_info, args, client)
    local info = input_info

    if #args == 0 then
        GMT.SendPotentiallyServerConsoleMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"seed", GMT.Lang("Error_NotEnoughArguments")}),client,Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.seed = args[1]
    return info
end, "CMD_SpawnChar_desc_seed", "<seed>")


newArg("cancel", function (input_info, args, client)
    local info = input_info
    info.prevent_spawn = true
    return info
end)

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