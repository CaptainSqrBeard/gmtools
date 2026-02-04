local module = {}

local utils = require("GMT_Scripts._UTILS.utils")

local registeredSanctions = {}

function module.initialize()
    module.registerSanctionType("job_ban", function (data)
        local validated = {}
        validated.reason = utils.ValidateOrDefault(data.reason, nil, "string", "nil")
        validated.job = utils.ValidateOrDefault(data.job, nil, "string", "nil")
        return validated
    end,
    function (data)

    end)
    module.registerSanctionType("ahelp_ban", function (data)
        local validated = {}
        validated.reason = utils.ValidateOrDefault(data.reason, nil, "string", "nil")
        return validated
    end)
    module.registerSanctionType("note", function (data)
        local validated = {}
        validated.text = utils.ValidateOrDefault(data.text, nil, "string", "nil")
        validated.reason = utils.ValidateOrDefault(data.reason, nil, "string", "nil")
        validated.public = utils.ValidateOrDefault(data.public, false, "bool", "nil")
        local rate = utils.ValidateOrDefault(data.rating, nil, "number", "nil")
        if rate ~= nil then
            validated.rating = utils.Clamp(rate)
        end
        return validated
    end)
end

function module.registerSanctionType(id, validator, checker)
    registeredSanctions[id] = {validator=validator}
end

function module.createSanction(sanctionType, expiresAt, additionalData, givenAt)
    local sanction = {
        type = sanctionType,
        additionalData = utils.ValidateOrDefault(additionalData, {}, "table"),
        givenAt = math.floor(utils.ValidateOrDefault(givenAt, os.time(), "number")),
        revoked = false
    }

    if expiresAt == nil then
        sanction.expiresAt = -1
    else
        sanction.expiresAt = math.floor(expiresAt)
    end

    return module.validateSanction(sanction)
end

function module.validateSanction(sanction)
    local validated = {}
    if (type(sanction.type) ~= "string") or
        (type(sanction.revoked) ~= "boolean") or
        (type(sanction.expiresAt) ~= "number") or
        (type(sanction.givenAt) ~= "number") or
        (type(sanction.additionalData) ~= "table") then
        return
    end

    if registeredSanctions[sanction.type] == nil then
        return
    end

    local validatedAdditionalData
    if registeredSanctions[sanction.type].validator ~= nil then
        validatedAdditionalData = registeredSanctions[sanction.type].validator(sanction.additionalData)
    else
        validatedAdditionalData = {}
    end

    validated.type = sanction.type
    validated.revoked = sanction.revoked
    validated.expiresAt = math.floor(sanction.expiresAt)
    validated.givenAt = math.floor(sanction.givenAt)
    validated.additionalData = validatedAdditionalData

    return validated
end

function module.getActiveSanctions(entry, identifier)
    local found = {}
    for i, sanction in ipairs(entry.sanctions) do
        if sanction.type == identifier and module.isActiveSanction(sanction) then
            table.insert(found, sanction)
        end
    end
    return found
end

function module.getSanctions(entry, identifier)
    local found = {}
    for i, sanction in ipairs(entry.sanctions) do
        if sanction.type == identifier then
            table.insert(found, sanction)
        end
    end
    return found
end

function module.isActiveSanction(sanction)
    local curTime = os.time()
    return not sanction.revoked and (sanction.expiresAt == -1 or sanction.expiresAt > curTime)
end

function module.getGiveTime(sanction)
    return os.date("%d.%m.%y %H:%M:%S", sanction.givenAt)
end

return module