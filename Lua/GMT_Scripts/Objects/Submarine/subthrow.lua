
local lang = require("GMT_Scripts._UTILS.lang")
local command = require("GMT_Scripts._UTILS.command")

command.AddCommand("subthrow",lang.Lang("Help_SubmarineThrow"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineThrow_submarine")},
    {name="vector",desc=lang.Lang("Args_SubmarineThrow_vector"),optional=true},
    {name="mode",desc=lang.Lang("Args_SubmarineThrow_mode"),optional=true}})

command.AssignSharedCommand("subthrow",function (args, interface)
    if #args == 0 then
        interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("subthrow"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    local vector = Vector2.Zero
    if args[2] == nil then
        if interface.cursor == nil then
            utils.NewConsoleMessage("GMTools: "..lang.Lang("CMD_SubmarineTp_NoPosition"),Color(255,0,128,255))
            return
        else
            vector = (interface.cursor - sub.WorldPosition)*0.02
        end 
    elseif args[2] == "cursor" then
        if interface.cursor == nil then
            interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineThrow_NoCursor"),Color(255,0,128,255))
            return
        else
            vector = (interface.cursor - sub.WorldPosition)*0.02
        end
    elseif args[2] == "ncursor" then
        if interface.cursor == nil then
            interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineThrow_NoCursor"),Color(255,0,128,255))
            return
        else
            vector = Vector2.Normalize(interface.cursor - sub.WorldPosition)*15
        end
    else
        local vectorFromString = GMT.GetVector2FromString(args[2])
        if vectorFromString == nil then
            interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineThrow_UnknownTypeVector"),Color(255,0,128,255))
            return
        else
            vector = vectorFromString
        end
    end

    if args[3] == nil or args[3] == "set" then
        sub.subBody.Body.LinearVelocity = vector
        interface.showMessage(lang.Lang("CMD_SubmarineThrow_Set", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),Color(255,0,255,255))
    elseif args[3] == "add" then
        sub.subBody.Body.LinearVelocity = sub.subBody.Body.LinearVelocity + vector
        interface.showMessage(lang.Lang("CMD_SubmarineThrow_Add", {sub.Info.Name, math.floor(vector.x), math.floor(vector.y)}),Color(255,0,255,255))
    else
        interface.showMessage("GMTools: "..lang.Lang("CMD_SubmarineThrow_UnknownTypeMode"),Color(255,0,128,255))
        return
    end
end)