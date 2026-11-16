function MuzzleDeviceCheck(item)
    if SandboxVars.Guns93.Guns93BayoDistro then return false end
    local canon = item:getWeaponPart("Canon")
    if item:getWeaponPart("Handguard") and item:getWeaponPart("Handguard"):hasTag(ItemTag.Flashlight) then
        return false
    end
    if item:hasTag(Gun93Registries.guns93.BiBayoBlock) then
        if item:getWeaponPart("Handguard") and item:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Bipod) then
            return false
        end
        if item:getWeaponPart("HandguardItem") and item:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Bipod) then
            return false
        end
        if item:getWeaponPart("BarrelItem") and item:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Bipod) then
            return false
        end
    end
    if item:getWeaponPart("BarrelItem") and not item:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Bayonet) then
        return false
    end
    if not canon then
        return true
    end
    if canon:hasTag(Gun93Registries.guns93.Choke) or canon:hasTag(Gun93Registries.guns93.BayoLug) then
        return true
    elseif canon:getModData().isSilencerCon == true or canon:getModData().isMuzzleBrake == true then
        return false
    end
    return false
end

-- Bayonet Toggle
function UseBayonet(weapon, player)    
    local bayo = weapon:getWeaponPart("Bayonet")
    local wasPrimary = (player:getPrimaryHandItem() == weapon)
    local twoHand = (player:getSecondaryHandItem() == weapon)
    if wasPrimary then
        player:setPrimaryHandItem(nil)
        if twoHand then player:setSecondaryHandItem(nil) end
    end
    local newItem = nil
    local md = weapon:getModData()
    local md2 = nil
    if bayo then
        md2 = bayo:getModData()
    end
    if weapon:getSubCategory() == "Firearm" and not weapon:hasTag(Gun93Registries.guns93.BayoUsed) then
        local bladeType = "Base.UseBayoSpike"
        if bayo:hasTag(Gun93Registries.guns93.Sharp) then
            bladeType = "Base.UseBayoBlade"
        end
        newItem = instanceItem(bladeType)
        if newItem then
            newItem:copyModData(md)
            newItem:getModData().isStoreGun = weapon:getFullType()
            if bayo then
                if bayo:hasTag(Gun93Registries.guns93.Sharp) then 
                    newItem:setSharpness(bayo:getSharpness()) 
                end
                newItem:setHeadCondition(bayo:getCondition() * 2)
                newItem:setMaxDamage(md2.BayoMaxDamage or 1.5)
                newItem:setMinDamage(md2.BayoMinDamage or 1)
                newItem:setMaxRange((md2.isbayoRange) + (md.isbayoRange) or 0.6)
            end
            newItem:setAmmoType(weapon:getAmmoType())
            newItem:setAmmoBox(weapon:getAmmoBox())
            newItem:setWeaponReloadType(weapon:getWeaponReloadType())
            newItem:setModelWeaponPart(weapon:getModelWeaponPart())
            newItem:setWeight(weapon:getWeight())
            local baseSpeed = 3 - (weapon:getWeight()/2)
            if baseSpeed < 0.5 then
                baseSpeed = 0.5
            elseif baseSpeed > 1 then
                baseSpeed = 1
            end
            newItem:setBaseSpeed(baseSpeed)
        end
    elseif weapon:getSubCategory() == "Stab" and weapon:hasTag(Gun93Registries.guns93.BayoUsed) then
        local storedType = md.isStoreGun
        if not storedType then return end
        newItem = instanceItem(storedType)
        if newItem then
            local parts = newItem:getAllWeaponParts()
            for i = parts:size() - 1, 0, -1 do
                newItem:detachWeaponPart(parts:get(i))
            end
            newItem:copyModData(md)
            newItem:setCondition(weapon:getCondition())
            if bayo and weapon:hasTag(Gun93Registries.guns93.Sharp) then 
                bayo:setSharpness(weapon:getSharpness()) 
            end
            newItem:getModData().isStoreGun = nil
        end
    end
    if newItem then
        local itemParts = weapon:getAllWeaponParts()
        for i = itemParts:size() - 1, 0, -1 do
            local part = itemParts:get(i)
            weapon:detachWeaponPart(part)
            newItem:attachWeaponPart(part)
        end
        if weapon:getMagazineType() then
            newItem:setMagazineType(weapon:getMagazineType())
            if weapon:isContainsClip() then 
                newItem:setContainsClip(true) 
            else
                newItem:setContainsClip(false)
            end
        end
        if md.Guns93Chambered then
            newItem:getModData().Guns93Chambered = md.Guns93Chambered
        end
        if md.Guns93AmmoList then
            newItem:getModData().Guns93AmmoList = md.Guns93AmmoList
        end
        if md.Guns93SpentList then
            newItem:getModData().Guns93SpentList = md.Guns93SpentList
        end
        newItem:setMaxAmmo(weapon:getMaxAmmo())
        newItem:setWeaponSprite(weapon:getWeaponSprite())
        newItem:setTexture(weapon:getTexture())
        if md.Guns93Icon ~= nil then
            if not isClient() then
                newItem:getModData().Guns93Icon = md.Guns93Icon
            end
            if isClient() then
                newItem:setTexture(getTexture("media/textures/item_" .. md.Guns93Icon .. ".png"))
            end
        end
        newItem:setCondition(weapon:getCondition())
        newItem:setHaveBeenRepaired(weapon:getHaveBeenRepaired())
        newItem:setBloodLevel(weapon:getBloodLevel())
        newItem:getModData().mod_fouling = md.mod_fouling
        newItem:setFavorite(weapon:isFavorite())
        newItem:setActivated(weapon:isActivated())
        newItem:setCurrentAmmoCount(weapon:getCurrentAmmoCount())
        if newItem:haveChamber() and weapon:isRoundChambered() then
            newItem:setRoundChambered(true)
        end
        local newName = weapon:getDisplayName()
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_dull"), "")
        newName = string.gsub(newName, getText("Tooltip_blunt"), "")
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_clothing_bloody"), "")
        newItem:setName(newName)
        player:getInventory():AddItem(newItem)
        player:getInventory():Remove(weapon)
        sendReplaceItemInContainer(player:getInventory(), weapon, newItem)
        replaceItemInContainer(player:getInventory(), weapon, newItem)
        if wasPrimary then
            player:setPrimaryHandItem(newItem)
            player:setSecondaryHandItem(newItem)
        end
        if weapon:getAttachedSlot() > 0 then
            if not isServer() then
                local hotBar = getPlayerHotbar(player:getPlayerNum())
                if hotBar:isInHotbar(weapon) then
                    local itemSlot = weapon:getAttachedSlot()
                    hotBar:removeItem(weapon, false)
                    local slotDef = hotBar.availableSlot[itemSlot].def
                    hotBar:attachItem(newItem, slotDef.attachments[newItem:getAttachmentType()], itemSlot, slotDef, false)
                    hotBar.needsRefresh = true
                    hotBar:update()
                end
            elseif isServer() then
                newItem:setAttachedSlot(weapon:getAttachedSlot())
                sendServerCommand(player, "bayonet", "hotbar", {itemID = newItem:getID(), slotIndex = newItem:getAttachedSlot()})
            end
        end
        return newItem
    end
end

Guns93UseBayonet = {}

Guns93UseBayonet.callAction = function(item, index, player)
    if not item or not player then return end
    if player:getPrimaryHandItem() ~= item and player:getSecondaryHandItem() ~= item then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 50, true, true))
    end
    ISTimedActionQueue.add(Guns93UseBayonetAction:new(item, index, player))
end

Guns93UseBayonetAction = ISBaseTimedAction:derive("Guns93UseBayonetAction")

function Guns93UseBayonetAction:new(item, index, character)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.index = index
    o.stopOnWalk = false
    o.stopOnRun = false
    o.stopOnAim = false
    o.maxTime = o:getDuration()
    o.caloriesModifier = 6
    o.useProgressBar = false
    return o
end

function Guns93UseBayonetAction:getDuration()
    return 0
end

function Guns93UseBayonetAction:isValid()
    if not self.item then return false end
    local bayo = self.item:getWeaponPart("Bayonet")
    if not bayo then return false end
    if self.item:getModData().modBayo_Con == 1 then
        getPlayer():setHaloNote("Bayonet Is Broken!")
        return false
    end
    return true
end

function Guns93UseBayonetAction:start()
    self.item:setJobType("Toggle Bayonet Use")
    self.item:setJobDelta(0.0)
end

function Guns93UseBayonetAction:perform()
    ISBaseTimedAction.perform(self)
    self.character:resetEquippedHandsModels()
end

function Guns93UseBayonetAction:complete()
    local getIcon = self.item:getIcon()
    local newItem = UseBayonet(self.item, self.character)
    if newItem then
        self.character:setPrimaryHandItem(newItem)
        self.character:setSecondaryHandItem(newItem)
        syncItemModData(self.character, newItem)
        syncHandWeaponFields(self.character, newItem)
    end
    if isServer() then
        sendServerCommand("bayonet", "toggle", {playerOnlineID = self.character:getOnlineID(), storeGun = newItem:getModData().isStoreGun, itemID = newItem:getID(), itemTex = newItem:getModData().Guns93Icon or getIcon})
    end
    return true
end

function Guns93UseBayonetAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93UseBayonetAction:stop()
    self.character:resetEquippedHandsModels()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if not player then return end
    local item = player:getPrimaryHandItem()
    if item and (item:getFullType() == "Base.UseBayoBlade" or item:getFullType() == "Base.UseBayoSpike") then
        ISTimedActionQueue.add(Guns93UseBayonetAction:new(item, nil, player))
    end
end)

-- Attach/Detach Bayonet

Guns93FixBayonet = {}

Guns93FixBayonet.callAction = function(item, index, player, bayo)
    ISInventoryPaneContextMenu.transferIfNeeded(player, item)
    ISInventoryPaneContextMenu.transferIfNeeded(player, bayo)
    if not item or not bayo then return end
    if item:getSubCategory() == "Stab" and item:hasTag(Gun93Registries.guns93.BayoUsed) then
        ISTimedActionQueue.add(Guns93UseBayonetAction:new(item, index, player))
    end
    ISTimedActionQueue.add(Guns93FixBayonetAction:new(item, index, player, bayo))
end

Guns93FixBayonetAction = ISBaseTimedAction:derive("Guns93FixBayonetAction")

function Guns93FixBayonetAction:new(item, index, character, bayo)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.index = index
    o.bayo = bayo
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration()
    o.caloriesModifier = 6
    o.useProgressBar = false
    return o
end

function Guns93FixBayonetAction:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return 60
end

function Guns93FixBayonetAction:isValid()
    return self.item and self.character:getInventory():contains(self.item)
end

function Guns93FixBayonetAction:start()
    self.item:setJobType("Add/Remove Bayonet")
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93FixBayonetAction:perform()
    self.item:setJobDelta(0.0)
    ISBaseTimedAction.perform(self)
    self.character:resetEquippedHandsModels()
end

function Guns93FixBayonetAction:complete()
    local gunItem = nil
    local wasPrimary = self.character:getPrimaryHandItem()
    local wasSecondary = self.character:getSecondaryHandItem()
    if self.item:getSubCategory() == "Stab" and self.item:hasTag(Gun93Registries.guns93.BayoUsed) then
        gunItem = UseBayonet(self.item, self.character)
    else
        gunItem = self.item
    end
    if gunItem then
        local bayoPart = gunItem:getWeaponPart("Bayonet")
        if not bayoPart then
            if not MuzzleDeviceCheck(gunItem) or not self.bayo then return end
            local newPart = instanceItem(self.bayo:getFullType() .. "Part")
            if self.bayo:hasTag(Gun93Registries.guns93.Sharp) then
                newPart:setSharpness(self.bayo:getSharpness()) 
            end
            newPart:setCondition(self.bayo:getCondition()) 
            if self.bayo:getBloodLevel() > gunItem:getBloodLevel() then
                gunItem:setBloodLevel(self.bayo:getBloodLevel())
            end
            gunItem:attachWeaponPart(newPart)
            self.character:getInventory():Remove(self.bayo)
            sendRemoveItemFromContainer(self.character:getInventory(), self.bayo)
        else
            local detachedType = string.gsub(bayoPart:getFullType(), "Part$", "")
            local removedBayo = instanceItem(detachedType)
            if bayoPart:hasTag(Gun93Registries.guns93.Sharp) then 
                removedBayo:setSharpness(bayoPart:getSharpness()) 
            end
            removedBayo:setCondition(bayoPart:getCondition()) 
            removedBayo:setBloodLevel(gunItem:getBloodLevel())
            gunItem:detachWeaponPart(bayoPart)
            self.character:getInventory():AddItem(removedBayo)
            sendAddItemToContainer(self.character:getInventory(), removedBayo)
        end
        syncItemModData(self.character, gunItem)
        syncHandWeaponFields(self.character, gunItem)
    end
    self.character:setSecondaryHandItem(gunItem)
    self.character:setPrimaryHandItem(gunItem)
    self.character:resetEquippedHandsModels()
    return true
end

function Guns93FixBayonetAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93FixBayonetAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0)
end

-- Fold/Unfold Bayonet
Guns93FoldBayo = {}

Guns93FoldBayo.callAction = function(item, index, player, bayo)
    if not item or not player then return end
    if player:getPrimaryHandItem() ~= item and player:getSecondaryHandItem() ~= item then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 50, true, true))
    end
    ISTimedActionQueue.add(Guns93FoldBayoAction:new(item, index, player, bayo))
end

Guns93FoldBayoAction = ISBaseTimedAction:derive("Guns93FoldBayoAction")

function Guns93FoldBayoAction:new(item, index, character, bayo)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.index = index
    o.bayo = bayo
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration()
    o.caloriesModifier = 1
    o.useProgressBar = false
    return o
end

function Guns93FoldBayoAction:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return 15
end

function Guns93FoldBayoAction:isValid()
    if self.item and self.character:getInventory():contains(self.item) and self.item:getWeaponPart("Bayonet") then
        return true
    else
        return false
    end
end

function Guns93FoldBayoAction:start()
    self.item:setJobType("Unfold/Fold Bayonet")
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93FoldBayoAction:perform()
    self.item:setJobDelta(0.0)
    ISBaseTimedAction.perform(self)
    self.character:resetEquippedHandsModels()
end

function Guns93FoldBayoAction:complete()
    if not MuzzleDeviceCheck(self.item) then return true end
    local bayoPart = self.item:getWeaponPart("Bayonet")
    if not bayoPart then return true end
    local newType = nil
    if bayoPart:hasTag(Gun93Registries.guns93.BayoFolded) then
        newType = string.gsub(bayoPart:getFullType(), "Part$", "") .. "Out"
    else
        newType = string.gsub(bayoPart:getFullType(), "Out$", "") .. "Part"
    end
    if newType then
        local newPart = instanceItem(newType)
        if bayoPart:hasTag(Gun93Registries.guns93.Sharp) then 
            newPart:setSharpness(bayoPart:getSharpness()) 
        end
        newPart:setCondition(bayoPart:getCondition())
        self.item:detachWeaponPart(bayoPart)
        self.item:attachWeaponPart(newPart)
        syncItemModData(self.character, self.item)
        syncHandWeaponFields(self.character, self.item)
        self.character:getInventory():setDirty(true)
        if self.item:hasTag(Gun93Registries.guns93.BayoUsed) then
            UseBayonet(self.item, self.character)
        end
    end
    self.character:resetEquippedHandsModels()
    return true
end

function Guns93FoldBayoAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93FoldBayoAction:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

-- Hotkey
local UseBayonetHotkey = {}

function UseBayonetHotkey.ToggleBayonet()
    local player = getPlayer()
    if not player then return end
    local item = player:getPrimaryHandItem()
    if not item or not instanceof(item, "HandWeapon") then return end
    local bayo = item:getWeaponPart("Bayonet")
    if not bayo or bayo:hasTag(Gun93Registries.guns93.BayoFolded) then return end
	ISTimedActionQueue.add(Guns93UseBayonetAction:new(item, item:getWeaponPart("Bayonet"), player, CharacterActionAnims.Craft, 0))
end

function UseBayonetHotkey.addHotkey()
    table.insert(keyBinding, { value = "UseBayonet_Toggle", key = Keyboard.KEY_Z })
end

function UseBayonetHotkey.onKeyPressed(key)
    local player = getPlayer()
    if not player then return end
    local item = player:getPrimaryHandItem()
    if not item or not instanceof(item, "HandWeapon") then return end
    local bayo = item:getWeaponPart("Bayonet")
    if not bayo then return end
    if player:isItemInBothHands(item) and not bayo:hasTag(Gun93Registries.guns93.BayoFolded) then
        if key == getCore():getKey("UseBayonet_Toggle") then
            UseBayonetHotkey.ToggleBayonet()
        end
    end
end

UseBayonetHotkey.addHotkey()
Events.OnKeyPressed.Add(UseBayonetHotkey.onKeyPressed)

return UseBayonetHotkey