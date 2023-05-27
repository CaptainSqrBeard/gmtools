function GMT.ThrowError(text,level)
    if level == nil then level = 0 end
    error("GM-Tools Custom Error: "..text,3+level)
end

function GMT.SendConsoleMessage(text,client,color)
    local msg = ChatMessage.Create("", text, ChatMessageType.Console, nil, nil, nil, color)
    Game.SendDirectChatMessage(msg, client)
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

function GMT.GetClientByString(string)
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
    for i, cl in ipairs(Client.ClientList) do
        if cl.Character ~= nil and cl.Character.ID == id then
            return cl
        end
    end
end

function GMT.RandomFloat(min,max)
    return math.random()*(max-min)+min
end

function GMT.FormattedText(text, tags)
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
    for i, item in ipairs(array2) do
        if not GMT.Contains(array1,item) then
            table.insert(array1,item)
        end
    end
    return array1
end

function GMT.GetItemByID(id)
    for i, item in ipairs(Item.ItemList) do
        if item.ID == id then
            return item
        end
    end
    return nil
end

function GMT.GetCharacterByID(id)
    for i, char in ipairs(Character.CharacterList) do
        if char.ID == id then
            return char
        end
    end
    return nil
end

function GMT.InRange(value,min,max)
    if value <= max and value >= min then
        return true
    end
    return false
end

function GMT.CanSpeakGhost(char)
    if char == nil or char.IsRagdolled or char.IsKnockedDown or char.IsDead or not char.CanSpeak then
        return true
    end
    return false
end

function GMT.Split (line, separator)
    if separator == nil then
        GMT.ThrowError("Separator can't be nil")
    end
    local list = {}
    
    for str in string.gmatch(line, "([^"..separator.."]+)") do
        table.insert(list, str)
    end
    return list
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