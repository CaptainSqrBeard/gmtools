local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local files = require("GMT_Scripts._UTILS.files")
local sanctions = require("GMT_Scripts._UTILS.sanctions")

local readers = {}
readers["permissions"] = function (target,line,players)
    if utils.Contains(command.ConsoleCommands,line) then
        table.insert(players[target].command_permissions,line)
    end
end
readers["jobbans"] = function (target,line,players)
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
    if tonumber(expiresAt) < os.time() then
        return
    end
    -- Reason
    reason = line:sub(job:len()+expiresAt:len()+3, line:len())

    if expiresAt == 0 then
        expiresAt = -1
    end
    local sanction = sanctions.createSanction("job_ban", tonumber(expiresAt), {reason=reason, job=job})

    if sanction ~= nil then
        table.insert(players[target].sanctions, sanction)
    end
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

function module.Load(legacyPlayers)
    local players = {}

    local lines = utils.Split(legacyPlayers,'\n')
    local category_reader = nil

    local target = 0
    local name = ""
    for i, line in ipairs(lines) do
        if not (line == "" and line == nil) then
            if line:sub(1,1) == '&' then
                target, name = read_header(line)
                players[target] = {name=name,command_permissions={},sanctions={}}
                category_reader = nil
            elseif line:sub(1,1) == '!' then
                category_reader = get_category(line)
            else
                if category_reader ~= nil then
                    category_reader(target,line,players)
                else
                    return
                end
            end
        end
    end

    return players
end

return module