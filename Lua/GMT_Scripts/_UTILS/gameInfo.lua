local module = {}

local lang = require("GMT_Scripts._UTILS.lang")

module.SubmarineTypes = {
    "Submarine_types_player",
    "Submarine_types_outpost",
    "Submarine_types_outpostmodule",
    "Submarine_types_wreck",
    "Submarine_types_beaconstation",
    "Submarine_types_enemysubmarine",
    "Submarine_types_ruin"
}
module.SubmarineClasses = {
    "Submarine_classes_undefined",
    "Submarine_classes_scout",
    "Submarine_classes_attack",
    "Submarine_classes_transport"
}
module.CharacterTeams = {
    "CharacterTeams_none",
    "CharacterTeams_team1",
    "CharacterTeams_team2",
    "CharacterTeams_friendlynpc"
}

function module.GetLocalizedSubmarineType(index)
    if index >= 0 and index <= #module.SubmarineTypes-1 then
        return lang.Lang(module.SubmarineTypes[index+1])
    end
    return lang.Lang("Submarine_types_custom", {index})
end

function module.GetLocalizedSubmarineClass(index)
    if index >= 0 and index <= #module.SubmarineClasses-1 then
        return lang.Lang(module.SubmarineClasses[index+1])
    end
    return lang.Lang("Submarine_classes_custom", {index})
end

function module.GetLocalizedTeam(index)
    if index >= 0 and index <= #module.CharacterTeams-1 then
        return lang.Lang(module.CharacterTeams[index+1])
    end
    return lang.Lang("CharacterTeams_custom", {index})
end

return module