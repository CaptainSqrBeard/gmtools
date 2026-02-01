local module = {}

local lang = require("GMT_Scripts._UTILS.lang")

function module.NewConsoleMessage(msg, color, isError)
    DebugConsole.NewMessage(msg, color, isError)
end

function module.ThrowError(text,level)
    if level == nil then level = 0 end
    error("GM-Tools Custom Error: "..text,3+level)
end

function module.SendConsoleMessage(text,client,color)
    local msg = ChatMessage.Create("", text, ChatMessageType.Console, nil, nil, nil, color)
    Game.SendDirectChatMessage(msg, client)
end

-- This also checks if client is null and if it is - shows message in server console
function module.SendPotentiallyServerConsoleMessage(text,client,color)
    if client ~= nil then
        local msg = ChatMessage.Create("", text, ChatMessageType.Console, nil, nil, nil, color)
        Game.SendDirectChatMessage(msg, client)
    else
        module.NewConsoleMessage(text, color, false)
    end
    
end

function module.CheckFArgs(value,vtype,canBeNil)
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

function module.GetClientByString(string)
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

function module.GetCharacterByString(string)
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
    local client = module.GetClientByString(string)
    if client == nil then
        return nil
    end
    if client.Character ~= nil and not client.Character.IsDead then
        return client.Character
    end
end

function module.GetCharacterClient(id)
    for i, cl in ipairs(Client.ClientList) do
        if cl.Character ~= nil and cl.Character.ID == id then
            return cl
        end
    end
end

function module.RandomFloat(min,max)
    return math.random()*(max-min)+min
end

function module.FormattedText(text, tags)
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

function module.BoolReturn(bool,tru,fals)
    if bool == true then
        return tru
    else
        return fals
    end
end

function module.ClientLogName(client, name)
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

function module.IsWire(item)
    if (item.Prefab.Identifier.Value == "redwire") or
    (item.Prefab.Identifier.Value == "bluewire") or
    (item.Prefab.Identifier.Value == "orangewire") or
    (item.Prefab.Identifier.Value == "redwire")
    then
        return true
    end
    return false
end

function module.Contains(array,item)
    for i, value in ipairs(array) do
        if value == item then return true end
    end
    return false
end

function module.Union(array1,array2)
    for i, item in ipairs(array2) do
        if not module.Contains(array1,item) then
            table.insert(array1,item)
        end
    end
    return array1
end

function module.Filter(array,filter)
    local output = {}

    for i, item in ipairs(array) do
        if not module.Contains(filter,item) then
            table.insert(output,item)
        end
    end

    return output
end

function module.GetItemByID(id)
    for i, item in ipairs(Item.ItemList) do
        if item.ID == id then
            return item
        end
    end
    return nil
end

function module.GetCharacterByID(id)
    for i, char in ipairs(Character.CharacterList) do
        if char.ID == id then
            return char
        end
    end
    return nil
end

function module.InRange(value,min,max)
    if value <= max and value >= min then
        return true
    end
    return false
end

function module.SquaredDistance(x1,y1,x2,y2)
    return (x2-x1)^2+(y2-y1)^2
end

function module.CanSpeakGhost(char)
    if char == nil or char.IsRagdolled or char.IsKnockedDown or char.IsDead or not char.CanSpeak then
        return true
    end
    return false
end

function module.Split (line, separator)
    if separator == nil then
        module.ThrowError("Separator can't be nil")
    end
    local list = {}
    
    for str in string.gmatch(line, "([^"..separator.."]+)") do
        table.insert(list, str)
    end
    return list
end

function module.GetTimeString(time)
    if time == 0 then
        return lang.Lang("Permanent")
    end
    local days = 0
    local hours = 0
    local minutes = 0
    local secnds = 0
    
    local out = {}

    -- 1 day = 86400 sec
    days = math.floor(time/86400)
    if days ~= 0 then table.insert(out,days.." "..lang.Lang("Days")) end

    -- 1 hour = 3600 sec
    hours = math.floor((time/3600)-(days*24))
    if days ~= 0 then table.insert(out,hours.." "..lang.Lang("Hours")) end

    -- 1 minute = 60000 ms
    minutes = math.floor((time/60)-(hours*60 + days*1440))
    if minutes ~= 0 then table.insert(out,minutes.." "..lang.Lang("Minutes")) end

    -- 1 second = 0,01666666666666666666666666666667 minutes
    secnds = math.floor(time-(minutes*60+hours*3600+days*86400))
    if secnds ~= 0 then table.insert(out,secnds.." "..lang.Lang("Seconds")) end

    return table.concat(out,", ")
end

function module.IsRespawnShuttle(shuttle)
    for sub in Game.RespawnManager.RespawnShuttles do
        if shuttle == sub then
            return true
        end
    end
    return false
end

return module