Guns93RemoveItems = {
    "Base.FiberglassStock",
---    "Base.Bag_RifleCaseClothCamo",
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

local function ModifyAllLootTables()
    if not SandboxVars.Guns93.Guns93VanillaGuns then return end

    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "556Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "ChokeTubeFull", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "ChokeTubeImproved", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "M14Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "RecoilPad", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "556Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "x2Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "x4Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_WeaponBag.items, "x8Scope", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.HollowBook.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.HollowBook_Handgun.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HollowBook_Handgun.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HollowBook_Handgun.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HollowBook_Handgun.items, "Revolver_Long", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.HollowBook_Valuables.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "M14Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "RecoilPad", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "x2Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "x4Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.GunBox.items, "x8Scope", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.counter.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.plankstash.items, "Bullets38Box", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "M14Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "RecoilPad", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "x2Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "x4Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache1.Bag_DuffelBagTINT.items, "x8Scope", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "M14Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "RecoilPad", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "x2Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "x4Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunCache2.GunBox.items, "x8Scope", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "308Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "556Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "44Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "45Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "9mmClip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Bullets357Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Bullets38Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Bullets44Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Bullets45Box", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Bullets9mmBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "M14Clip", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "RecoilPad", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "RedDot", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "x2Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "x4Scope", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_DuffelBagTINT.GunBox.items, "x8Scope", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Outfit_Biker.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Outfit_Biker.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Outfit_Detective.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Outfit_Trucker.junk.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Outfit_Trucker.junk.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunBag.items, "ShotgunShellsBox", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShells", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShellsBox", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblBag.items, "ShotgunShellsBox", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunDblSawnoffBag.items, "DoubleBarrelShotgunSawnoff", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Bag_ShotgunSawnoffBag.items, "ShotgunSawnoff", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache1.ShotgunBox.junk.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache1.plankstash.junk.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache2.ShotgunBox.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache2.ShotgunBox.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache2.ShotgunBox.junk.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ShotgunCache2.counter.items, "DoubleBarrelShotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ArmyStorageGuns.items, "JS3T_Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresser.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserClassy.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomDresserRedneck.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetable.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableClassy.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BedroomSidetableRedneck.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugLabGuns.items, "TrapperCarbine", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DrugShackWeapons.items, "TrapperCarbine", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Mid.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.FirearmWeapons_Late.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "JS3T_Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreGuns.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStorePistols.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GarageFirearms.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "AssaultRifle2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "JS3T_Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "MSR7T_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PawnShopGunsSpecial.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Pistol3", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PlankStashGun.junk.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceDesk.items, "Pistol", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "ShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceEvidence.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceOutfit.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceOutfit.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateOutfit.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateOutfit.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateOutfit.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateOutfit.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateTools.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateTools.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateTools.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStateTools.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "JS3T_Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceStorageGuns.items, "JS14_Rifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceTools.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PoliceTools.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SecurityDesk.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SecurityDesk.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SecurityLockers.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SecurityLockers.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SecurityLockers.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SecurityLockers.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SWATStorageGuns.items, "Pistol", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SWATStorageGuns.items, "Pistol2", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SWATStorageGuns.items, "JS3T_Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SWATStorageGuns.items, "AssaultRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SWATStorageGuns.items, "MSR7T_Rifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SafehouseStove_Late.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SafehouseMedical_Late.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SafehouseFridge_Late.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SafehouseFreezer_Late.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SafehouseBin_Late.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.RangerTools.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerTools.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerTools.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerTools.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "VarmintRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerStorageGuns.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.RangerOutfit.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerOutfit.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerOutfit.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerOutfit.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerOutfit.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.RangerDesk.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.RangerDesk.items, "Revolver_Long", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.PrisonStorageGuns.items, "Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.PoliceCaptainDesk.items, "Revolver_Long", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.OfficeDeskStressed.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.JudgeMattHassCounter.junk.items, "Revolver_Long", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.DresserGeneric.items, "Revolver", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DresserGeneric.items, "Revolver_Long", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.DresserGeneric.items, "Revolver_Short", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BurglarTools.items, "Revolver_Short", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.BarCounterWeapon.items, "DoubleBarrelShotgunSawnoff", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.BarCounterWeapon.items, "ShotgunSawnoff", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetInstruments.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.ClosetShelfGeneric.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.GunStoreShotguns.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreShotguns.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.GunStoreShotguns.items, "JS3T_Shotgun", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Hunter.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "JS14_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.HuntingLockers.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.SurvivalGear.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.Trapper.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeClassy.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeGeneric.items, "VarmintRifle", nil, true);

    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "DoubleBarrelShotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "HuntingRifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "L92_Carbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "L94_Rifle", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "Shotgun", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "TrapperCarbine", nil, true);
    RemoveItemFromDistribution(SuburbsDistributions.WardrobeRedneck.items, "VarmintRifle", nil, true);
end

Events.OnPreDistributionMerge.Add(ModifyAllLootTables)