function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Bayonet broken check (client-side halo note only - no item changes)
local function BayonetCondition(player, weapon)
    if not weapon or not instanceof(weapon, "HandWeapon") or not weapon:hasTag(Gun93Registries.guns93.BayoUsed) then return end
    if weapon:getHeadCondition() < 2 then
        player:setHaloNote(getText("ContextMenu_Bayo_Broken"))
    end
end

Events.OnPlayerAttackFinished.Add(BayonetCondition)

local function GunFouling(player, weapon)
    if SandboxVars.Guns93.Guns93Fouling then return end
    if not weapon or not instanceof(weapon, "HandWeapon") then return end
    if isClient() then return end
    local md = weapon:getModData()
    if not md.mod_fouling then md.mod_fouling = 0 end
    local foulingLevel = (weapon:getConditionLowerChance() / 4) - (weapon:getJamGunChance() * 20)
    if foulingLevel < 20 then foulingLevel = 20 end
    if ZombRand(foulingLevel) == 0 then
        md.mod_fouling = md.mod_fouling + ZombRand(1, 10)
        if md.mod_fouling > 100 then md.mod_fouling = 100 end
        syncItemModData(player, weapon)
        player:getInventory():setDirty(true)
    end
end

Events.OnPlayerAttackFinished.Add(GunFouling)

-- Cleaning Kit
Guns93UseCleaningKit = {}

Guns93UseCleaningKit.callAction = function(item, player, cleankit, context)
	context:hideAndChildren()
    ISInventoryPaneContextMenu.transferIfNeeded(player, item)
    if not item then return end
    ISTimedActionQueue.add(Guns93UseCleaningKitAction:new(item, player, cleankit))
end

Guns93UseCleaningKitAction = ISBaseTimedAction:derive("Guns93UseCleaningKitAction")

function Guns93UseCleaningKitAction:new(item, character, cleankit)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.cleankit = cleankit
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration();
    o.caloriesModifier = 15
    o.useProgressBar = true
    return o
end

function Guns93UseCleaningKitAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function Guns93UseCleaningKitAction:isValid()
    return self.item and self.character:getInventory():contains(self.item) and self.character:getInventory():contains(self.cleankit)
end

function Guns93UseCleaningKitAction:start()
    self.item:setJobType("Use Gun Cleaning Kit")
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93UseCleaningKitAction:perform()
    self.item:setJobDelta(0.0)
    self.character:resetEquippedHandsModels()
    ISBaseTimedAction.perform(self)
end

function Guns93UseCleaningKitAction:complete()
    local item = self.item
    local cleankit = self.cleankit
    local player = self.character
    if item:hasTag(Gun93Registries.guns93.Guns93) or item:getModData()["isSilencerCon"] then
        local playerSkill = (player:getPerkLevel(Perks.Aiming) + 1) * 5
        if cleankit:hasTag(Gun93Registries.guns93.BadGunClean) then
            playerSkill = round(playerSkill / 1.5, 0)
        end
---  or CharacterProfessionDefinition.getCharacterProfessionDefinition(CharacterProfession.veteran)
        local fouling = item:getModData().mod_fouling or 0
        local bloodFactor = item:getBloodLevel() * 100
        local cleanUses = math.max(fouling, bloodFactor) / playerSkill
        local kitUses = cleankit:getCurrentUses()
        if kitUses < cleanUses then cleanUses = kitUses end
        local cleanAmount = cleanUses * playerSkill
        cleankit:setCurrentUses(cleankit:getCurrentUses() - cleanUses)
        fouling = fouling - cleanAmount
        if fouling < 0 then fouling = 0 end
        item:getModData().mod_fouling = fouling
        if not item:getModData()["isSilencerCon"] and item:getBloodLevel() > 0 then
--            local newBlood = item:getBloodLevel() - (cleanAmount / 100)
--            if newBlood < 0 then newBlood = 0 end
            item:setBloodLevel(0) --- Can't currently partially remove blood. So, we'll zero it out for now.
        end
        local newName = item:getDisplayName()
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_dull"), "")
        newName = string.gsub(newName, getText("Tooltip_blunt"), "")
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_clothing_bloody"), "")
        item:setName(newName)
        sendItemStats(cleankit)
        syncItemModData(player, item)
        if not item:getModData()["isSilencerCon"] then
            syncHandWeaponFields(player, item)
        end
    end
    self.item:setJobDelta(0.0)
    return true
end

function Guns93UseCleaningKitAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93UseCleaningKitAction:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

-- Repair Firearm
Guns93RepairFirearm = {}

Guns93RepairFirearm.callAction = function(item, player, part, context)
	context:hideAndChildren()
    ISInventoryPaneContextMenu.transferIfNeeded(player, item)
    ISInventoryPaneContextMenu.transferIfNeeded(player, part)
    if not item then return end
    if not part then return end
    ISTimedActionQueue.add(Guns93RepairFirearmAction:new(item, player, part))
end

Guns93RepairFirearmAction = ISBaseTimedAction:derive("Guns93RepairFirearmAction")

function Guns93RepairFirearmAction:new(item, character, part)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.part = part
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration();
    o.caloriesModifier = 15
    o.useProgressBar = true
    return o
end

function Guns93RepairFirearmAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function Guns93RepairFirearmAction:isValid()
    return self.item and self.character:getInventory():contains(self.item) and self.part and self.character:getInventory():contains(self.part)
end

function Guns93RepairFirearmAction:start()
    self.item:setJobType("Repair Firearm")
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93RepairFirearmAction:perform()
    self.item:setJobDelta(0.0)
    self.character:resetEquippedHandsModels()
    ISBaseTimedAction.perform(self)
end

function Guns93RepairFirearmAction:complete()
    local part = self.part
    local item = self.item
    local player = self.character
	if instanceof(part, "HandWeapon") then
		Guns93StripFirearm(part, player)
	end
	local match = 0
	if part:getModData().modParts_Type then
		if item:getModData().modParts_Type == part:getModData().modParts_Type then
			match = match + 1
		end
	elseif item:getModData().modParts_Type == part:getFullType() then
		match = match + 1
	end
	if item:hasTag(Gun93Registries.guns93.Guns93Can) then
		if item:hasTag(Gun93Registries.guns93.Booster) then
			local booster = player:getInventory():AddItem(instanceItem("Base.CanBooster"))
            sendAddItemToContainer(player:getInventory(), booster)
		end
		if item:hasTag(Gun93Registries.guns93.QDMount) then
			local triLug = player:getInventory():AddItem(instanceItem("Base.SilencerTriLug"))
            sendAddItemToContainer(player:getInventory(), triLug)
		end
		if item:getModData().modBore_Eff == part:getModData().modBore_Eff then
			match = match + 1
		end
		if item:getModData().modBore_Eff <= part:getModData().modBore_Eff then
			match = match + 1
		end
	else
        if part:getModData().modParts_Ammo then
            if item:getAmmoType():getItemKey() == part:getModData().modParts_Ammo then
                match = match + 1
            end
		elseif item:getAmmoType() == part:getAmmoType() then
			match = match + 1
		end
		if item:getModData().modParts_Group == part:getModData().modParts_Group then
			match = match + 1
		end
	end
	local playerSkill = player:getPerkLevel(Perks.Aiming)
	local itemSkill = item:getModData().modParts_Level
	local itemCon = item:getCondition()
	local repairNum = item:getHaveBeenRepaired()
	local repairCon = part:getCondition()
	local skillRepair = 5*(playerSkill-itemSkill)
	if playerSkill < itemSkill then
		skillRepair = -15*(itemSkill-playerSkill)
	elseif skillRepair > 25 then
		skillRepair = 25
	end
	local potentRepair = (itemCon+((10/(repairNum+1))+skillRepair)/(item:getConditionMax()/repairCon))*(match/3)
	local chancSucc = (5+(playerSkill*30)-(repairNum*2))*(match/3)
---  or CharacterProfessionDefinition.getCharacterProfessionDefinition(CharacterProfession.veteran)    
--	if player:hasTrait(CharacterTrait.Hunter) then
--		chancSucc = chancSucc + 5
--	end
	if item:getAmmoType() == part:getAmmoType() then
		potentRepair = potentRepair/2
		chancSucc = chancSucc/2
	end
	if ZombRand(1,100) < chancSucc then
		local newCon = item:getCondition() + potentRepair
		if newCon > item:getConditionMax() then
			newCon = item:getConditionMax()
		end
		item:setCondition(newCon)
		if match < 3 then
			item:setHaveBeenRepaired(item:getHaveBeenRepaired()+1)
		end
	end
    item:setJobDelta(0.0)
    if player:getPrimaryHandItem() == part then
        player:setPrimaryHandItem(nil);
        player:setSecondaryHandItem(nil);
    end
    player:getInventory():Remove(part)
    sendRemoveItemFromContainer(player:getInventory(), part)
    if not isClient() then
        syncItemModData(player, item)
        if not item:hasTag(Gun93Registries.guns93.Guns93Can) then
            syncHandWeaponFields(player, item)
        end
        player:getInventory():setDirty(true)
    end
    local newName = item:getDisplayName()
    newName = string.gsub(newName, " %(.+%)", "")
    newName = string.gsub(newName, getText("Tooltip_dull"), "")
    newName = string.gsub(newName, getText("Tooltip_blunt"), "")
    newName = string.gsub(newName, " %(.+%)", "")
    newName = string.gsub(newName, getText("Tooltip_clothing_bloody"), "")
    item:setName(newName)
    player:resetEquippedHandsModels()
    self.item:setJobDelta(0.0)
    return true
end

function Guns93RepairFirearmAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93RepairFirearmAction:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

Guns93StripFirearmParts = {}

Guns93StripFirearmParts.callAction = function(item, player, receiver, context)
	context:hideAndChildren()
    ISInventoryPaneContextMenu.transferIfNeeded(player, item)
    if not item then return end
    ISTimedActionQueue.add(Guns93StripFirearmPartsAction:new(item, player, receiver))
end

Guns93StripFirearmPartsAction = ISBaseTimedAction:derive("Guns93StripFirearmPartsAction")

function Guns93StripFirearmPartsAction:new(item, character, receiver)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.receiver = receiver
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration();
    o.caloriesModifier = 15
    o.useProgressBar = true
    return o
end

function Guns93StripFirearmPartsAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function Guns93StripFirearmPartsAction:isValid()
    return self.item and self.character:getInventory():contains(self.item)
end

function Guns93StripFirearmPartsAction:start()
    self.item:setJobType("Strip Firearm for Parts")
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Craft)
end

function Guns93StripFirearmPartsAction:perform()
    self.item:setJobDelta(0.0)
    self.character:resetEquippedHandsModels()
    ISBaseTimedAction.perform(self)
end

function Guns93StripFirearmPartsAction:complete()
    if isClient() then return end
    local item = self.item
    local player = self.character    
    if not item or not player then return true end
    if instanceof(item, "HandWeapon") then
        Guns93StripFirearm(item, player)
    end
    local dataOld = item:getModData()
    local newParts = instanceItem(dataOld.modParts_Type)
    local moddata = newParts:getModData()
    if item:hasTag(Gun93Registries.guns93.Guns93Can) then
        local newNam = item:getName()
        if item:hasTag(Gun93Registries.guns93.Booster) then
            local booster = instanceItem("Base.CanBooster")
            player:getInventory():AddItem(booster)
            sendAddItemToContainer(player:getInventory(), booster)
            newNam = string.gsub(newNam, "Booster", "")
        end
        if item:hasTag(Gun93Registries.guns93.QDMount) then
            local trilug = instanceItem("Base.SilencerTriLug")
            player:getInventory():AddItem(trilug)
            sendAddItemToContainer(player:getInventory(), trilug)
            newNam = string.gsub(newNam, "Tri", "")
            newNam = string.gsub(newNam, "Lug", "")
            newNam = string.gsub(newNam, "-", "")
            newNam = string.gsub(newNam, "Adapter", "")
        end
        newNam = string.gsub(newNam, ",  ", "")
        newNam = string.gsub(newNam, ", ", "")
        newParts:setName(newParts:getName() .. " " .. newNam)
        moddata.modBore_Eff = dataOld.modBore_Eff
    else
        local ammoNam = getItemNameFromFullType(item:getAmmoType():getItemKey())
        ammoNam = string.gsub(ammoNam, " Round", "")
        local groupNam = getText(dataOld.modParts_Group) or ""
        moddata.modParts_Group = dataOld.modParts_Group
        newParts:setName(ammoNam .. " " .. newParts:getName() .. " " .. groupNam)
    end
    newParts:setCustomName(true)
    if not item:hasTag(Gun93Registries.guns93.Guns93Can) then
        moddata.modParts_Ammo = item:getAmmoType():getItemKey()
    end
    newParts:setCondition(item:getCondition())
    newParts:setWeight(item:getWeight() * 0.4)
    player:getInventory():AddItem(newParts)
    sendAddItemToContainer(player:getInventory(), newParts)
    syncItemModData(player, newParts)
    if player:getPrimaryHandItem() == item then
        player:setPrimaryHandItem(nil)
        player:setSecondaryHandItem(nil)
    end
    player:resetEquippedHandsModels()
    player:getInventory():Remove(item)
    sendRemoveItemFromContainer(player:getInventory(), item)
    player:getInventory():setDirty(true)
    self.item:setJobDelta(0.0)
    return true
end

function Guns93StripFirearmPartsAction:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.UsingTools)
end

function Guns93StripFirearmPartsAction:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function Guns93StripFirearm(item, player)
    if isClient() then return end
    local bayo = item:getWeaponPart("Bayonet")
    if bayo then
        local bayoType = string.gsub(bayo:getFullType(), "Part", "")
        bayoType = string.gsub(bayoType, "Out", "")
        local removebayo = instanceItem(bayoType)
        if bayo:getSharpness() then removebayo:setSharpness(bayo:getSharpness()) end
        removebayo:setCondition(bayo:getCondition())
        removebayo:setBloodLevel(item:getBloodLevel())
        removebayo:setHaveBeenRepaired(bayo:getHaveBeenRepaired())
        item:detachWeaponPart(bayo)
        player:getInventory():AddItem(removebayo)
        sendAddItemToContainer(player:getInventory(), removebayo)
    end
    if item:haveChamber() and item:isRoundChambered() then
        local chambered = instanceItem(item:getAmmoType():getItemKey())
        player:getInventory():AddItem(chambered)
        sendAddItemToContainer(player:getInventory(), chambered)
    end
    if item:isContainsClip() then
        local remMag = instanceItem(item:getMagazineType())
        remMag:setCurrentAmmoCount(item:getCurrentAmmoCount())
        player:getInventory():AddItem(remMag)
        sendAddItemToContainer(player:getInventory(), remMag)
        item:setContainsClip(false)
        item:setCurrentAmmoCount(0)
    elseif item:getCurrentAmmoCount() > 0 then
        player:getInventory():AddItems(item:getAmmoType():getItemKey(), item:getCurrentAmmoCount())
        item:setCurrentAmmoCount(0)
    end
    local remparts = item:getAllWeaponParts()
    for i = remparts:size() - 1, 0, -1 do
        local rempart = remparts:get(i)
        if not rempart:hasTag(Gun93Registries.guns93.NoMount) and not rempart:hasTag(Gun93Registries.guns93.KeepPart) then
            if rempart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                local togglePart = instanceItem(string.gsub(rempart:getFullType(), "_On$", ""))
                if togglePart:isActivated() then
                    togglePart:setActivated(false)
                end
                player:getInventory():AddItem(togglePart)
                sendAddItemToContainer(player:getInventory(), togglePart)
            else
                player:getInventory():AddItem(rempart)
                sendAddItemToContainer(player:getInventory(), rempart)
            end
        end
        item:detachWeaponPart(rempart)
    end
    syncItemModData(player, item)
    syncHandWeaponFields(player, item)
    player:getInventory():setDirty(true)
end