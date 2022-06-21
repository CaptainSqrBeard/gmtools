local lang_files = {}
GMT.LangFiles = {}

function GMT.LangFiles.Load(lang)
    if lang == "en" then
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/en.lua")
    elseif lang == "ru" then
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/ru.lua")
    else
        -- Unknown language
        lang_files = dofile(GMT_PATH.."/Lua/LangFiles/en.lua")
    end
end


function GMT.Lang(text,vars)
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

function GMT.Array()
    return lang_files
end