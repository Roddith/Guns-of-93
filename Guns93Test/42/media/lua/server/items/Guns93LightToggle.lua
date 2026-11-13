local ItemBindingHandler_toggleLight_Old = ItemBindingHandler.toggleLight

local function ToggleGunLight(playerObj, weapon)
    if not weapon or not weapon:canEmitLight() then
        return false
    end
    local lightPart = nil
    local partSlots = {"BarrelItem", "Handguard", "HandguardItem", "Scope", "Scope2", "Light", "Receiver"}
    for _, slot in ipairs(partSlots) do
        local part = weapon:getWeaponPart(slot)
        if part and part:hasTag(Gun93Registries.guns93.Light) then
            lightPart = part
            break
        end
    end
    if not lightPart then return false end
    local canToggle = true
    if lightPart:getCurrentUses() <= 0 then
        canToggle = false
    end
    if not canToggle then return false end
    local newFullType = ""
    if lightPart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
        newFullType = string.gsub(lightPart:getFullType(), "_On$", "")
    elseif lightPart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
        newFullType = lightPart:getFullType() .. "_On"
    end
    if newFullType == "" then return false end
    local toggleItem = instanceItem(newFullType)
    if not toggleItem then return false end
    toggleItem:setCurrentUses(lightPart:getCurrentUses())
    weapon:detachWeaponPart(lightPart)
    weapon:attachWeaponPart(toggleItem)
    if weapon:isActivated() and lightPart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
        weapon:setActivated(false)
    else
        weapon:setActivated(true)
    end
	syncItemActivated(playerObj, weapon)
    syncItemModData(playerObj, weapon)
    syncHandWeaponFields(playerObj, weapon)
    playerObj:resetEquippedHandsModels()
    if weapon.playActivateDeactivateSound then
        weapon:playActivateDeactivateSound()
    end
    return true
end

function ItemBindingHandler.toggleLight(key)
    local playerObj = getSpecificPlayer(0)
    if not playerObj then return end
    local primary = playerObj:getPrimaryHandItem()
    if primary and primary:hasTag(Gun93Registries.guns93.Guns93) and primary:canEmitLight() and not playerObj:getVehicle() then
        ToggleGunLight(playerObj, primary)
        return
    end
    return ItemBindingHandler_toggleLight_Old(key)
end