GMT.AddCommand("help",GMT.Lang("Help_Help"),false,nil,{{name="command",desc=GMT.Lang("Args_Help_command")}})

GMT.AssignSharedCommand("help",function (args, interface)
    if #args == 1 and string.lower(args[1]) ~= "all" then
        -- Show list of commands
        local command = args[1]
        local data = GMT.HelpData[command]
        if data ~= nil then
            -- Show info about command
            interface.showMessage("==== "..data.name.." ====",Color(255,0,255,255))
            interface.showMessage(GMT.Lang("CMD_Help_desc")..":   "..data.help,Color(255,255,255,255))

            if data.args ~= nil then
                local out = {}
                interface.showMessage(GMT.Lang("CMD_Help_args")..":",Color(255,255,255,255))
                for i, arg in ipairs(data.args) do
                    table.insert(out,i..". '"..arg.name.."'   >   "..arg.desc)
                end
                interface.showMessage(table.concat(out,"\n"),Color(178,178,178,255))
            end

        else
            interface.showMessage("GMTools: "..GMT.Lang("CMD_Help_unknown",{command}),Color(255,0,128,255))
        end
    elseif args[1] ~= nil and string.lower(args[1]) == "all" then
        if args[2] == "chat" then
            -- Show list of chat commands
            interface.showMessage("==== "..GMT.Lang("CMD_Help_chatlist").." ====",Color(255,0,255,255))
            for k, cmd in pairs(GMT.ChatCommands) do
                interface.showMessage("."..cmd.name.."   >        "..cmd.help,Color(255,255,255,255))
            end
        else
            -- Show list of commands
            interface.showMessage("==== "..GMT.Lang("CMD_Help_list").." ====",Color(255,0,255,255))
            for k, cmd in pairs(GMT.HelpData) do
                interface.showMessage("."..cmd.name.."   >        "..cmd.help,Color(255,255,255,255))
            end
        end
    else
        -- Show help info
        interface.showMessage("==== "..GMT.Lang("CMD_Help_help").." ====",Color(255,0,255,255))
        interface.showMessage(GMT.Lang("CMD_Help_line"),Color(255,255,255,255))
        interface.showMessage(GMT.Lang("CMD_Help_gmt"),Color(255,255,255,158))
    end
end)