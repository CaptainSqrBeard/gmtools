
local utils = require("GMT_Scripts._UTILS.utils")
local main = require("GMT_Scripts.main")

local module = {}

local lang_files = {}

function module.Load(lang)
    utils.Expect(1, lang, "string")

    if lang == "en" then
        lang_files = dofile(main.path.."/Lua/LangFiles/en.lua")
    elseif lang == "ru" then
        lang_files = dofile(main.path.."/Lua/LangFiles/ru.lua")
    else
        -- Unknown language
        lang_files = dofile(main.path.."/Lua/LangFiles/en.lua")
    end
end

function module.ListUnspecifiedKeys()
    local baseLang = dofile(main.path.."/Lua/LangFiles/en.lua")

    for k, text in pairs(baseLang) do
        if lang_files[k] == nil then
            print('Key is unspecified in current language: "'..k..'"')
        end
    end
end

function module.Lang(text,vars)
    utils.Expect(1, text, "string")
    utils.Expect(1, vars, "table", "nil")

    if vars ~= nil and #vars ~= 0 then
        if lang_files[text] == nil then
            return text
        else
            local lang_text = lang_files[text]
            for i, var in ipairs(vars) do
                lang_text = lang_text:gsub('{'..tostring(i)..'}',var)
            end
            return lang_text
        end
    else
        if lang_files[text] == nil then
            return text
        end
        return lang_files[text]
    end
end

function module.GetTimeString(time)
    if time == 0 then
        return module.Lang("Permanent")
    end
    local days = 0
    local hours = 0
    local minutes = 0
    local secnds = 0
    
    local out = {}

    -- 1 day = 86400 sec
    days = math.floor(time/86400)
    if days ~= 0 then table.insert(out,days.." "..module.Lang("Days")) end

    -- 1 hour = 3600 sec
    hours = math.floor((time/3600)-(days*24))
    if days ~= 0 then table.insert(out,hours.." "..module.Lang("Hours")) end

    -- 1 minute = 60000 ms
    minutes = math.floor((time/60)-(hours*60 + days*1440))
    if minutes ~= 0 then table.insert(out,minutes.." "..module.Lang("Minutes")) end

    -- 1 second = 0,01666666666666666666666666666667 minutes
    secnds = math.floor(time-(minutes*60+hours*3600+days*86400))
    if secnds ~= 0 then table.insert(out,secnds.." "..module.Lang("Seconds")) end

    return table.concat(out,", ")
end

function module.AvailableLanguages()
    return {"en", "ru"}
end

return module