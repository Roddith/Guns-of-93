require "ISUI/ISInventoryPaneContextMenu"

local function ItemActivation(weapon, itemFullType, player)
    local item = nil
    local parts = weapon:getAllWeaponParts()
    for i = 0, parts:size() - 1 do
        local part = parts:get(i)
        if part and part:getFullType() == itemFullType then
            item = part
            break
        end
    end
    if not item then return end
    local canToggle = true
    if item and item:getCurrentUses() then
        if item:getCurrentUses() <= 0 then
            canToggle = false
        end
    end
    if not canToggle then return end
    local newType = nil
    if item:hasTag(Gun93Registries.guns93.ToggleItemOff) then
        newType = string.gsub(item:getFullType(), "_On$", "")
    elseif item:hasTag(Gun93Registries.guns93.ToggleItemOn) then
        newType = item:getFullType() .. "_On"
    end
    if newType then
        local newPart = instanceItem(newType)
        newPart:setCurrentUses(item:getCurrentUses())
        weapon:detachWeaponPart(item)
        weapon:attachWeaponPart(newPart)
        if item:hasTag(Gun93Registries.guns93.Light) then
            if weapon:isActivated() and item:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                weapon:setActivated(false)
            else
                weapon:setActivated(true)
            end
		    syncItemActivated(player, weapon)
            if item.playActivateDeactivateSound then
                item:playActivateDeactivateSound()
            end
        end
        GunStatAdjust(player, weapon)
        syncItemModData(player, weapon)
        syncHandWeaponFields(player, weapon)
        player:getInventory():setDirty(true)
        player:resetEquippedHandsModels()
    end
end

Guns93ActiveItem = {}

Guns93ActiveItem.callAction = function(weapon, item, player)
    if not weapon or not item or not player then return end
    if player:getPrimaryHandItem() ~= weapon and player:getSecondaryHandItem() ~= weapon then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, weapon, 50, true, true))
    end
    local toggleTime = item:hasTag(Gun93Registries.guns93.Bipod) and 50 or 0
    ISTimedActionQueue.add(Guns93ActiveItemAction:new(weapon, item:getFullType(), player, toggleTime))
end

Guns93ActiveItemAction = ISBaseTimedAction:derive("Guns93ActiveItemAction")

function Guns93ActiveItemAction:new(weapon, itemFullType, character, toggleTime)
    local o = ISBaseTimedAction.new(self, character)
    o.weapon = weapon
    o.itemFullType = itemFullType
    o.stopOnWalk = false
    o.stopOnRun = true
    o.stopOnAim = false
    o.maxTime = o:getDuration()
    o.caloriesModifier = 0
    o.useProgressBar = false
    o.toggleTime = toggleTime
    return o
end

function Guns93ActiveItemAction:getDuration()
    return 0
end

function Guns93ActiveItemAction:isValid()
    return self.weapon and self.character:getInventory():contains(self.weapon)
end

function Guns93ActiveItemAction:start()
    self.weapon:setJobType("Toggle Attachment")
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93ActiveItemAction:perform()
	ISBaseTimedAction.perform(self);
    self.weapon:setJobDelta(0.0);
end

function Guns93ActiveItemAction:complete()
    ItemActivation(self.weapon, self.itemFullType, self.character)
    self.character:resetEquippedHandsModels()
    return true
end

function Guns93ActiveItemAction:update()
    self.weapon:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93ActiveItemAction:stop()
    ISBaseTimedAction.stop(self)
    self.weapon:setJobDelta(0.0)
end

local function Guns93BatteryAttachments()
    local player = getPlayer()
    if not player or not player:isAlive() then return end
    local items = player:getInventory():getItems()
    for i = 0, items:size() - 1 do
        local weapon = items:get(i)
        if weapon:hasTag(Gun93Registries.guns93.Guns93) then
            local parts = weapon:getAllWeaponParts()
            local partsCopy = {}
            for k = 0, parts:size() - 1 do
                table.insert(partsCopy, parts:get(k))
            end
            for _, part in ipairs(partsCopy) do
                local partSwap = false
                if part then
                    if part:hasTag(Gun93Registries.guns93.ToggleItemOff) and (part:hasTag(Gun93Registries.guns93.Laser) or part:hasTag(Gun93Registries.guns93.RedDot)) then
                        if part:getCurrentUses() > 0 then
                            part:setCurrentUses(math.max(0, part:getCurrentUses() - part:getUseDelta()))
                            part:setActivated(true)
                        else
                            part:setActivated(false)
                            part:setCurrentUses(0)
                        end
                    end
                    local newPart = nil
                    if (part:hasTag(Gun93Registries.guns93.Laser) or part:hasTag(Gun93Registries.guns93.RedDot) or part:hasTag(Gun93Registries.guns93.Light)) then
                        if part:hasTag(Gun93Registries.guns93.ToggleItemOff) and part:getCurrentUses() <= 1 then
                            newPart = instanceItem(string.gsub(part:getFullType(), "_On$", ""))
                            newPart:setCurrentUses(0)
                        end
                        if newPart then
                            weapon:detachWeaponPart(part)
                            weapon:attachWeaponPart(newPart)
                            partSwap = true
                        end
                    end
                    if partSwap then
                        player:resetEquippedHandsModels()
                        syncItemModData(player, weapon)
                        syncHandWeaponFields(player, weapon)
                    end
                end
            end
        end
    end
end

Events.EveryHours.Add(Guns93BatteryAttachments)

-- Hotkey
local UseLaserHotKey = {}

function UseLaserHotKey.ToggleLaser()
    local player = getPlayer()
    if not player then return end
    local item = player:getPrimaryHandItem()
    if not item or not instanceof(item, "HandWeapon") then return end
    local laser = nil
    local parts = item:getAllWeaponParts()
    if parts and not parts:isEmpty() then
        for i = 0, parts:size() - 1 do
            local part = parts:get(i)
            if part and part:hasTag(Gun93Registries.guns93.Laser) then
                laser = part
                break
            end
        end
    end
    if not laser then return end
    ISTimedActionQueue.add(Guns93ActiveItemAction:new(item, laser:getFullType(), player, 0))
end

function UseLaserHotKey.addHotkey()
    table.insert(keyBinding, { value = "[Gun93Keys]", key = nil })
    table.insert(keyBinding, { value = "UseLaser_Toggle", key = Keyboard.KEY_V })
end

function UseLaserHotKey.onKeyPressed(key)
    local player = getPlayer()
    if not player then return end
    local item = player:getPrimaryHandItem()
    if not item or not instanceof(item, "HandWeapon") then return end
    local laser = nil
    local parts = item:getAllWeaponParts()
    if parts and not parts:isEmpty() then
        for i = 0, parts:size() - 1 do
            local part = parts:get(i)
            if part and part:hasTag(Gun93Registries.guns93.Laser) then
                laser = part
                break
            end
        end
    end
    if laser then
        if key == getCore():getKey("UseLaser_Toggle") then
            UseLaserHotKey.ToggleLaser()
        end
    end
end

UseLaserHotKey.addHotkey()
Events.OnKeyPressed.Add(UseLaserHotKey.onKeyPressed)

return UseLaserHotKey