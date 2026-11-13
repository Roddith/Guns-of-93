function Guns93OnTestGuns93DIYSilencerDistro()
	if not SandboxVars.Guns93.Guns93DIYSilencerDistro then
		return true
	elseif SandboxVars.Guns93.Guns93DIYSilencerDistro == TRUE then
		return false
    end
end

function Guns93OnTestGuns93BayoDistro()
	if not SandboxVars.Guns93.Guns93BayoDistro then
		return true
	elseif SandboxVars.Guns93.Guns93BayoDistro == TRUE then
		return false
    end
end

function Guns93OnTestGuns93RailsDistro()
	if not SandboxVars.Guns93.Guns93RailsDistro then
		return true
	elseif SandboxVars.Guns93.Guns93RailsDistro == TRUE then
		return false
    end
end

function Guns93OnTestGuns93DIYAutoDistro()
	if not SandboxVars.Guns93.Guns93DIYAutoDistro then
		return true
	elseif SandboxVars.Guns93.Guns93DIYAutoDistro == TRUE then
		return false
    end
end

function Guns93OnTestGuns93BarrelThreading(item)
	if item:getCategory() == "Weapon" then
		if item:getWeaponPart("Threading") then
			return false
		end
	end
	if not SandboxVars.Guns93.Guns93BarrelThreading then
		return true
	elseif SandboxVars.Guns93.Guns93BarrelThreading == TRUE then
		return false
    end
end

function Guns93OnTestGuns93StockFold()
	if not SandboxVars.Guns93.Guns93StockFold then
		return true
	elseif SandboxVars.Guns93.Guns93StockFold == TRUE then
		return false
    end
end