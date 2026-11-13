local function Guns93AdjustPart(player, weapon, part)
    local newPart = nil
    local switch = false
    local partMod = part:getModData()
    if partMod and partMod.mod_RangMod and partMod.mod_RangMod >= 0 then
        if not switch then
            newPart = instanceItem(part:getFullType())
            switch = true
        end
        if newPart then
            newPart:getModData().mod_RangMod = 0
        end
    end
    if part:getHitChance() and part:getHitChance() >= 0 then
        if not switch then
            newPart = instanceItem(part:getFullType())
            switch = true
        end
        if newPart then
            newPart:setHitChance(0)
        end
    end
    if part:getDamage() and part:getDamage() >= 0 then
        if not switch then
            newPart = instanceItem(part:getFullType())
            switch = true
        end
        if newPart then
            newPart:setDamage(0)
        end
    end
    if partMod and partMod.mod_CritChanceMod and partMod.mod_CritChanceMod >= 0 then
        if not switch then
            newPart = instanceItem(part:getFullType())
            switch = true
        end
        if newPart then
            newPart:getModData().mod_CritChanceMod = 0
        end
    end
    if partMod and partMod.ProjectileSpreadModifier
       and weapon:getAmmoType() ~= "Base.ShotgunShells"
       and partMod.ProjectileSpreadModifier >= 0 then
        if not switch then
            newPart = instanceItem(part:getFullType())
            switch = true
        end
        if newPart then
            newPart:getModData().ProjectileSpreadModifier = 0
        end
    end
    if switch and newPart then
		if part:getCurrentUses() then
			newPart:setCurrentUses(part:getCurrentUses())
		end
		if part:getCondition() then
			newPart:setCondition(part:getCondition())
		end
        weapon:detachWeaponPart(part)
        weapon:attachWeaponPart(newPart)
        syncHandWeaponFields(player, weapon)
    end
end


function AttachmentAdjust(player, weapon)
    if not instanceof(player, "IsoPlayer") then return end
    if not weapon
       or not instanceof(weapon, "HandWeapon")
       or not weapon:hasTag(Gun93Registries.guns93.Guns93) then
        return
    end
    local parts = weapon:getAllWeaponParts()
    if not parts or parts:isEmpty() then return end
    local partList = {}
    for i = 0, parts:size() - 1 do
        local part = parts:get(i)
        if part then
            table.insert(partList, part)
        end
    end
    local bayoUsed   = weapon:hasTag(Gun93Registries.guns93.BayoUsed)
    local ammoType   = weapon:getAmmoType()
    local isShotgun  = ammoType == "Base.ShotgunShells"
    local isSlugAmmo = ammoType == "Base.SlugBullets"
    for _, part in ipairs(partList) do
        local partType = part:getPartType()
        local shouldAdjust = false
        if bayoUsed then
            shouldAdjust = true
        elseif partType == "Scope" or partType == "Scope2" or partType == "Receiver" or partType == "Irons" then
            if isShotgun then
                shouldAdjust = true
            end
        elseif partType == "Canon" then
            if (part:hasTag(Gun93Registries.guns93.Buckshot) and isSlugAmmo) or (part:hasTag(Gun93Registries.guns93.Slug) and isShotgun) then
                shouldAdjust = true
            end
        end
        if shouldAdjust then
            Guns93AdjustPart(player, weapon, part)
        else
			local newPart = instanceItem(part:getFullType())
			if part:getCurrentUses() then
				newPart:setCurrentUses(part:getCurrentUses())
			end
			if part:getCondition() then
				newPart:setCondition(part:getCondition())
			end
            weapon:detachWeaponPart(part)
            weapon:attachWeaponPart(newPart)
        end
    end
end

Events.OnEquipPrimary.Add(AttachmentAdjust)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if player then
        AttachmentAdjust(player, player:getPrimaryHandItem())
    end
end)