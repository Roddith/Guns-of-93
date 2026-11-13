if not isClient() then return end

local Guns93Commands = Guns93Commands or {}

Guns93Commands.bayonet = {}

Guns93Commands.bayonet.toggle = function(args)
    local player = getPlayerByOnlineID(args.playerOnlineID)
    if not player then return end
    
    local weapon = player:getInventory():getItemWithID(args.itemID)
    if weapon:getSubCategory() == "Stab" and weapon:hasTag(Gun93Registries.guns93.BayoUsed) then
        local oldGun = args.storeGun
		local refWeapon = instanceItem(oldGun)
        if refWeapon then
            weapon:setModelWeaponPart(refWeapon:getModelWeaponPart())
        end
--        weapon:setTexture(args.itemTex)
        weapon:getModData().mod_fouling = args.storeGun
        syncHandWeaponFields(player, weapon)
    end
end

Guns93Commands.zombie = {}

Guns93Commands.zombie.attachgun = function(args)
    local zombieList = getCell():getZombieList()
    if not zombieList then return end
    for i = 0, zombieList:size() - 1 do
        local mover = zombieList:get(i)
        if mover and mover:getPersistentOutfitID() == args.zombieID then
            for k = mover:getAttachedItems():size() - 1, 0, -1 do
                local zomGun = mover:getAttachedItems():get(k)
                if zomGun ~= nil and zomGun:getLocation() == args.gunLoc then
                    mover:setAttachedItem(args.gunLoc, nil)
                    local weapon = instanceItem(args.weaponID)
                    if weapon then
                        weapon:setWeaponSprite(args.sprite)
                        local existingParts = weapon:getAllWeaponParts()
                        for p = existingParts:size() - 1, 0, -1 do
                            weapon:detachWeaponPart(existingParts:get(p))
                        end
                        if args.attachedParts then
                            for _, partData in ipairs(args.attachedParts) do
                                if partData then
                                    local newPart = instanceItem(partData)
                                    if newPart then weapon:attachWeaponPart(newPart) end
                                end
                            end
                        end
                        mover:setAttachedItem(args.gunLoc, weapon)
                        mover:resetModel()
                    end
                end
            end
        end
    end
end

function OnGuns93ServerCommand(module, command, args)
    if Guns93Commands[module] and Guns93Commands[module][command] then
        local argStr = ''
        if args then
            for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        end
        Guns93Commands[module][command](args)
    end
end

Events.OnServerCommand.Add(OnGuns93ServerCommand)