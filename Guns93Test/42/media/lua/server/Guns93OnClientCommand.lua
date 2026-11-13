local MOD_MODULE = "Guns93"
local CMD_ENBLOC = "EnBlocEject"

local function onClientCommand(module, command, player, args)
    if module ~= MOD_MODULE then return end
    if command ~= CMD_ENBLOC then return end
    if not player then return end
    local weapon = player:getPrimaryHandItem()
    if not weapon or not weapon:IsWeapon() or not weapon:isRanged() then
        weapon = player:getSecondaryHandItem()
    end
    if weapon then
        Guns93doEnBlocEject(player, weapon)
    end
end

Events.OnClientCommand.Add(onClientCommand)