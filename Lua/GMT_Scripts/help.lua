GMT.AddCommand("help",GMT.Lang("Help_Help"),false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,3) then
        return
    end

    if #args == 1 and string.lower(args[1]) ~= "all" then
        local command = args[1]
        local data = GMT.HelpData[command]
        if data ~= nil then
            GMT.SendConsoleMessage("==== "..data.name.." ====",client,Color(255,0,255,255))
            GMT.SendConsoleMessage(GMT.Lang("CMD_Help_desc")..":   "..data.help,client,Color(255,255,255,255))

            if data.args ~= nil then
                local out = {}
                GMT.SendConsoleMessage(GMT.Lang("CMD_Help_args")..":",client,Color(255,255,255,255))
                for i, arg in ipairs(data.args) do
                    table.insert(out,i..". '"..arg.name.."'   >   "..arg.desc)
                end
                GMT.SendConsoleMessage(table.concat(out,"\n"),client,Color(178,178,178,255))
            end

        else
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Help_unknown",{command}),client,Color(255,0,128,255))
        end
    
    elseif args[1] ~= nil and string.lower(args[1]) == "all" then
        if args[2] == "chat" then
            GMT.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_chatlist").." ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.ChatCommands) do
                GMT.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        else
            GMT.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_list").." ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.HelpData) do
                GMT.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        end

        

    else
        GMT.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_help").." ====",client,Color(255,0,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_Help_line"),client,Color(255,255,255,255))
        GMT.SendConsoleMessage(GMT.Lang("CMD_Help_gmt"),client,Color(255,255,255,158))
    end

end,{{name="command",desc=GMT.Lang("Args_Help_command")}})