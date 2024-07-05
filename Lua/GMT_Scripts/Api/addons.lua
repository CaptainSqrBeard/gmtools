GMT.API = {}
GMT.Addons = {}

--[[ GMT.API.RegisterAddon
Registers addon to GM Tools. Returns true if registration was successful.
* contentPackage - Content package of that addon.
--]]
function GMT.API.RegisterAddon(contentPackage)
    table.insert(GMT.Addons, {ContentPackage=contentPackage})
    return true
end