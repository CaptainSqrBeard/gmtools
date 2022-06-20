GMT.AddCommand("help","Sends information about commands.",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then
        return
    end

    if #args == 1 and string.lower(args[1]) ~= "all" then
        local command = args[1]
        local data = GMT.HelpData[command]
        if data ~= nil then
            GMT.SendConsoleMessage("==== "..data.name.." ====",client,Color(255,0,255,255))
            GMT.SendConsoleMessage("Description:   "..data.help,client,Color(255,255,255,255))

            if data.args ~= nil then
                local out = {}
                GMT.SendConsoleMessage("Arguments:",client,Color(255,255,255,255))
                for i, arg in ipairs(data.args) do
                    table.insert(out,i..". '"..arg.name.."'   >   "..arg.desc)
                end
                GMT.SendConsoleMessage(table.concat(out,"\n"),client,Color(178,178,178,255))
            end

        else
            GMT.SendConsoleMessage("GMTools: Unknown command '"..command.."'!",client,Color(255,0,128,255))
        end
    
    elseif args[1] ~= nil and string.lower(args[1]) == "all" then
        if args[2] == "chat" then
            GMT.SendConsoleMessage("==== Chat Help ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.ChatCommands) do
                GMT.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        else
            GMT.SendConsoleMessage("==== Help ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.HelpData) do
                GMT.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        end

        

    else
        GMT.SendConsoleMessage("==== Help ====",client,Color(255,0,255,255))
        GMT.SendConsoleMessage("* This server runned with mod 'GM-Tools'\n* Type '.help all' if you want get all command list\n* Type '.help all chat' to get list of chat commands.",client,Color(255,255,255,255))
        GMT.SendConsoleMessage("Game Master Tools",client,Color(255,255,255,158))
    end

end,{{name="command",desc="Input name of command to get more info about it, or type 'all' to get command list"}})