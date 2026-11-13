local function RemoveAttachedWeapons()
    if not SandboxVars.Guns93.Guns93VanillaGuns then return end
    if not AttachedWeaponDefinitions then return end

    local vanillaGuns = {
        "Base.FiberglassStock",
        "Base.Pistol",
        "Base.Pistol2",
        "Base.Pistol3",
        "Base.Revolver",
        "Base.Revolver_Short",
        "Base.Revolver_Long",
        "Base.TrapperCarbine",
        "Base.L94_Rifle",
        "Base.L92_Carbine",
        "Base.VarmintRifle",
        "Base.HuntingRifle",
        "Base.MSR7T_Rifle",
        "Base.JS14_Rifle",
        "Base.AssaultRifle",
        "Base.AssaultRifle2",
        "Base.Shotgun",
        "Base.ShotgunSawnoff",
        "Base.DoubleBarrelShotgun",
        "Base.DoubleBarrelShotgunSawnoff",
        "Base.JS3T_Shotgun",
        "Base.9mmClip",
        "Base.45Clip",
        "Base.44Clip",
        "Base.JS14_Clip",
        "Base.556Clip",
        "Base.308Clip",
        "Base.M14Clip"
    }

    local function ClearGunsFrom(def)
        if not def or not def.weapons then return end
        for i = #def.weapons, 1, -1 do
            local weapon = def.weapons[i]
            for _, gun in ipairs(vanillaGuns) do
                if weapon == gun then
                    table.remove(def.weapons, i)
                    break
                end
            end
        end
    end
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolster)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterShoulder)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterPolice)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterAnkle)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterDetective)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterArmy)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterRanger)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterSheriff)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterSWAT)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterGhillie)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterWildWest)
    ClearGunsFrom(AttachedWeaponDefinitions.handgunHolsterLeftWildWest)
    ClearGunsFrom(AttachedWeaponDefinitions.shotgunPolice)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackSWAT)
    ClearGunsFrom(AttachedWeaponDefinitions.assaultRifleOnBack)
    ClearGunsFrom(AttachedWeaponDefinitions.assaultRifleArmyOnBack)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackMisc)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackHunter)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackBagSurvivalist)
    ClearGunsFrom(AttachedWeaponDefinitions.huntingRifleOnBack)
    ClearGunsFrom(AttachedWeaponDefinitions.rifleOnBackGhillie)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackCrime)
    ClearGunsFrom(AttachedWeaponDefinitions.gunOnBackBountyHunter)
    ClearGunsFrom(AttachedWeaponDefinitions.rifleWildWest)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBack_Bandit)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBack_Early)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBack_Mid)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBack_Late)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBackBag)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBackBag_Mid)
    ClearGunsFrom(AttachedWeaponDefinitions.meleeInBackBag_Late)
end

Events.OnGameStart.Add(RemoveAttachedWeapons)

if AttachedWeaponDefinitions.handgunHolster then 
    AttachedWeaponDefinitions.handgunHolster.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterShoulder then 
    AttachedWeaponDefinitions.handgunHolsterShoulder.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterPolice then 
    AttachedWeaponDefinitions.handgunHolsterPolice.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterAnkle then 
    AttachedWeaponDefinitions.handgunHolsterAnkle.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterDetective then 
    AttachedWeaponDefinitions.handgunHolsterDetective.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterArmy then 
    AttachedWeaponDefinitions.handgunHolsterArmy.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterRanger then 
    AttachedWeaponDefinitions.handgunHolsterRanger.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterSheriff then 
    AttachedWeaponDefinitions.handgunHolsterSheriff.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterSWAT then 
    AttachedWeaponDefinitions.handgunHolsterSWAT.weapons = {} 
end
if AttachedWeaponDefinitions.handgunHolsterGhillie then 
    AttachedWeaponDefinitions.handgunHolsterGhillie.weapons = {}
    AttachedWeaponDefinitions.handgunHolsterGhillie.chance = 70
end
if AttachedWeaponDefinitions.shotgunPolice then 
    AttachedWeaponDefinitions.shotgunPolice.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackSWAT then 
    AttachedWeaponDefinitions.gunOnBackSWAT.weapons = {} 
end
if AttachedWeaponDefinitions.assaultRifleOnBack then 
    AttachedWeaponDefinitions.assaultRifleOnBack.weapons = {} 
end
if AttachedWeaponDefinitions.assaultRifleArmyOnBack then 
    AttachedWeaponDefinitions.assaultRifleArmyOnBack.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackMisc then 
    AttachedWeaponDefinitions.gunOnBackMisc.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackHunter then 
    AttachedWeaponDefinitions.gunOnBackHunter.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackBagSurvivalist then 
    AttachedWeaponDefinitions.gunOnBackBagSurvivalist.weapons = {} 
end
if AttachedWeaponDefinitions.huntingRifleOnBack then 
    AttachedWeaponDefinitions.huntingRifleOnBack.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackCrime then 
    AttachedWeaponDefinitions.gunOnBackCrime.weapons = {} 
end
if AttachedWeaponDefinitions.gunOnBackBountyHunter then 
    AttachedWeaponDefinitions.gunOnBackBountyHunter.weapons = {} 
end