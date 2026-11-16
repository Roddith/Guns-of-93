local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local MAXIMUM_RENAME_LENGTH = 28

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

local ISInventoryPaneContextMenu_onChangefiremode_old = ISInventoryPaneContextMenu.onChangefiremode
ISInventoryPaneContextMenu.onChangefiremode = function(playerObj, weapon, newfiremode)
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return ISInventoryPaneContextMenu_onChangefiremode_old(playerObj, weapon, newfiremode)
    else
        weapon:setFireMode(newfiremode);
--        playerObj:setVariable("FireMode", newfiremode);
        GunStatAdjust(playerObj, weapon)
    end
end

local ISInventoryPaneContextMenu_doChangeFireModeMenu_old = ISInventoryPaneContextMenu.doChangeFireModeMenu
ISInventoryPaneContextMenu.doChangeFireModeMenu = function(playerObj, weapon, context)
    local fireOp = false
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return ISInventoryPaneContextMenu_doChangeFireModeMenu_old(playerObj, weapon, context)
    elseif weapon:hasTag(Gun93Registries.guns93.ReqTrigger) then
        if weapon:getWeaponPart("Trigger") then
            if not weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.AutoOnly) then
                if weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.Fullauto) or weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.Burst) then
                    fireOp = true
                end
            end
        end
        if weapon:getWeaponPart("AutoPart") then
            if not weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.AutoOnly) then
                if weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.Fullauto) or weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.Burst) then
                    fireOp = true
                end
            end
        end
    elseif not weapon:hasTag(Gun93Registries.guns93.ReqTrigger) then
        fireOp = true
    end
    if fireOp then
        local firemodeOption = context:addOption(getText("ContextMenu_ChangeFireMode"))
        local subMenuFiremode = context:getNew(context)
        context:addSubMenu(firemodeOption, subMenuFiremode)
        for i=0, weapon:getFireModePossibilities():size() - 1 do
            local firemode = weapon:getFireModePossibilities():get(i);
            if firemode ~= weapon:getFireMode() then
                if not weapon:hasTag(Gun93Registries.guns93.ReqTrigger) then
                    subMenuFiremode:addOption(getText("ContextMenu_FireMode_" .. firemode), playerObj, ISInventoryPaneContextMenu.onChangefiremode, weapon, firemode);
                else
                    local autoPart = weapon:getWeaponPart("AutoPart") or weapon:getWeaponPart("Trigger")
                    local auto = "Auto"
                    local burst = "Burst"
                    local context = firemode
                    if autoPart then
                        if autoPart:hasTag(Gun93Registries.guns93.Fullauto) then
                            auto = "nil"
                        end
                        if autoPart:hasTag(Gun93Registries.guns93.Burst) then
                            burst = "nil"
                        end
                    end
                    if firemode ~= auto and firemode ~= weapon:getFireMode() and firemode ~= burst then
                        if firemode == "Burst" then
                            local burstNum = autoPart:getModData().modBurst_Num
                            if burstNum then
                                if burstNum == 2 then
                                    context = "Burst2"
                                elseif burstNum == 3 then
                                    context = "Burst3"
                                elseif burstNum > 3 then
                                    context = "Burst4"
                                end
                            end
                        end
                        subMenuFiremode:addOption(getText("ContextMenu_FireMode_" .. context), playerObj, ISInventoryPaneContextMenu.onChangefiremode, weapon, firemode);
                    end
                end
            end
        end
    end
end

function guns93SendLoadIntent(player, item, round, round2, bycaliber, amount)
    local args = {itemID = item:getID(), round = round and tostring(round) or nil, round2 = round2 and tostring(round2) or nil, bycaliber = bycaliber and true or false, amount = amount}
    if isClient() then
        sendClientCommand("Guns93", "SetLoadIntent", args)
    end
end

local old_ISInventoryPaneContextMenu_doMagazineMenu_old = ISInventoryPaneContextMenu.doMagazineMenu
ISInventoryPaneContextMenu.doMagazineMenu = function(playerObj, magazine, context)
    if not magazine or not magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return old_ISInventoryPaneContextMenu_doMagazineMenu_old(playerObj, magazine, context)
    end
    if magazine:getCurrentAmmoCount() < magazine:getMaxAmmo() then
        local bulletNeeded = magazine:getMaxAmmo() - magazine:getCurrentAmmoCount()
        local bulletAvail = 0
        local bullets = ArrayList.new()
        local byType = {}
        local primCaliber = magazine:getAmmoType():getItemKey()
        local secCaliber = "none"
        local magData = magazine:getModData()
        local linkType = false
        local linkNum = false
        if magData and magData.modAlt_Ammo then
            secCaliber = magData.modAlt_Ammo
        end
        playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
        if magazine:hasTag(Gun93Registries.guns93.AmmoBelt) then
            linkType = magData.needLink
            linkNum = playerObj:getInventory():getItemCountRecurse(linkType)
        end
        for i = 0, bullets:size() - 1 do
            local round = bullets:get(i)
            local roundData = round:getModData()
            if roundData and roundData.isCaliber then
                if roundData.isCaliber == primCaliber or roundData.isCaliber == secCaliber or round:getFullType() == primCaliber or round:getFullType() == secCaliber then
                    bulletAvail = bulletAvail + 1
                    local fullType = round:getFullType()
                    local entry = byType[fullType]
                    if not entry then
                        entry = {count = 0, displayName = round:getDisplayName()}
                        byType[fullType] = entry
                    end
                    entry.count = entry.count + 1
                end
            end
        end
        local insertText = getText("Insert Ammunition", magazine:getDisplayName())
        local insertOption = context:addOption(insertText)
        local subMenu = ISContextMenu:getNew(context)
        context:addSubMenu(insertOption, subMenu)
        local any = false
        if bulletNeeded > 0 and bulletAvail > 0 then
            local typeCount = 0
            for _ in pairs(byType) do 
                typeCount = typeCount + 1 
            end
            if typeCount > 1 then
                local addText = "Load "
                if linkType then
                    if bulletNeeded > linkNum then
                        bulletNeeded = linkNum
                    end
                    addText = "Link "
                end
                if bulletAvail < bulletNeeded then
                    bulletNeeded = bulletAvail
                end
                if bulletNeeded > 0 then
                    subMenu:addOption(addText .. bulletNeeded .. " Of Any Type", playerObj, ISInventoryPaneContextMenu.onLoadBulletsInMagazine, magazine, primCaliber, bulletNeeded, true)
                    any = true
                end
            end
        end
        for fullType, info in pairs(byType) do
            if info.count > 0 then
                any = true
                local addText = "Load "
                if linkType then
                    if bulletNeeded > linkNum then
                        bulletNeeded = linkNum
                    end
                    addText = "Link "
                end
                local loadCount = info.count
                if loadCount > bulletNeeded then
                    loadCount = bulletNeeded
                end
                if bulletNeeded > 0 then
                    subMenu:addOption(addText .. loadCount .. " " .. info.displayName, playerObj, ISInventoryPaneContextMenu.onLoadBulletsInMagazine, magazine, fullType, bulletNeeded, false)
                    any = true
                end
            end
        end
        if bulletNeeded < 1 or not any then
            insertOption.notAvailable = true
        end
        if linkType and linkNum < 1 then
            insertOption.notAvailable = true
        end
    end
    if magazine:getCurrentAmmoCount() > 0 then
        context:addOption(getText("ContextMenu_UnloadMagazine"), playerObj, ISInventoryPaneContextMenu.onUnloadBulletsFromMagazine, magazine);
    end
end

local old_ISInventoryPaneContextMenu_onLoadBulletsInMagazine_old = ISInventoryPaneContextMenu.onLoadBulletsInMagazine
ISInventoryPaneContextMenu.onLoadBulletsInMagazine = function(playerObj, magazine, round, ammoCount, bycaliber)
    if not magazine or not magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return old_ISInventoryPaneContextMenu_onLoadBulletsInMagazine_old(playerObj, magazine, ammoCount)
    end
    local round2 = nil
    local magData = magazine:getModData()
    if magData and magData.modAlt_Ammo then
        round2 = magData.modAlt_Ammo
    end
    local ammoNeeded = magazine:getMaxAmmo() - magazine:getCurrentAmmoCount()
    if ammoNeeded < 1 then
        return
    end
    local linkType = nil
    local linkNum = nil
    if magazine:hasTag(Gun93Registries.guns93.AmmoBelt) then
        linkType = magData.needLink
        linkNum = playerObj:getInventory():getItemCountRecurse(linkType)
    end
    if bycaliber == true then
        local bullets = ArrayList.new()
        playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
        local doneList = {}
        for i = 0, bullets:size() - 1 do
            local bullet = bullets:get(i)
            local roundData = bullet:getModData()
            if roundData and roundData.isCaliber then
                local caliber = roundData.isCaliber
                if caliber == round or caliber == round2 or bullet:getFullType() == round or bullet:getFullType() == round2 then
                    local fullType = bullet:getFullType()
                    if not doneList[fullType] then
                        doneList[fullType] = true
                        local ammoReturn = ISInventoryPaneContextMenu.transferBullets(playerObj, fullType, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
                        if linkType then
                            local links = playerObj:getInventory():getSomeTypeRecurse(linkType, ammoReturn)
                            ISInventoryPaneContextMenu.transferIfNeeded(playerObj, links)
                        end
                        ammoNeeded = ammoNeeded - ammoReturn
                        if ammoNeeded < 1 then
                            break
                        end
                    end
                end
            end
        end
        if linkType then
            if ammoCount > linkNum then
                ammoCount = linkNum
            end
        end
        guns93SendLoadIntent(playerObj, magazine, round, round2, true, ammoCount)
        local action = ISLoadBulletsInMagazine:new(playerObj, magazine, ammoCount)
        action.round = round
        action.round2 = round2
        action.bycaliber = true
        ISTimedActionQueue.add(action)
    else
        ISInventoryPaneContextMenu.transferBullets(playerObj, round, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
        if linkType then
            if ammoCount > linkNum then
                ammoCount = linkNum
            end
        end
        guns93SendLoadIntent(playerObj, magazine, round, nil, false, ammoCount)
        local action = ISLoadBulletsInMagazine:new(playerObj, magazine, ammoCount)
        action.round = round
        action.round2 = nil
        action.bycaliber = false
        ISTimedActionQueue.add(action)
    end
end

local old_ISInventoryPaneContextMenu_doBulletMenu_old = ISInventoryPaneContextMenu.doBulletMenu
ISInventoryPaneContextMenu.doBulletMenu = function(playerObj, weapon, context)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ISInventoryPaneContextMenu_doBulletMenu_old(playerObj, weapon, context)
    end
    local bulletNeeded = weapon:getMaxAmmo() - weapon:getCurrentAmmoCount()
    local bulletAvail = 0
    local bullets = ArrayList.new()
    local byType = {}
    local primCaliber = weapon:getAmmoType():getItemKey()
    local secCaliber = "none"
    local gunData = weapon:getModData()
    if gunData and gunData.modAlt_Ammo then
        secCaliber = gunData.modAlt_Ammo
    end
    playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
    for i = 0, bullets:size() - 1 do
        local round = bullets:get(i)
        local roundData = round:getModData()
        if roundData and roundData.isCaliber then
            if roundData.isCaliber == primCaliber or roundData.isCaliber == secCaliber or round:getFullType() == primCaliber or round:getFullType() == secCaliber then
                bulletAvail = bulletAvail + 1
                local fullType = round:getFullType()
                local entry = byType[fullType]
                if not entry then
                    entry = {count = 0, displayName = round:getDisplayName()}
                    byType[fullType] = entry
                end
                entry.count = entry.count + 1
            end
        end
    end
    local insertText = getText("Insert Ammunition", weapon:getDisplayName())
    local insertOption = context:addOption(insertText)
    local subMenu = ISContextMenu:getNew(context)
    context:addSubMenu(insertOption, subMenu)
    local any = false
    if bulletNeeded > 0 and bulletAvail > 0 then
        local typeCount = 0
        for _ in pairs(byType) do 
            typeCount = typeCount + 1 
        end
        if typeCount > 1 then
            if bulletAvail < bulletNeeded then
                bulletNeeded = bulletAvail
            end
            subMenu:addOption("Load " .. bulletNeeded .. " Of Any Type", playerObj, ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm, weapon, primCaliber, true)
            any = true
        end
    end
    for fullType, info in pairs(byType) do
        if info.count > 0 then
            any = true
            local loadCount = info.count
            if loadCount > bulletNeeded then
                loadCount = bulletNeeded
            end
            subMenu:addOption("Load " .. loadCount .. " " .. info.displayName, playerObj, ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm, weapon, fullType, false)
            any = true
        end
    end
    if bulletNeeded <= 0 or not any then
        insertOption.notAvailable = true
        subMenu.notAvailable = true
    end
    if weapon:getCurrentAmmoCount() > 0 then
        context:addOption(getText("ContextMenu_UnloadRounds", weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onUnloadBulletsFromFirearm, weapon)
    end
end

local old_ISInventoryPaneContextMenu_onLoadBulletsIntoFirearm_old = ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm
ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm = function(playerObj, weapon, round, bycaliber)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ISInventoryPaneContextMenu_onLoadBulletsIntoFirearm_old(playerObj, weapon)
    end
    local round2 = nil
    local gunData = weapon:getModData()
    if gunData and gunData.modAlt_Ammo then
        round2 = gunData.modAlt_Ammo
    end
    local ammoNeeded = weapon:getMaxAmmo() - weapon:getCurrentAmmoCount()
    if ammoNeeded < 1 then
        return
    end
    if bycaliber == true then
        local bullets = ArrayList.new()
        playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
        local doneList = {}
        for i = 0, bullets:size() - 1 do
            local bullet = bullets:get(i)
            local roundData = bullet:getModData()
            if roundData and roundData.isCaliber then
                local caliber = roundData.isCaliber
                if caliber == round or caliber == round2 or bullet:getFullType() == round or bullet:getFullType() == round2 then
                    local fullType = bullet:getFullType()
                    if not doneList[fullType] then
                        doneList[fullType] = true
                        local ammoReturn = ISInventoryPaneContextMenu.transferBullets(playerObj, fullType, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
                        ammoNeeded = ammoNeeded - ammoReturn
                        if ammoNeeded < 1 then
                            break
                        end
                    end
                end
            end
        end
        guns93SendLoadIntent(playerObj, weapon, round, round2, true, weapon:getMaxAmmo() - weapon:getCurrentAmmoCount())
        ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
        local action = ISReloadWeaponAction:new(playerObj, weapon)
        action.round = round
        action.round2 = round2
        action.bycaliber = true
        ISTimedActionQueue.add(action)
    else
        guns93SendLoadIntent(playerObj, weapon, round, nil, false, weapon:getMaxAmmo() - weapon:getCurrentAmmoCount())
        ISInventoryPaneContextMenu.transferBullets(playerObj, round, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
        ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
        local action = ISReloadWeaponAction:new(playerObj, weapon)
        action.round = round
        action.round2 = nil
        action.bycaliber = false
        ISTimedActionQueue.add(action)
    end
end

local old_ISInventoryPaneContextMenu_onUpgradeWeapon = ISInventoryPaneContextMenu.onUpgradeWeapon
ISInventoryPaneContextMenu.onUpgradeWeapon = function(weapon, part, player)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ISInventoryPaneContextMenu_onUpgradeWeapon(weapon, part, player)
    end
    local gunData = weapon:getModData()
    local isPrimary = false
    local isSecondary = false
    if player:getSecondaryHandItem() == weapon then
        isSecondary = true
    end
    if player:getPrimaryHandItem() == weapon then
        isPrimary = true
    end
    player:setSecondaryHandItem(nil)
    player:setPrimaryHandItem(nil)
    local quickMount = false
    if part:hasTag(Gun93Registries.guns93.QDMount) then
        quickMount = true
    end
    ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
    ISInventoryPaneContextMenu.transferIfNeeded(player, part)
    local hasScrewdriver = player:getInventory():getFirstTagEvalRecurse(ItemTag.SCREWDRIVER, predicateNotBroken)
    local hasWrench = player:getInventory():getFirstTagEvalRecurse(ItemTag.WRENCH, predicateNotBroken)
    local useTool = false
    if part:hasTag(Gun93Registries.guns93.UseDriver) then
        useTool = hasScrewdriver
    elseif part:hasTag(Gun93Registries.guns93.UseWrench) then
        useTool = hasWrench
    end
    if useTool then
        ISInventoryPaneContextMenu.equipWeapon(useTool, true, false, player:getPlayerNum());
    end
    ISTimedActionQueue.add(ISUpgradeWeapon:new(player, weapon, part));
    syncHandWeaponFields(player, weapon)
    if quickMount and isPrimary then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, weapon, 1, isPrimary, isSecondary))
    end
    player:resetEquippedHandsModels()
end

local ISInventoryPaneContextMenu_onRemoveUpgradeWeapon_old = ISInventoryPaneContextMenu.onRemoveUpgradeWeapon
ISInventoryPaneContextMenu.onRemoveUpgradeWeapon = function(weapon, part, player)
    if weapon:hasTag(Gun93Registries.guns93.Guns93) then
        local hasScrewdriver = player:getInventory():getFirstTagEvalRecurse(ItemTag.SCREWDRIVER, predicateNotBroken)
        local hasWrench = player:getInventory():getFirstTagEvalRecurse(ItemTag.WRENCH, predicateNotBroken)
        local Scope = nil
        local Pad = nil
        local Stockitem = nil
        local HandguardItem =nil
        local GripOption = nil
        local partRem = false
        local hasTool = nil
        local isPrimary = false
        local isSecondary = false
        if player:getSecondaryHandItem() == weapon then
            isSecondary = true
        end
        if player:getPrimaryHandItem() == weapon then
            isPrimary = true
        end
        player:setSecondaryHandItem(nil)
        player:setPrimaryHandItem(nil)
        local quickMount = false
        if part:hasTag(Gun93Registries.guns93.QDMount) then
            quickMount = true
        end
        ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
        if part:hasTag(Gun93Registries.guns93.UseWrench) then
            if hasWrench then
                partRem = true
                hasTool = hasWrench
            end
        end
        if part:hasTag(Gun93Registries.guns93.NoScrewdriver) then
            partRem = true
        end				
        if part:hasTag(Gun93Registries.guns93.UseDriver) then
            if hasScrewdriver then
                partRem = true
                hasTool = hasScrewdriver
            end
        end
        if partRem then
            if part ~= weapon:getWeaponPart("Scope") then
                if (part:hasTag(Gun93Registries.guns93.ScopeRail) or part:hasTag(Gun93Registries.guns93.PistolRail)) and weapon:getWeaponPart("Scope") then
                    Scope = weapon:getWeaponPart("Scope")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, Scope:getPartType()));
                end
            end
            if part ~= weapon:getWeaponPart("Scope2") then
                if (part:hasTag(Gun93Registries.guns93.ScopeRail) or part:hasTag(Gun93Registries.guns93.PistolRail)) and weapon:getWeaponPart("Scope2") then
                    Scope = weapon:getWeaponPart("Scope2")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, Scope:getPartType()));
                end
            end
            if part ~= weapon:getWeaponPart("RecoilPad") then
                if part:hasTag(Gun93Registries.guns93.RecoilPad) and weapon:getWeaponPart("RecoilPad") then
                    Pad = weapon:getWeaponPart("RecoilPad")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, Pad:getPartType()));
                end
            end
            if part ~= weapon:getWeaponPart("Stockitem") then
                if (part:hasTag(Gun93Registries.guns93.Stockitem) or part:hasTag(Gun93Registries.guns93.StockitemMag)) and weapon:getWeaponPart("Stockitem") then
                    Stockitem = weapon:getWeaponPart("Stockitem")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, Stockitem:getPartType()));
                end
            end
            if part ~= weapon:getWeaponPart("HandguardItem") then
                if part:hasTag(Gun93Registries.guns93.HandguardItem) and weapon:getWeaponPart("HandguardItem") then
                    HandguardItem = weapon:getWeaponPart("HandguardItem")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, HandguardItem:getPartType()));
                end
            end
            if part ~= weapon:getWeaponPart("GripOption") then
                if part:hasTag(Gun93Registries.guns93.TGrip) and weapon:getWeaponPart("GripOption") then
                    GripOption = weapon:getWeaponPart("GripOption")
                    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, GripOption:getPartType()));
                end
            end
            if hasTool ~= nil then
                ISInventoryPaneContextMenu.equipWeapon(hasTool, true, false, player:getPlayerNum());
            end
            if part == weapon:getWeaponPart("BarrelItem") or part == weapon:getWeaponPart("MagExten") then
                if part:hasTag(Gun93Registries.guns93.Guns93Mag) or part:hasTag(Gun93Registries.guns93.MagExten) then
                    ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(player, weapon))
                end
            end
            ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(player, weapon, part:getPartType()));
        end
        if part:getPartType() == "Trigger" then
            weapon:getModData()["FireModePossibilities"] = "Safe"
            weapon:setFireMode("Safe");
        end
        syncHandWeaponFields(player, weapon)
        if quickMount and isPrimary then
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, weapon, 1, isPrimary, isSecondary))
        end
        player:resetEquippedHandsModels()
	else
		return ISInventoryPaneContextMenu_onRemoveUpgradeWeapon_old(weapon, part, player)
	end
end

ISInventoryPaneContextMenu_buildFixingMenu_Old = ISInventoryPaneContextMenu.buildFixingMenu
ISInventoryPaneContextMenu.buildFixingMenu = function(brokenObject, player, fixing, fixingNum, fixOption, subMenuFix, vehiclePart)
    if brokenObject then
        if brokenObject:hasTag(Gun93Registries.guns93.Guns93) then
            return
        else
            return ISInventoryPaneContextMenu_buildFixingMenu_Old(brokenObject, player, fixing, fixingNum, fixOption, subMenuFix, vehiclePart)
        end
    end
end