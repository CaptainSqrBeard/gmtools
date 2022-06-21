GMT.PlayerData = {}
GMT.PlayerData.Players = {}

--[[ Example
&csqrb;76561199036509221
!permissions
.adminpm
.cls
!jobbans
engineer;123456789;using drugs
]]

local path = "LocalMods/_GMT_Config/"
local readers = {}
readers["permissions"] = function (target,line)
    if GMT.Contains(GMT.AllCommands,line) then
        table.insert(GMT.PlayerData.Players[target].Permissions,line)
    end
end
readers["jobbans"] = function (target,line)
    local job
    local expiresAt
    local reason
    -- Job
    for i = 1, line:len(), 1 do
        if line:sub(i,i) == ';' then
            job = line:sub(1,i-1)
            break
        end
    end
    -- ExpiresAt
    for i = job:len()+2, line:len(), 1 do
        if line:sub(i,i) == ';' then
            expiresAt = line:sub(job:len()+2, i-1)
            break
        end
    end
    -- Reason
    reason = line:sub(job:len()+expiresAt:len()+3, line:len())

    table.insert(GMT.PlayerData.Players[target].Jobbans,{job=job,reason=reason,expiresAt=tonumber(expiresAt)})
end

local function read_header(line)
    for i = 2, line:len(), 1 do
        if line:sub(i,i) == ';' then
            return line:sub(2,i-1), line:sub(i+1,line:len())
        end
    end
    return 0
end

local function get_category(line)
    local name = line:sub(2,line:len())
    local func = readers[name]
    if func == nil then
        func = function () end
    end
    return func
end

function GMT.PlayerData.Load()
    if File.Exists(path.."players.txt") then
        local lines = GMT.Split(File.Read(path.."players.txt"),'\n')
        local category_reader = nil

        local target = 0
        local name = ""
        for i, line in ipairs(lines) do
            if not (line == "" and line == nil) then
                if line:sub(1,1) == '&' then
                    target, name = read_header(line)
                    GMT.PlayerData.Players[target] = {Name=name,Permissions={},Jobbans={}}
                    category_reader = nil
                elseif line:sub(1,1) == '!' then
                    category_reader = get_category(line)
                else
                    if category_reader ~= nil then
                        category_reader(target,line)
                    else
                        for i, client in ipairs(Client.ClientList) do
                            GMT.SendConsoleMessage('GM-Tools: Syntax Error in player database. Loading empty one',client,Color(255,0,0,255))
                            return false
                        end
                    end
                end

            end
        end
    else
        File.Write(path.."players.txt")
        for i, client in ipairs(Client.ClientList) do
            GMT.SendConsoleMessage('GM-Tools: players.txt is not exists. Creating default one',client,Color(255,0,0,255))
        end
        return false
    end
    return true
end

function GMT.PlayerData.Save()
    local txt = ""
    for k, player in pairs(GMT.PlayerData.Players) do
        txt = txt.."&"..k..";"..player.Name.."\n!permissions\n"
        for i, cmd in ipairs(player.Permissions) do
            txt = txt..cmd.."\n"
        end
        txt = txt.."!jobbans\n"
        for i, jb in ipairs(player.Jobbans) do
            txt = txt..jb.job..';'..jb.expiresAt..';'..jb.reason..'\n'
        end
    end
    File.Write(path.."players.txt",txt)
end

function GMT.PlayerData.Create(client)
    if GMT.PlayerData.Players[client.SteamID] == nil then
        GMT.PlayerData.Players[client.SteamID] = {Name=client.Name,Permissions={},Jobbans={}}
        return true
    end
    return false
end

function GMT.PlayerData.CreateSteam(name, steam)
    if GMT.PlayerData.Players[steam] == nil then
        GMT.PlayerData.Players[steam] = {Name=name,Permissions={},Jobbans={}}
        return true
    end
    return false
end



function GMT.PlayerData.JobBan(client,job_id,period,reason)
    if job_id == GMT.Config.Vars.lowest_job then
        return false
    end

    GMT.PlayerData.Create(client)
    if reason == nil then reason = "No reason" end
    local expiresAt
    if period ~= nil and period ~= 0 then
        expiresAt = math.floor(os.time()+period)
    else
        expiresAt = 0
        period = 0
    end
    
    local alreadyHaveJB = false
    for i, jb in ipairs(GMT.PlayerData.Players[client.SteamID].Jobbans) do
        if jb.job == job_id then
            GMT.PlayerData.Players[client.SteamID].Jobbans[i] = {job=job_id,expiresAt=expiresAt,reason=reason}
            alreadyHaveJB = true
            break
        end
    end
    if alreadyHaveJB == false then
        table.insert(GMT.PlayerData.Players[client.SteamID].Jobbans, {job=job_id,expiresAt=expiresAt,reason=reason})
    end

    local chatMessage = ChatMessage.Create("", GMT.Lang("CMD_Jobban_Box",{job_id,GMT.GetTimeString(period),reason}), ChatMessageType.MessageBox, nil, nil)
    chatMessage.Color = Color(255, 60, 60, 255)
    Game.SendDirectChatMessage(chatMessage, client)
    GMT.PlayerData.Save()
    return true
end

function GMT.PlayerData.JobBanSteam(client_steam,job_id,period,reason)
    if job_id == GMT.Config.Vars.lowest_job then
        return false
    end
    if client_steam == nil then
        return false
    end

    GMT.PlayerData.CreateSteam("Unknown",client_steam)
    if reason == nil then reason = "No reason" end
    local expiresAt
    if period ~= nil and period ~= 0 then
        expiresAt = math.floor(os.time()+period)
    else
        expiresAt = 0
        period = 0
    end
    
    local alreadyHaveJB = false
    for i, jb in ipairs(GMT.PlayerData.Players[client_steam].Jobbans) do
        if jb.job == job_id then
            GMT.PlayerData.Players[client_steam].Jobbans[i] = {job=job_id,expiresAt=expiresAt,reason=reason}
            alreadyHaveJB = true
            break
        end
    end
    if alreadyHaveJB == false then
        table.insert(GMT.PlayerData.Players[client_steam].Jobbans, {job=job_id,expiresAt=expiresAt,reason=reason})
    end

    GMT.PlayerData.Save()
    return true
end

function GMT.PlayerData.HasJobBan(client,job_id)
    if job_id == GMT.Config.Vars.lowest_job then
        return false,nil,nil,nil
    end
    if GMT.PlayerData.Create(client) then
        return false
    end

    for i, jb in ipairs(GMT.PlayerData.Players[client.SteamID].Jobbans) do
        if jb.job == job_id then
            if jb.expiresAt ~= 0 and os.time() > jb.expiresAt then
                table.remove(GMT.PlayerData.Players[client.SteamID].Jobbans, i)
                return false
            end
            return true
        end
    end
end

function GMT.PlayerData.GetJobBanInfo(client,job_id)
    if job_id == GMT.Config.Vars.lowest_job then
        return false,nil,nil,nil
    end
    if GMT.PlayerData.Create(client) then
        return false,nil,nil,nil
    end

    for i, jb in ipairs(GMT.PlayerData.Players[client.SteamID].Jobbans) do
        if jb.job == job_id then
            if jb.expiresAt ~= 0 and os.time() > jb.expiresAt then
                table.remove(GMT.PlayerData.Players[client.SteamID].Jobbans, i)
                return false,nil,nil,nil
            end
            return true, jb.expiresAt, jb.reason
        end
    end
end