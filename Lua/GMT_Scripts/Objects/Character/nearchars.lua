local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")

command.AddCommand("nearchars",GMT.Lang("Help_NearChars"),true,nil,{
{name="size",desc=GMT.Lang("Args_NearChars_size")}})

command.AssignClientCommand("nearchars",function(client,cursor,args)
    local size = 100

    -- Checking size
    if args[1] ~= nil then
        size = tonumber(args[1])
        if size == nil then
            utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_NearChars_badrange"),client,Color(255,0,128,255))
            return
        end
    end
    
    utils.SendConsoleMessage(GMT.Lang("CMD_NearChars_nearchars",{size}),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        local pos = char.WorldPosition
        if (utils.SquaredDistance(cursor.x,cursor.y,pos.x,pos.y) < size*size) then
            utils.SendConsoleMessage(GMT.Lang("CMD_NearChars_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),client,Color(255,255,255,255))
        end
    end
end)

command.AssignServerCommand("nearchars",function(args)
    utils.NewConsoleMessage("GMTools: "..GMT.Lang("Error_bad_console"),Color(255,0,0,255),false)
end)