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

local old_ISInventoryPaneContextMenu_onUpgradeWeapon = ISInventoryPaneContextMenu.onUpgradeWeapon
ISInventoryPaneContextMenu.onUpgradeWeapon = function(weapon, part, player)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ISInventoryPaneContextMenu_onUpgradeWeapon(weapon, part, player)
    end
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