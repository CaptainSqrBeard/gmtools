-- iller_saver#9057 <-- CEO of SS13 Robust

-- This is my first time that i doing something like this

-- How to do file things:
-- File.CreateDirectory('LocalMods/Test')
-- File.Read('LocalMods/Test')
-- File.Delete('LocalMods/Test')
-- File.Write('LocalMods/Test')
-- File.Exists('LocalMods/Test')

local default = 
"ahelp_enabled:true\n"..
"player_commands:.list;.help;.ping;.ahelp;.cls\n"..
"lowest_job:assistant\n"..
"language:en\n"..
"do_bwoink:true"

GMT.Config = {}
GMT.Config.Vars = {}
local path = "LocalMods/_GMT_Config/"

function GMT.Config.CheckFiles()
    if not File.DirectoryExists(path) then
        File.CreateDirectory(path)
        File.Write(path.."config.txt", default)
        File.Write(path.."players.txt", '')
        return true
    end
    if not File.Exists(path.."players.txt") then
        File.Write(path.."players.txt", default)
        return true
    end
    if not File.Exists(path.."config.txt") then
        File.Write(path.."config.txt", default)
        return true
    end
    return false
end
GMT.Config.CheckFiles()

local parameter_load = {}
local parameter_save = {}

-- For loading values from file
parameter_load["ahelp_enabled"] = function (line)
    if line == "false" then
        GMT.Config.Vars.ahelp_enabled = false
    elseif line == "true" then
        GMT.Config.Vars.ahelp_enabled = true
    else
        GMT.Config.Vars.ahelp_enabled = true
        for i, client in ipairs(Client.ClientList) do
            GMT.SendConsoleMessage('GM-Tools: Warning! Unknown value in config at parameter "ahelp_enabled". Using default value',client,Color(255,64,0,255))
            return false
        end
    end
end
parameter_load["player_commands"] = function (line)
    local list = GMT.Split(line,";")
    local out = {}
    for i, cmd in ipairs(list) do
        table.insert(out,cmd)
    end
    GMT.Config.Vars.player_commands = out
end
parameter_load["lowest_job"] = function (line)
    if line == "" then
        GMT.Config.Vars.lowest_job = "assistant"
        return
    end
    GMT.Config.Vars.lowest_job = line
end
parameter_load["language"] = function (line)
    GMT.Config.Vars.language = line
end
parameter_load["do_bwoink"] = function (line)
    if line == "false" then
        GMT.Config.Vars.do_bwoink = false
    elseif line == "true" then
        GMT.Config.Vars.do_bwoink = true
    else
        GMT.Config.Vars.do_bwoink = true
        for i, client in ipairs(Client.ClientList) do
            GMT.SendConsoleMessage('GM-Tools: Warning! Unknown value in config at parameter "do_bwoink". Using default value',client,Color(255,64,0,255))
            return false
        end
    end
end

-- For saving files
parameter_save["ahelp_enabled"] = function ()
    if GMT.Config.Vars.ahelp_enabled == true then
        return "true"
    else
        return "false"
    end
end
parameter_save["player_commands"] = function ()
    return table.concat(GMT.Config.Vars.player_commands,';')
end
parameter_save["lowest_job"] = function ()
    return GMT.Config.Vars.lowest_job
end
parameter_save["language"] = function ()
    return GMT.Config.Vars.language
end
parameter_save["do_bwoink"] = function ()
    if GMT.Config.Vars.do_bwoink == true then
        return "true"
    else
        return "false"
    end
end



function GMT.Config.CreateConfig()
    File.Write(path.."config.txt", default)
end

function GMT.Config.LoadDefault()
    GMT.Config.Vars = {}
    GMT.Config.Vars.player_commands = {".list",".help",".ping",".ahelp",".cls",".clock"}
    GMT.Config.Vars.ahelp_enabled = true
    GMT.Config.Vars.lowest_job = "assistant"
    GMT.Config.Vars.language = "en"
    GMT.Config.Vars.do_bwoink = true
end

local function read_value(line)
    local parameter
    local value
    if line == '' or line:sub(1,2) == '##' then
        return nil,nil
    end
    for i = 1, #line, 1 do
        if line:sub(i,i) == ':' then
            parameter = line:sub(1,i-1)
            value = line:sub(i+1,#line)
            return parameter,value
        end
    end
    if parameter == nil or value == nil then
        return false, nil
    end
    return parameter,nil
end



function GMT.Config.Load()
    GMT.Config.LoadDefault()

    if GMT.Config.CheckFiles() then
        return
    end
    if File.Exists(path.."config.txt") then
        local lines = GMT.Split(File.Read(path.."config.txt"),'\n')
        for i, line in ipairs(lines) do
            local parameter, value = read_value(line)
            if parameter == false then
                for i, client in ipairs(Client.ClientList) do
                    GMT.SendConsoleMessage('GM-Tools: Syntax Error in config. Loading default one',client,Color(255,0,0,255))
                    return false
                end
                GMT.Config.LoadDefault()
            end
            if parameter ~= nil then
                --GMT.Config.Vars[parameter] = value
                local func = parameter_load[parameter]
                if func ~= nil then
                    func(value)
                else
                    for i, client in ipairs(Client.ClientList) do
                        GMT.SendConsoleMessage('GM-Tools: Warning! Unknown parameter in config "'..parameter..'". Skipping it',client,Color(255,64,0,255))
                    end
                end
            end

        end
    else
        GMT.Config.CreateConfig()
        GMT.Config.LoadDefault()
        for i, client in ipairs(Client.ClientList) do
            GMT.SendConsoleMessage('GM-Tools: Config is not exists. Creating default one',client,Color(255,0,0,255))
        end
        return false
    end
    return true
end



function GMT.Config.Save()
    GMT.Config.CheckFiles()
    local txt = ""
    for k, val in pairs(GMT.Config.Vars) do
        txt = txt..k..":"..parameter_save[k]().."\n"
    end
    File.Write(path.."config.txt",txt)
end



function GMT.CheckPlayerCommands()
    local out = {}
    for i, cmd in ipairs(GMT.Config.Vars.player_commands) do
        if GMT.Contains(GMT.AllCommands,cmd) then
            table.insert(out,cmd)
        else
            for i, client in ipairs(Client.ClientList) do
                GMT.SendConsoleMessage('GM-Tools: Warning! Unknown GM-Tools command "'..cmd..'" in config at parameter "player_commands". Ignoring it.',client,Color(255,64,0,255))
            end
        end
    end
    GMT.Config.Vars.player_commands = out
end