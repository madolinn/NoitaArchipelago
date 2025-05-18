local nxml = dofile_once("data/archipelago/lib/nxml.lua")
local Animals = dofile("data/archipelago/scripts/ap_animal_mapping.lua")

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

function APAddDeathComponent()
	for entityName, _ in pairs(Animals) do
		local pathPrefix = "data/entities/animals/"
		if EnemyListAdjustments[entityName] ~= nil then
			pathPrefix = EnemyListAdjustments[entityName][1]
		end
		local fullPath = pathPrefix .. entityName .. ".xml"
		local content = ModTextFileGetContent(fullPath)
		local xml = nxml.parse(content)
		xml:add_child(nxml.parse([[
			<LuaComponent script_death="data/archipelago/scripts/ap_death_component.lua"></LuaComponent>]]))
		ModTextFileSetContent(fullPath, tostring(xml))
	end
end

APAddDeathComponent()