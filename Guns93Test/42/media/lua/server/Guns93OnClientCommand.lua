Guns93PendingLoad = Guns93PendingLoad or {}

local function onClientCommand(module, command, player, args)
    if module == "Guns93" then
        if command == "EnBlocEject" then
            if not player then return end
            local weapon = player:getPrimaryHandItem()
            if not weapon or not weapon:IsWeapon() or not weapon:isRanged() then
                weapon = player:getSecondaryHandItem()
            end
            if weapon then
                Guns93doEnBlocEject(player, weapon)
            end
        end
        if command == "SetLoadIntent" and args then
            local item = player:getInventory():getItemById(args.itemID)
            if not item then return end
            Guns93PendingLoad[player:getOnlineID()] = {itemID = item:getID(), round = args.round and tostring(args.round) or nil, round2 = args.round2 and tostring(args.round2) or nil, bycaliber = args.bycaliber and true or false, amount = args.amount,}
        end
        if command == "EjectBrass" and args then
            local weapon = player:getInventory():getItemById(args.itemID) or player:getPrimaryHandItem()
            if weapon and args.isSpent == true then
                weapon:setSpentRoundChambered(true)
                Guns93BrassEject(player, weapon)
            end
        end
        if command == "BurstBang" and args then
            local weapon = player:getInventory():getItemById(args.itemID) or player:getPrimaryHandItem()
            if weapon then
                local weaponMod = weapon:getModData()
                if args.stop == false then
                    weaponMod.modBurst_Num = weaponMod.modBurst_Num + 1
                elseif args.stop == true then
                    weaponMod.modBurst_Num = 0
                end
            end
        end
    end
end


Events.OnClientCommand.Add(onClientCommand)