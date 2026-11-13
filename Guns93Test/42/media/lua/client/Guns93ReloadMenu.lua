local old_doReloadMenuForWeapon = ISInventoryPaneContextMenu.doReloadMenuForWeapon
function ISInventoryPaneContextMenu.doReloadMenuForWeapon(playerObj, weapon, context)
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_doReloadMenuForWeapon(playerObj, weapon, context)
    end
    local playerInv = playerObj:getInventory()
    if weapon:getMagazineType() or weapon:hasTag(Gun93Registries.guns93.MoonClip) or weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip) then
        if weapon:isContainsClip() or weapon:getWeaponPart("Moonclip") then
            local ejectText = weapon:getWeaponPart("Moonclip") and getText("IGUI_ContextMenu_EjectMoon") or getText("ContextMenu_EjectMagazine")
            context:addOption(ejectText, playerObj, ISInventoryPaneContextMenu.onEjectMagazine, weapon)
        else
            local foundAny = false
            local subMenu = context:getNew(context)
            local noLoad = false
            local weaponType = weapon:getFullType()
            local magList = MagazineGunSet[weaponType]
            if magList then
                for _, magType in ipairs(magList) do
                    local mags = playerInv:getAllTypeRecurse(magType)
                    for k = 0, mags:size() - 1 do
                        local mag = mags:get(k)
                        if mag then
                            if mag:hasTag(Gun93Registries.guns93.MoonClip) or mag:hasTag(Gun93Registries.guns93.SpeedLoader) or mag:hasTag(Gun93Registries.guns93.StripperClip) or mag:hasTag(Gun93Registries.guns93.SpeedStrip) then
                                if mag:getCurrentAmmoCount() < 1 then
                                    noLoad = true
                                end
                            end
                            if mag:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0 then
                                noLoad = true
                            end
                            if not noLoad then
                                subMenu:addOption(mag:getDisplayName() .. " (" .. mag:getCurrentAmmoCount() .. "/" .. mag:getMaxAmmo() .. ")", playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, mag)
                                foundAny = true
                            end
                            noLoad = false
                        end
                    end
                end
            end
            if not foundAny and weapon:getMagazineType() then
                local oemMags = playerInv:getAllTypeRecurse(weapon:getMagazineType())
                for k = 0, oemMags:size() - 1 do
                    local mag = oemMags:get(k)
                    if mag then
                        if mag:hasTag(Gun93Registries.guns93.MoonClip) or  mag:hasTag(Gun93Registries.guns93.SpeedLoader) or mag:hasTag(Gun93Registries.guns93.StripperClip) or mag:hasTag(Gun93Registries.guns93.SpeedStrip) then
                            if mag:getCurrentAmmoCount() < 1 then
                                noLoad = true
                            end
                        end
                        if mag:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0 then
                            noLoad = true
                        end
                        if not noLoad then
                            subMenu:addOption(mag:getDisplayName() .. " (" .. mag:getCurrentAmmoCount() .. "/" .. mag:getMaxAmmo() .. ")", playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, mag)
                            foundAny = true
                        end
                        noLoad = false
                    end
                end
            end
            local insertText = weapon:getMagazineType() and getText("ContextMenu_InsertMagazine") or getText("IGUI_ContextMenu_LoadDevice")
            local insertOption = context:addOption(insertText)
            if not weapon:getMagazineType() and weapon:getCurrentAmmoCount() == weapon:getMaxAmmo() then
                foundAny = false
            end
            if foundAny then
                context:addSubMenu(insertOption, subMenu)
            else
                insertOption.notAvailable = true
            end
        end
    end
    if not weapon:getMagazineType() and not weapon:getWeaponPart("Moonclip") then
        ISInventoryPaneContextMenu.doBulletMenu(playerObj, weapon, context)
    end
    if weapon:isJammed() then
        context:addOption(getText("ContextMenu_Unjam", weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon)
    elseif ISReloadWeaponAction.canRack(weapon) and not weapon:getWeaponPart("Moonclip") then
        local rackText = weapon:haveChamber() and getText("ContextMenu_Rack") or getText("ContextMenu_UnloadRoundFrom")
        context:addOption(getText(rackText, weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon)
    end
end

local old_doReloadMenuForMagazine = ISInventoryPaneContextMenu.doReloadMenuForMagazine
function ISInventoryPaneContextMenu.doReloadMenuForMagazine(playerObj, magazine, context)
    if not magazine or not magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return old_doReloadMenuForMagazine(playerObj, magazine, context)
    end
    if magazine:hasTag(Gun93Registries.guns93.MagExten) then
        return
    end
    local foundAny = false
    local subMenu = context:getNew(context)
    local processedGuns = {}
    local playerInv = playerObj:getInventory()
    local magFullType = magazine:getFullType()
    for gunType, magList in pairs(MagazineGunSet) do
        local compatible = false
        for _, magType in ipairs(magList) do
            if magType == magFullType then
                compatible = true
                break
            end
        end
        if compatible then
            local guns = playerInv:getAllTypeRecurse(gunType)
            for k = 0, guns:size() - 1 do
                local weapon = guns:get(k)
                if weapon and not processedGuns[weapon] and not weapon:isContainsClip() and not weapon:getWeaponPart("Moonclip") and not (magazine:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0) and not (weapon:getMaxAmmo() <= weapon:getCurrentAmmoCount()) then
                    subMenu:addOption(weapon:getDisplayName(), playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, magazine)
                    foundAny = true
                    processedGuns[weapon] = true
                end
            end
        end
    end
    local gunType = magazine:getGunType()
    local OEMGun = nil
    if gunType and type(gunType) == "string" and gunType ~= "" and gunType ~= "null" then
        OEMGun = playerInv:getAllTypeRecurse(gunType)
    end
    if OEMGun then
        for k = 0, OEMGun:size() - 1 do
            local weapon = OEMGun:get(k)
            if weapon and not processedGuns[weapon] and not weapon:isContainsClip() and not weapon:getWeaponPart("Moonclip") and not (magazine:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0) and not (weapon:getMaxAmmo() <= weapon:getCurrentAmmoCount()) then
                subMenu:addOption(weapon:getDisplayName(), playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, magazine)
                foundAny = true
                processedGuns[weapon] = true
            end
        end
    end
    if magazine:hasTag(Gun93Registries.guns93.MoonClip) or magazine:hasTag(Gun93Registries.guns93.SpeedLoader) or magazine:hasTag(Gun93Registries.guns93.StripperClip) or magazine:hasTag(Gun93Registries.guns93.SpeedStrip) then
        if magazine:getCurrentAmmoCount() < 1 then
            foundAny = false
        end
    end
    local insertOption = context:addOption(getText("ContextMenu_InsertMagazine"))
    if foundAny then
        context:addSubMenu(insertOption, subMenu)
    else
        insertOption.notAvailable = true
    end
end

local old_ISInventoryPaneContextMenu_onInsertMagazine = ISInventoryPaneContextMenu.onInsertMagazine
ISInventoryPaneContextMenu.onInsertMagazine = function(playerObj, weapon, magazine)
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ISInventoryPaneContextMenu_onInsertMagazine(playerObj, weapon, magazine)
    end
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, magazine)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    if magazine:hasTag(Gun93Registries.guns93.StripperClip) then
        ISTimedActionQueue.add(ISUnloadRackFirearm:new(playerObj, weapon))
    end
    ISTimedActionQueue.add(ISInsertMagazine:new(playerObj, weapon, magazine));
end