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
        if isClient() and args.itemTex then
            weapon:setTexture(getTexture("media/textures/item_" .. args.itemTex .. ".png"))
        end
        syncItemModData(player, weapon)
        syncHandWeaponFields(player, weapon)
    end
end

Guns93Commands.bayonet.hotbar = function(args) 
    local slotIndex = args.slotIndex
    if not slotIndex then return end
    local itemID = args.itemID
    local player = getPlayer()
    local item = player:getInventory():getItemById(itemID) or nil
    if item then
        local hotBar = getPlayerHotbar(player:getPlayerNum())
        local slotDef = hotBar.availableSlot[slotIndex].def
        hotBar:attachItem(item, slotDef.attachments[item:getAttachmentType()], slotIndex, slotDef, false)
        hotBar.needsRefresh = true
        hotBar:update()
        syncItemModData(player, item)
        syncHandWeaponFields(player, item)
    end
    return
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