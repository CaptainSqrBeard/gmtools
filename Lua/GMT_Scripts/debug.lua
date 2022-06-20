
GMT.AddCommand("con","DEBUG: Calls 'client.connected' hook",false,function(client,cursor,args)
    Hook.Call("client.connected",client)
end)

GMT.AddCommand("clicktext","DEBUG: clickable text",false,function(client,cursor,args)
    local chatMsg = ChatMessage.Create("gmt",GMT.FormattedText("Text",{color="color:#ffffff"}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)

local function test(client, name)
    if (client == nil) then return name end
        local retVal = "|color:#ff9900;"

        if client.SteamID ~= 0 then
            retVal = retVal.."metadata:"..client.SteamID.."|"
        else
            retVal = retVal.."metadata:"..client.ID.."|"
        end

        if name ~= nil then
            retVal = retVal..name:gsub("|","") .."|end|"
        else
            retVal = retVal..client.Name:gsub("|","").."|end|"
        end

        return retVal
end

local function text(text, tags)
    local out = "|"
    for i = 1, #tags-1, 1 do
        out = out..tags[i].name..":"..tags[i].value..";"
    end
    out = out..tags[#tags].name..":"..tags[#tags].value.."|"..text:gsub("|","").."|end|"
    return out
end

GMT.AddCommand("tfunc","DEBUG: clickable text",false,function(client,cursor,args)
    GMT.SendConsoleMessage(test(client),client)
end)

GMT.AddCommand("tfunctext","DEBUG: clickable text",false,function(client,cursor,args)
    GMT.SendConsoleMessage("t "..text("text",{{name="color",value="#ffffff"},{name="metadata",value=client.SteamID}}),client)
    local chatMsg = ChatMessage.Create("gmt",GMT.FormattedText("Text",{{name="color",value="#ff00ff"},{name="metadata",value=client.SteamID}}), ChatMessageType.Error, nil, nil)
    Game.SendDirectChatMessage(chatMsg, client)
end)