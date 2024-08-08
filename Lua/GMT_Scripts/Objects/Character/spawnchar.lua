local functionArgs = {}

local function newArg(id, func, help, args)
    if help == nil then
        help = "CMD_SpawnChar_no_description"
    end
    functionArgs[id] = {func=func, help = help, args = args}
end


GMT.AddCommand("spawnchar",GMT.Lang("Help_SpawnChar"),true,nil,{
{name="id",desc=GMT.Lang("Args_SpawnChar_id")}})

GMT.AssignSharedCommand("spawnchar",function (args, interface)
    if #args < 1 then
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
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
    local character_info = nil
    if prefab == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_error_unknown_species"),Color(255,0,128,255))
        return
    end
    if id == "humanhusk" or id == "human" then
        character_info = CharacterInfo(CharacterPrefab.HumanSpeciesName)
    end
    local info = {prevent_spawn=false, id=id, prefab=prefab, character_info=character_info, pos=interface.cursor, seed="0", post_actions={}}

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
        spawn_args[1] = last_arg

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
            action()
        end
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
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_BadArgument")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Hairs then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"hairtype", GMT.Lang("Error_OutOfRange")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.HairIndex = index
end, "CMD_SpawnChar_desc_hairtype", "<index>")


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
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_BadArgument")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Beards then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"beardtype", GMT.Lang("Error_OutOfRange")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.BeardIndex = index
end, "CMD_SpawnChar_desc_beardtype", "<index>")


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
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_BadArgument")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Moustaches then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_OutOfRange")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.MoustacheIndex = index
end, "CMD_SpawnChar_desc_moustachetype", "<index>")

newArg("headtype", function (info, args, interface)
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
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_BadArgument")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end
    index = math.floor(index)

    -- Check range
    if index < 0 or index+1 > #info.character_info.Moustaches then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"moustachetype", GMT.Lang("Error_OutOfRange")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.character_info.Head.MoustacheIndex = index
end, "CMD_SpawnChar_desc_headtype", "<index>")

newArg("skincolor", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
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
    else
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"skincolor", GMT.Lang("Error_BadArgument")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    for color in ipairs(info.character_info.SkinColors) do
        print(color)
    end
end, "CMD_SpawnChar_desc_skincolor", "<index> | <r> <g> <b>")

newArg("seed", function (info, args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_SpawnChar_in_argument",{"seed", GMT.Lang("Error_NotEnoughArguments")}),Color(255,0,0,255))
        info.prevent_spawn = true
        return
    end

    info.seed = args[1] 
end, "CMD_SpawnChar_desc_seed", "<seed>")


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


newArg("cancel", function (info, args, interface)
    info.prevent_spawn = true
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