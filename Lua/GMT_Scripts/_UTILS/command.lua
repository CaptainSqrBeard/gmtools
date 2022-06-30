GMT.AllCommands = {}

function GMT.SplitCommand(msg)
    local split = {}
    local piece = ""
    
    local inQuotes = false
    local escape = 0

    for i = 1, msg:len(), 1 do

        if msg:sub(i,i) == '\\' then
            if escape == 0 then
                escape = 2
            else
                piece = piece..'\\'
            end

        elseif msg:sub(i,i) == '"' then
            if escape == 0 then
                inQuotes = not inQuotes
            else
                piece = piece..'"'
            end

        elseif (msg:sub(i,i) == ' ' and not inQuotes) and (piece ~= "") then
            table.insert(split,piece)
            piece = ""
        
        -- Any other symbol
        elseif escape == 0 then
            piece = piece..msg:sub(i,i)
        end

        -- Escape
        if escape > 0 then
            escape = escape-1
        end
    end

    if piece ~= "" then
        table.insert(split,piece)
    end

    return split
end


--[[ GMT.AddCommand
"Adds new command into console"
* name: Name of the command (String)
* help: Help Text in help (String)
* isCheat: Will this command execute only with enabled cheats (Bool, nil)
* func: Function to execute (Function)
* help_args: Arguments description in help <cmd> (Table)
--]]
function GMT.AddCommand(name,help,isCheat,func,help_args,getValidArgs)
    if (GMT.CheckFArgs(name,"string")) or
    (GMT.CheckFArgs(help,"string")) or
    (GMT.CheckFArgs(isCheat,"boolean",true)) or
    (GMT.CheckFArgs(func,"function")) or
    (GMT.CheckFArgs(help_args,"table",true))
    then
        GMT.ThrowError("Bad Argument")
    end

    GMT.HelpData[name] = {name=name,help=help,args=help_args}
    table.insert(GMT.AllCommands,"."..name)

    Game.AddCommand("."..name, help, function () end, getValidArgs, isCheat)
    Game.AssignOnClientRequestExecute("."..name, func) -- function(client,cursor,args) end
end

--[[ GMT.AddChatCommand
"Adds new command into chat"
* name: Name of the command (String)
* help: Help Text in .help (String)
* func: Function to execute (Function)
--]]
function GMT.AddChatCommand(name,help,func)
    if (GMT.CheckFArgs(name,"string")) or
    (GMT.CheckFArgs(help,"string")) or
    (GMT.CheckFArgs(func,"function"))
    then
        GMT.ThrowError("Bad Argument")
    end

    GMT.ChatCommands["."..name] = {name=name,func=func,help=help}
end

function GMT.GetCommandByString(string)
    for i_1, cmd in ipairs(Game.Commands) do
        if cmd.names[1] == string then
            return cmd
        end
    end
end