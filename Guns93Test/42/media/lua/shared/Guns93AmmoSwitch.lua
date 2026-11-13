function AmmoSwitch(item, index, player)
    if not item or not instanceof(item, "HandWeapon") or not item:isRanged() or not player then return end
    local switchingToAlt = true
    if item:hasTag(Gun93Registries.guns93.AltAmmo) then
        switchingToAlt = false
    end
    local newFullType = switchingToAlt and (item:getFullType() .. "_Alt") or string.gsub(item:getFullType(), "_Alt", "")
    local newItem = instanceItem(newFullType)
    if not newItem then return end
    newItem:setContainsClip(false)
    local remparts = newItem:getAllWeaponParts()
    for i = remparts:size(), 1, -1 do
        local part = remparts:get(i - 1)
        if part then newItem:detachWeaponPart(part) end
    end
    local parts = item:getAllWeaponParts()
    for i = 0, parts:size() - 1 do
        local part = parts:get(i)
        if part then newItem:attachWeaponPart(part) end
    end
    newItem:copyModData(item:getModData())
    newItem:setWeaponSprite(item:getWeaponSprite())
    newItem:setTexture(item:getTexture())
    newItem:setCondition(item:getCondition())
    newItem:setHaveBeenRepaired(item:getHaveBeenRepaired())
    newItem:setBloodLevel(item:getBloodLevel())
    newItem:getModData().mod_fouling = item:getModData().mod_fouling
    newItem:setFavorite(item:isFavorite())
    newItem:setActivated(item:isActivated())
--    newItem:setAttachedSlot(item:getAttachedSlot())
    newItem:setMaxAmmo(item:getMaxAmmo())
    newItem:setCurrentAmmoCount(item:getCurrentAmmoCount())
    if newItem:haveChamber() and item:isRoundChambered() then
        newItem:setRoundChambered(true)
    end
    local baseName = item:getDisplayName()
    local cleanName = baseName:gsub(" %(.+%)", ""):gsub(getText("Tooltip_clothing_bloody"), ""):gsub("^%s+", ""):gsub("%s+$", "")
    local ammoName1 = string.gsub(getItemNameFromFullType(item:getAmmoType():getItemKey()), " Round", "")
    local ammoName2 = string.gsub(getItemNameFromFullType(newItem:getAmmoType():getItemKey()), " Round", "")
    cleanName = string.gsub(cleanName, ammoName1, ammoName2)
    newItem:setName(cleanName)
    local wasPrimary = (player:getPrimaryHandItem() == item)
    local wasSecondary = (player:getSecondaryHandItem() == item)
    local twoHand = wasPrimary and wasSecondary
    if wasPrimary then
        player:setPrimaryHandItem(nil)
        if twoHand then player:setSecondaryHandItem(nil) end
    end
    player:getInventory():AddItem(newItem)
    player:getInventory():Remove(item)
    sendReplaceItemInContainer(player:getInventory(), item, newItem)
	local hotBar = getPlayerHotbar(player:getPlayerNum())
    if hotBar:isInHotbar(item) then -- hotbar
        local itemSlot = item:getAttachedSlot()
        hotBar:removeItem(item, false)
        local slotDef = hotBar.availableSlot[itemSlot].def
        hotBar:attachItem(newItem, slotDef.attachments[newItem:getAttachmentType()], itemSlot, slotDef, false)
        hotBar.needsRefresh = true
        hotBar:update()
    end
    syncHandWeaponFields(player, newItem)
    player:getInventory():setDirty(true)
    return newItem
end

Guns93AmmoSwitchAction = ISBaseTimedAction:derive("Guns93AmmoSwitchAction")

function Guns93AmmoSwitchAction:new(item, index, character)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.index = index
    o.stopOnWalk = false
    o.stopOnRun = true
    o.stopOnAim = false
    o.maxTime = o:getDuration();
    o.caloriesModifier = 0
    o.useProgressBar = false
    o.wasPrimary = character:getPrimaryHandItem() == item
    o.wasSecondary = character:getSecondaryHandItem() == item
    return o
end

function Guns93AmmoSwitchAction:getDuration()
	return 0;
end

function Guns93AmmoSwitchAction:isValid()
    return self.item and self.character:getInventory():contains(self.item) and self.item:getCurrentAmmoCount() == 0 and not self.item:isRoundChambered()
end

function Guns93AmmoSwitchAction:start()
    self.item:setJobType("Switch Ammo Type")
    self.item:setJobDelta(0.0)
end

function Guns93AmmoSwitchAction:perform()
    ISBaseTimedAction.perform(self)
    self.character:resetEquippedHandsModels()
end

function Guns93AmmoSwitchAction:complete()
    local newItem = AmmoSwitch(self.item, self.index, self.character)
    if not newItem then
        return false
    end
    if self.wasPrimary then
        self.character:setPrimaryHandItem(newItem)
        if self.wasSecondary then
            self.character:setSecondaryHandItem(newItem)
        else
            self.character:setSecondaryHandItem(nil)
        end
    end
    ISReloadWeaponAction.BeginAutomaticReload(self.character, newItem)
    self.character:resetEquippedHandsModels()
    return true
end

function Guns93AmmoSwitchAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93AmmoSwitchAction:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

Guns93AmmoSwitch = {}
Guns93AmmoSwitch.callAction = function(item, index, player)
    if not item or not player then return end
    if player:getPrimaryHandItem() ~= item and player:getSecondaryHandItem() ~= item then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 40, true, true))
    end
    if item:isContainsClip() then
        ISTimedActionQueue.add(ISEjectMagazine:new(player, item))
    elseif item:getCurrentAmmoCount() > 0 then
        ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(player, item, false))
    end
    if item:isRoundChambered() then
        ISTimedActionQueue.add(ISRackFirearm:new(player, item))
    end
    ISTimedActionQueue.add(Guns93AmmoSwitchAction:new(item, index, player))
end