local module = {}

local lang = require("GMT_Scripts._UTILS.lang")
local utils = require("GMT_Scripts._UTILS.utils")

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
    utils.Expect(1, index, "number")
    if utils.InRange(index, 0, #module.SubmarineTypes-1) then
        return lang.Lang(module.SubmarineTypes[index+1])
    end
    return lang.Lang("Submarine_types_custom", {index})
end

function module.GetLocalizedSubmarineClass(index)
    utils.Expect(1, index, "number")
    if utils.InRange(index, 0, #module.SubmarineClasses-1) then
        return lang.Lang(module.SubmarineClasses[index+1])
    end
    return lang.Lang("Submarine_classes_custom", {index})
end

function module.GetLocalizedTeam(index)
    utils.Expect(1, index, "number")
    if utils.InRange(index, 0, #module.CharacterTeams-1) then
        return lang.Lang(module.CharacterTeams[index+1])
    end
    return lang.Lang("CharacterTeams_custom", {index})
end

return module