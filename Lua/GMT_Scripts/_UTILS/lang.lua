local lang_files
LangFiles = {}

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


function GMT.Lang(text)
    if lang_files[text] == nil then
        return text
    end
    return lang_files[text]
end