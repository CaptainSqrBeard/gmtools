GMT.SubmarineTypes = {
    "Submarine_types_player",
    "Submarine_types_outpost",
    "Submarine_types_outpostmodule",
    "Submarine_types_wreck",
    "Submarine_types_beaconstation",
    "Submarine_types_enemysubmarine",
    "Submarine_types_ruin"
}
GMT.SubmarineClasses = {
    "Submarine_classes_undefined",
    "Submarine_classes_scout",
    "Submarine_classes_attack",
    "Submarine_classes_transport"
}
GMT.CharacterTeams = {
    "CharacterTeams_none",
    "CharacterTeams_team1",
    "CharacterTeams_team2",
    "CharacterTeams_friendlynpc"
}

function GMT.GetLocalizedSubmarineType(index)
    if index >= 0 and index <= #GMT.SubmarineTypes-1 then
        return GMT.Lang(GMT.SubmarineTypes[index+1])
    end
    return GMT.Lang("Submarine_types_custom", {index})
end

function GMT.GetLocalizedSubmarineClass(index)
    if index >= 0 and index <= #GMT.SubmarineClasses-1 then
        return GMT.Lang(GMT.SubmarineClasses[index+1])
    end
    return GMT.Lang("Submarine_classes_custom", {index})
end

function GMT.GetLocalizedTeam(index)
    if index >= 0 and index <= #GMT.CharacterTeams-1 then
        return GMT.Lang(GMT.CharacterTeams[index+1])
    end
    return GMT.Lang("CharacterTeams_custom", {index})
end