function GMT.NewConsoleMessage(msg, color)
    DebugConsole.NewMessage(msg, color)
end

function GMT.ThrowError(text,level)
    if level == nil then level = 0 end
    error("GM-Tools Error: "..text,3+level)
end

function GMT.SendConsoleMessage(text,client,color)
    local msg = ChatMessage.Create("", text, ChatMessageType.Console, nil, nil, nil, color)
    Game.SendDirectChatMessage(msg, client)
end

-- This also checks if client is null and if it is - shows message in server console
function GMT.SendPotentiallyServerConsoleMessage(text,client,color)
    if client ~= nil then
        local msg = ChatMessage.Create("", text, ChatMessageType.Console, nil, nil, nil, color)
        Game.SendDirectChatMessage(msg, client)
    else
        GMT.NewConsoleMessage(text, color)
    end
    
end

function GMT.CheckFArgs(value,vtype,canBeNil)
    if type(value) == vtype then
        --print("match "..tostring(value))
        return false
    else
        if value == nil and canBeNil == true then
            --print("can be nil "..tostring(value))
            return false
        end
        --print("not match "..tostring(value))
        return true
    end
end

function GMT.Expect(index, value, ...)
    local types = {...}
    local type = type(value)
    if not GMT.Contains(types, type) then
        GMT.ThrowError("Bad argument #"..index.." ("..GMT.ConcatStringTable(types, " or ").." expected, got "..type..")", 1)
    end
end

function GMT.GetClientByString(string)
    GMT.Expect(1, string, "string", "nil")

    if string == nil then
        return nil
    end
    local number = tonumber(string)
    for i, cl in ipairs(Client.ClientList) do
        if cl.Name == string then
            return cl
        end
        if cl.SteamID == string then
            return cl
        end
        if number ~= nil and cl.SessionId == number then
            return cl
        end
    end
end

function GMT.GetCharacterByString(string)
    GMT.Expect(1, string, "string", "nil")

    if string == nil then
        return nil
    end
    local number = tonumber(string)
    for i, char in ipairs(Character.CharacterList) do
        -- Checking character
        if char.Name == string then
            return char
        end
        if number ~= nil and char.ID == number then
            return char
        end
    end
    -- Checking client for character
    local client = GMT.GetClientByString(string)
    if client == nil then
        return nil
    end
    if client.Character ~= nil and not client.Character.IsDead then
        return client.Character
    end
end

function GMT.GetCharacterClient(id)
    GMT.Expect(1, id, "number")

    for i, cl in ipairs(Client.ClientList) do
        if cl.Character ~= nil and cl.Character.ID == id then
            return cl
        end
    end
end

function GMT.GetVector2FromString(string)
    GMT.Expect(1, string, "string")

    local split = GMT.Split(string, ";")
    if #split == 2 then
        local x = tonumber(split[1])
        local y = tonumber(split[2])
        if x == nil or y == nil then
            return nil
        else
            return Vector2(x, y)
        end
    else
        return nil
    end
end

function GMT.RandomFloat(min,max)
    GMT.Expect(1, min, "number")
    GMT.Expect(2, max, "number")

    return math.random()*(max-min)+min
end

function GMT.FormattedText(text, tags)
    GMT.Expect(1, text, "string")
    GMT.Expect(2, tags, "table")

    local out = "‖"
    if #tags > 0 then
        for i = 1, #tags-1, 1 do
            out = out..tags[i].name..":"..tags[i].value..";"
        end
        out = out..tags[#tags].name..":"..tags[#tags].value.."‖"..text:gsub("‖","").."‖end‖"
    else
        out = out.."‖"..text:gsub("‖","").."‖end‖"
    end
    
    return out


    --[[
    local itags = {}
    for key, value in pairs(tags) do
        table.insert(itags,key..":"..value)
    end
    text:gsub("‖","")
    return '‖'..table.concat(itags,';')..'‖'..text.."‖end‖"]]
end

function GMT.BoolReturn(bool,tru,fals)
    GMT.Expect(1, bool, "boolean")

    if bool == true then
        return tru
    else
        return fals
    end
end

function GMT.ClientLogName(client, name)
    if (client == nil) then return name end
        local retVal = "‖"
        if (client.Karma < 40.0) then
            retVal = retVal.."color:#ff9900;"
        end

        if client.SteamID ~= 0 then
            retVal = retVal.."metadata:"..client.SteamID.."‖"
        else
            retVal = retVal.."metadata:"..client.SessionId.."‖"
        end

        if name ~= nil then
            retVal = retVal..name:gsub("‖","") .."‖end‖"
        else
            retVal = retVal..client.Name:gsub("‖","").."‖end‖"
        end

        return retVal
end

function GMT.IsWire(item)
    if (item.Prefab.Identifier.Value == "redwire") or
    (item.Prefab.Identifier.Value == "bluewire") or
    (item.Prefab.Identifier.Value == "orangewire") or
    (item.Prefab.Identifier.Value == "redwire")
    then
        return true
    end
    return false
end

function GMT.Contains(array,item)
    for i, value in ipairs(array) do
        if value == item then return true end
    end
    return false
end

function GMT.Union(array1,array2)
    GMT.Expect(1, array1, "table")
    GMT.Expect(2, array2, "table")

    for i, item in ipairs(array2) do
        if not GMT.Contains(array1,item) then
            table.insert(array1,item)
        end
    end
    return array1
end

function GMT.Filter(array,filter)
    GMT.Expect(1, array, "table")

    local output = {}

    for i, item in ipairs(array) do
        if not GMT.Contains(filter,item) then
            table.insert(output,item)
        end
    end

    return output
end

function GMT.GetItemByID(id)
    GMT.Expect(1, id, "number")
    for i, item in ipairs(Item.ItemList) do
        if item.ID == id then
            return item
        end
    end
    return nil
end

function GMT.GetCharacterByID(id)
    GMT.Expect(1, id, "number")
    for i, char in ipairs(Character.CharacterList) do
        if char.ID == id then
            return char
        end
    end
    return nil
end

function GMT.InRange(value,min,max)
    GMT.Expect(1, value, "number")
    GMT.Expect(2, min, "number")
    GMT.Expect(3, max, "number")

    if value <= max and value >= min then
        return true
    end
    return false
end

function GMT.SquaredDistance(x1,y1,x2,y2)
    return (x2-x1)^2+(y2-y1)^2
end

function GMT.CanSpeakGhost(char)
    if char == nil or char.IsRagdolled or char.IsKnockedDown or char.IsDead or not char.CanSpeak then
        return true
    end
    return false
end

function GMT.Split (line, separator)
    GMT.Expect(1, line, "string")
    GMT.Expect(2, separator, "string")

    if separator == nil then
        GMT.ThrowError("Separator can't be nil")
    end
    local list = {}
    
    for str in string.gmatch(line, "([^"..separator.."]+)") do
        table.insert(list, str)
    end
    return list
end

function GMT.ConcatStringTable(table, separator)
    GMT.Expect(1, table, "table")
    GMT.Expect(2, separator, "string")

    local string = table[1]
    for i = 2, #table, 1 do
        string = string..separator..table[i]
    end
    return string
end

function GMT.GetJobPrefab(id)
    if JobPrefab.Prefabs.ContainsKey(id) then
        return JobPrefab.Prefabs[id]
    else
        return nil
    end
end

function GMT.GetTimeString(time)
    if time == 0 then
        return GMT.Lang("Permanent")
    end
    local days = 0
    local hours = 0
    local minutes = 0
    local secnds = 0
    
    local out = {}

    -- 1 day = 86400 sec
    days = math.floor(time/86400)
    if days ~= 0 then table.insert(out,days.." "..GMT.Lang("Days")) end

    -- 1 hour = 3600 sec
    hours = math.floor((time/3600)-(days*24))
    if days ~= 0 then table.insert(out,hours.." "..GMT.Lang("Hours")) end

    -- 1 minute = 60000 ms
    minutes = math.floor((time/60)-(hours*60 + days*1440))
    if minutes ~= 0 then table.insert(out,minutes.." "..GMT.Lang("Minutes")) end

    -- 1 second = 0,01666666666666666666666666666667 minutes
    secnds = math.floor(time-(minutes*60+hours*3600+days*86400))
    if secnds ~= 0 then table.insert(out,secnds.." "..GMT.Lang("Seconds")) end

    return table.concat(out,", ")
end

function GMT.Trim2(string)
    if string == '' then
        return string
    else
        local startPos = 1
        local endPos   = #string
    
        while (startPos < endPos and string:byte(startPos) <= 32) do
            startPos = startPos + 1
        end
    
        if startPos >= endPos then
            return ''
        else
            while (endPos > 0 and string:byte(endPos) <= 32) do
                endPos = endPos - 1
            end
    
            return string:sub(startPos, endPos)
        end
    end
end

function GMT.Trim(string)
    return (string.gsub(string, "^%s*(.-)%s*$", "%1"))
  end

function GMT.ParseTuple(tuple, default)
    tuple = GMT.Trim(tuple)

    if tuple:sub(1, 1) ~= '(' or tuple:sub(-1, -1) ~= ')' then
        return default
    end

    tuple = tuple:sub(2, -2)

    local array = GMT.Split(tuple, ',')

    if #array ~= 2 then
        return default
    end

    return GMT.Trim(array[1]), GMT.Trim(array[2])
end

function GMT.ParseTupleArray(tupleArray, default)
    local tuples = GMT.Split(tupleArray, ";")
    local result = {}

    for i, tuple in ipairs(tuples) do
        table.insert(result, {GMT.ParseTuple(tuple, default)})
    end

    return result
end

function GMT.ColorFromStrings(in_r, in_g, in_b, in_a)
    ---- Color assembly
    -- Red
    local r = tonumber(in_r)
    if r == nil then r = 255 end
    -- Green (or *Saul*)
    local g = tonumber(in_g)
    if g == nil then g = 255 end
    -- Blue
    local b = tonumber(in_b)
    if b == nil then b = 255 end
    -- Alpha
    local a = tonumber(in_a)
    if a == nil then a = 255 end

    return Color(r, g, b, a)
end

function GMT.ParseHexColor(hex)
    GMT.Expect(1, hex, "string")

    local length = string.len(hex)
    if length == 6 then
        local r = tonumber(string.sub(hex, 1, 2), 16)
        local g = tonumber(string.sub(hex, 3, 4), 16)
        local b = tonumber(string.sub(hex, 5, 6), 16)
        return Color(r, g, b)
    elseif length == 8 then
        local r = tonumber(string.sub(hex, 1, 2), 16)
        local g = tonumber(string.sub(hex, 3, 4), 16)
        local b = tonumber(string.sub(hex, 5, 6), 16)
        local a = tonumber(string.sub(hex, 7, 8), 16)
        return Color(r, g, b, a)
    else
        return nil
    end
end