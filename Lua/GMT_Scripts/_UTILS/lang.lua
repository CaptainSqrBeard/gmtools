local lang_files = {}
GMT.LangFiles = {}

function GMT.LangFiles.Load(lang)
    GMT.Expect(1, lang, "string")

    if lang == "en" then
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/en.lua")
    elseif lang == "ru" then
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/ru.lua")
    else
        -- Unknown language
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/en.lua")
    end
end


function GMT.LangFiles.ListUnspecifiedKeys()
    local baseLang = dofile(GMT_PATH.."/Lua/LangFiles/en.lua")

    for k, text in pairs(baseLang) do
        if lang_files[k] == nil then
            print('Key is unspecified in current language: "'..k..'"')
        end
    end
end


function GMT.Lang(text,vars)
    GMT.Expect(1, text, "string")
    GMT.Expect(1, vars, "table", "nil")

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

--function GMT.Lang(text,vars) return "TEST" end

function GMT.Array()
    return lang_files
end