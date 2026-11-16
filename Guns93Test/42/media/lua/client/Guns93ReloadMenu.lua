local old_doReloadMenuForWeapon = ISInventoryPaneContextMenu.doReloadMenuForWeapon
function ISInventoryPaneContextMenu.doReloadMenuForWeapon(playerObj, weapon, context)
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_doReloadMenuForWeapon(playerObj, weapon, context)
    end
    local gunData = weapon:getModData()
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
            local round1 = weapon:getAmmoType():getItemKey()
            local round2 = weapon:getModData().modAlt_Ammo
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
                                if Guns93HasMultipleCalibers(mag) then
                                    if not round2 then
                                        noLoad = true
                                    end
                                end
                            end
                            if mag:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0 then
                                noLoad = true
                            end
                            if not noLoad then
                                local magData = mag:getModData()
                                local topRound = nil
                                if magData.Guns93AmmoList then
                                    local list = magData.Guns93AmmoList
                                    if #list ~= 0 then
                                        topRound = list[1].type
                                    end
                                end
                                local ammoCheck = nil
                                if topRound == nil then
                                    ammoCheck = mag:getAmmoType():getItemKey()
                                else
                                    ammoCheck = AmmoStatList[topRound].caliber
                                end
                                if ammoCheck == round1 or ammoCheck == round2 then
                                    local AmmoType = ""
                                    if topRound ~= nil then
                                        AmmoType = " - " .. getItemNameFromFullType(topRound)
                                    end
                                    subMenu:addOption(mag:getDisplayName() .. " (" .. mag:getCurrentAmmoCount() .. "/" .. mag:getMaxAmmo() .. ")" .. AmmoType, playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, mag)
                                    foundAny = true
                                end
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
                            local magData = mag:getModData()
                            local topRound = nil
                            if magData.Guns93AmmoList then
                                local list = magData.Guns93AmmoList
                                if #list ~= 0 then
                                    topRound = list[1].type
                                end
                            end
                            local AmmoType = ""
                            if topRound ~= nil then
                                AmmoType = " - " .. getItemNameFromFullType(topRound)
                            end
                            subMenu:addOption(mag:getDisplayName() .. " (" .. mag:getCurrentAmmoCount() .. "/" .. mag:getMaxAmmo() .. ")" .. AmmoType, playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, mag)
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

local function guns93RoundName(fullType)
    if not fullType then return nil end
    local name = getItemNameFromFullType(fullType)
    if name and name ~= "" then
        return name
    end
    return tostring(fullType)
end

local function guns93TopAmmo(mag, maxRounds)
    maxRounds = maxRounds or 2
    if not mag or maxRounds < 1 then
        return nil
    end
    local list = mag:getModData().Guns93AmmoList
    if not list or #list < 1 then
        return nil
    end
    local roundsDisplayed = "Top Two Rounds:"
    if mag:hasTag(Gun93Registries.guns93.AmmoBox) then
        roundsDisplayed = "Visible Belt:"
    end
    if mag:hasTag(Gun93Registries.guns93.SpeedLoader) or mag:hasTag(Gun93Registries.guns93.StripperClip) or mag:hasTag(Gun93Registries.guns93.SpeedStrip) or mag:hasTag(Gun93Registries.guns93.AmmoBelt) then
        roundsDisplayed = "Rounds Loaded:"
    end
    local lines = {roundsDisplayed}
    local remaining = maxRounds
    for i = 1, #list do
        if remaining <= 0 then
            break
        end
        local entries = list[i]
        if entries and entries.type and (entries.count or 0) > 0 then
            local show = math.min(entries.count or 0, remaining)
            table.insert(lines, string.format("%s x%d", guns93RoundName(entries.type), show))
            remaining = remaining - show
        end
    end
    if #lines == 1 then
        return nil
    end
    return lines
end

local ISToolTipInv_render_Old = ISToolTipInv.render
function ISToolTipInv:render()
    ISToolTipInv_render_Old(self)
    if not self.item or not self.item:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return
    end
    local number = 2
    if self.item:hasTag(Gun93Registries.guns93.AmmoBox) then
        number = 5
    end
    if self.item:hasTag(Gun93Registries.guns93.SpeedLoader) or self.item:hasTag(Gun93Registries.guns93.StripperClip) or self.item:hasTag(Gun93Registries.guns93.SpeedStrip) or self.item:hasTag(Gun93Registries.guns93.AmmoBelt) then
        number = self.item:getMaxAmmo()
    end
    local lines = guns93TopAmmo(self.item, number)
    if not lines or not self.tooltip then
        return
    end
    local font = UIFont.Small
    local fh = getTextManager():getFontHeight(font)
    local pad = 4
    local extra = (#lines * fh) + pad
    local oldH = self.tooltip:getHeight()
    local oldW = self.tooltip:getWidth()
    self.tooltip:setHeight(oldH + extra)
    if self.tooltip.DrawTextureScaledColor then
        self.tooltip:DrawTextureScaledColor(nil, 0, oldH - 1, oldW, extra + 1, 0, 0, 0, 0.8)
    end
    for i, line in ipairs(lines) do
        self.tooltip:DrawText(font, line, 5, oldH + (i - 1) * fh, 0.9, 0.9, 0.9, 1)
    end
end