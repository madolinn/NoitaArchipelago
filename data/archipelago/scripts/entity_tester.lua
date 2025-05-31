local nxml = dofile_once("data/archipelago/lib/nxml.lua")
local Animals = dofile_once("data/archipelago/scripts/ap_animal_mapping.lua")

local EnemyListAdjustments = {
	-- { Prefix Override }
	["player"] = { 'data/entities/' },
	
	-- Lukkis
	["lukki_tiny"] = { 'data/entities/animals/lukki/' },
	["lukki"] = { 'data/entities/animals/lukki/' },
	["lukki_longleg"] = { 'data/entities/animals/lukki/' },
	["lukki_creepy_long"] = { 'data/entities/animals/lukki/' },
	["lukki_dark"] = { 'data/entities/animals/lukki/' },
	
	-- Crystals
	["snowcrystal"] = { 'data/entities/buildings/' },
	["hpcrystal"] = { 'data/entities/buildings/' },
	["ghost_crystal"] = { 'data/entities/buildings/' }, -- Houre override
	
	-- Illusions
	["dark_alchemist"] = { 'data/entities/animals/illusions/' },
	["shaman_wind"] = { 'data/entities/animals/illusions/' },
	
	-- Bosses
	["boss_limbs"] = { 'data/entities/animals/boss_limbs/' },
	["boss_meat"] = { 'data/entities/animals/boss_meat/' },
	["boss_alchemist"] = { 'data/entities/animals/boss_alchemist/' },
	["parallel_alchemist"] = { 'data/entities/animals/parallel/alchemist/' },
	["boss_ghost"] = { 'data/entities/animals/boss_ghost/' },
	["boss_ghost_polyp"] = { 'data/entities/animals/boss_ghost/' },
	["islandspirit"] = { 'data/entities/animals/boss_spirit/' },
	["boss_pit"] = { 'data/entities/animals/boss_pit/' },
	["boss_robot"] = { 'data/entities/animals/boss_robot/' },
	
	["fish_giga"] = { 'data/entities/animals/boss_fish/' },
	
	["maggot_tiny"] = { 'data/entities/animals/maggot_tiny/' },
	["parallel_tentacles"] = { 'data/entities/animals/parallel/tentacles/' },
	["minipit"] = { 'data/entities/animals/special/' },
	["gate_monster_a"] = { 'data/entities/animals/boss_gate/' },
	["gate_monster_b"] = { 'data/entities/animals/boss_gate/' },
	["gate_monster_c"] = { 'data/entities/animals/boss_gate/' },
	["gate_monster_d"] = { 'data/entities/animals/boss_gate/' },
	
	["boss_wizard"] = { 'data/entities/animals/boss_wizard/' },
	["boss_centipede"] = { 'data/entities/animals/boss_centipede/' },
	["boss_sky"] = { 'data/entities/animals/boss_sky/' },
}

local PatchEntities = {
	-- Base Entities
	'data/entities/base_humanoid.xml',
	'data/entities/base_helpless_animal.xml',

	-- Bosses
	'data/entities/animals/boss_limbs/boss_limbs.xml',
	'data/entities/animals/boss_robot/boss_robot.xml',
	'data/entities/animals/boss_centipede/boss_centipede.xml',
	'data/entities/animals/boss_fish/fish_giga.xml',
	'data/entities/animals/boss_ghost/boss_ghost_polyp.xml',
	'data/entities/animals/boss_pit/boss_pit.xml',
	'data/entities/animals/boss_spirit/islandspirit.xml',
	'data/entities/animals/boss_wizard/boss_wizard.xml',
	'data/entities/animals/boss_dragon.xml',
	'data/entities/animals/boss_ghost/boss_ghost.xml',
	'data/entities/animals/maggot_tiny/maggot_tiny.xml',
	'data/entities/animals/parallel/tentacles/parallel_tentacles.xml',

	-- Crystals
	'data/entities/buildings/ghost_crystal.xml',
	'data/entities/buildings/snowcrystal.xml',
	'data/entities/buildings/hpcrystal.xml',

	-- Stupid flower
	'data/entities/animals/shooterflower.xml',

	-- Lukkis..
	'data/entities/animals/lukki/lukki.xml',
	'data/entities/animals/lukki/lukki_tiny.xml',
	'data/entities/animals/lukki/lukki_longleg.xml',
	'data/entities/animals/lukki/lukki_dark.xml',
	'data/entities/animals/lukki/lukki_creepy_long.xml',

	-- Worm
	'data/entities/animals/worm_tiny.xml',
	'data/entities/animals/worm.xml',
	'data/entities/animals/worm_big.xml',
	'data/entities/animals/worm_end.xml',
	'data/entities/animals/worm_skull.xml',
	'data/entities/animals/meatmaggot.xml',
	
	-- Fish
	'data/entities/animals/fish_large.xml',
	'data/entities/animals/fish.xml',
	'data/entities/animals/eel.xml',

	-- Weird
	'data/entities/animals/chest_leggy.xml',
	'data/entities/animals/ethereal_being.xml',

	-- Unimplemented, but maybe someone will extend them
	'data/entities/animals/darkghost.xml',
	'data/entities/animals/lukki/lukki_creepy.xml',
}

function TestDeathComponent()
	for entityName, _ in pairs(Animals.by_animal_name) do
		local pathPrefix = "data/entities/animals/"
		if EnemyListAdjustments[entityName] ~= nil then
			pathPrefix = EnemyListAdjustments[entityName][1]
		end
		local fullPath = pathPrefix .. entityName .. ".xml"
		local new_ent = EntityLoad(fullPath, 100, 100)
		print("[Spawned] " .. fullPath)

		EntityInflictDamage(new_ent, 90000, "DAMAGE_HOLY", "TESTDMG", "NO_RAGDOLL_FILE", 0, 0)
	end
end

TestDeathComponent()