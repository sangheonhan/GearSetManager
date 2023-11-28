GearSetManagerDB = GearSetManagerDB or {}

local function SaveSet(name)
    local gearSet = {}
    for i = 1, 19 do
        gearSet[i] = GetInventoryItemLink("player", i)
    end
    GearSetManagerDB[name] = gearSet
    print("Gear set '" .. name .. "' saved for " .. UnitName("player") .. ".")
end

local function LoadSet(name)
    local gearSet = GearSetManagerDB[name]
    if not gearSet then
        print("No gear set named '" .. name .. "'.")
        return
    end
    for i = 1, 19 do
        if gearSet[i] then
            EquipItemByName(gearSet[i], i)
        end
    end
    print("Gear set '" .. name .. "' equipped.")
end

local function RemoveSet(name)
    GearSetManagerDB[name] = nil
    print("Gear set '" .. name .. "' removed.")
end

local function ListSets()
    print("Saved gear sets for " .. UnitName("player") .. ":")
    for name, _ in pairs(GearSetManagerDB) do
        print("- " .. name)
    end
end

SLASH_GSM1 = "/gsm"
SlashCmdList["GSM"] = function(msg)
    local command, rest = msg:match("^(%S*)%s*(.-)$")
    if command == "save" and rest ~= "" then
        SaveSet(rest)
    elseif command == "load" and rest ~= "" then
        LoadSet(rest)
    elseif command == "remove" and rest ~= "" then
        RemoveSet(rest)
    elseif command == "list" then
        ListSets()
    else
        print("Usage: /gsm save/load/remove/list [set name]")
    end
end
