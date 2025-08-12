local nxml = dofile_once("data/archipelago/lib/nxml.lua")

local vanillaPatchEntities = {
	-- Base Entities
	'data/entities/base_humanoid.xml',
	'data/entities/base_helpless_animal.xml',
	'data/entities/player_base.xml',

	'data/entities/base_item_physics.xml',
	'data/entities/base_item_physics2.xml',
	--'data/entities/base_prop_crystal.xml', -- Physics2

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

	-- Stupid flower, be like your brother.
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

	-- Prop hunt
	'data/entities/props/suspended_tank_acid.xml',
	'data/entities/props/suspended_tank_radioactive.xml',
	'data/entities/props/physics/lantern_small.xml',
	'data/entities/props/suspended_seamine.xml',
	'data/entities/buildings/lukki_eggs.xml',
}

----------------------------------------------------------------- Apotheosis
local apotheosisPatchEntities = {
	--- Base
	'data/entities/base_enemy_ceiling_creep.xml',

	-- Lukkis
	'data/entities/animals/lukki_fire_tiny.xml',
	'data/entities/animals/lukki_swarmling.xml',
	'data/entities/animals/lukki_fire_miniboss.xml',
	'data/entities/animals/lukki_fungus.xml',
	'data/entities/animals/lukki_tentacle_hungry.xml',

	-- Worms
	'data/entities/animals/worm_wall.xml',
	'data/entities/animals/worm_mechanical.xml',
	'data/entities/animals/worm_maggot_big.xml',
	'data/entities/animals/worm_esoteric.xml',
	'data/entities/animals/giant_centipede.xml',

	-- Odd ones
	'data/entities/animals/seeker.xml',
	'data/entities/animals/devourer_magic.xml',
	'data/entities/animals/devourer_ghost.xml',
	'data/entities/animals/locust_swarm.xml',
	'data/entities/animals/sunken_creature.xml',
	'data/entities/animals/fairy_cheap.xml',
	'data/entities/animals/poisonmushroom.xml',
	'data/entities/animals/musical_being_weak.xml',

	-- Flesh Wizards
	'data/entities/animals/flesh_wizard_twitchy.xml',
	'data/entities/animals/flesh_wizard_neutral.xml',
	'data/entities/animals/flesh_wizard_wands.xml',
	'data/entities/animals/flesh_wizard_manaeater.xml',
	'data/entities/animals/flesh_wizard_swapper.xml',
	
	-- Bosses
	'data/entities/animals/boss_centipede/boss_centipede.xml',
	'data/entities/animals/boss_toxic_worm_minion.xml',
	'data/entities/animals/boss_toxic_worm.xml',
	'data/entities/animals/boss_toxic_worm_parallel.xml',
	'data/entities/animals/boss_flesh_monster.xml',
	'data/entities/animals/boss_fire_lukki.xml',
	'data/entities/animals/boss_musical_ghost.xml',
	'data/entities/animals/miniboss_pit_02.xml',
	'data/entities/animals/forest_monolith.xml',
	'data/entities/animals/boss_meat/boss_meat.xml',
}

local onRemovePatchEntities = {
	'data/entities/buildings/physics_cocoon.xml',
}

function APAddDeathComponent()
	for _, path in ipairs(vanillaPatchEntities) do
		local content = ModTextFileGetContent(path)
		if content ~= nil then
			local xml = nxml.parse(content)
			xml:add_child(nxml.parse([[
				<LuaComponent script_death="data/archipelago/scripts/ap_death_component.lua"></LuaComponent>]]))
			ModTextFileSetContent(path, tostring(xml))
		else
			print("UH OH:" .. path)
		end
	end

	-- Boss Dragon is hardcoded weirdly, need to attach his original script_death back on
	local content = ModTextFileGetContent('data/entities/animals/boss_dragon.xml')
	if content ~= nil then
		local xml = nxml.parse(content)
		xml:add_child(nxml.parse([[
			<LuaComponent script_death="data/scripts/animals/boss_dragon_death.lua"></LuaComponent>]]))
		ModTextFileSetContent('data/entities/animals/boss_dragon.xml', tostring(xml))
	end

	if ModIsEnabled("Apotheosis") then
		for _, path in ipairs(apotheosisPatchEntities) do
			local content = ModTextFileGetContent(path)
			if content ~= nil then
				local xml = nxml.parse(content)
				xml:add_child(nxml.parse([[
					<LuaComponent script_death="data/archipelago/scripts/ap_death_component.lua"></LuaComponent>]]))
				ModTextFileSetContent(path, tostring(xml))
			else
				print("UH OH:" .. path)
			end
		end
	end

	for _, path in ipairs(onRemovePatchEntities) do
		local content = ModTextFileGetContent(path)
		if content ~= nil then
			local xml = nxml.parse(content)
			xml:add_child(nxml.parse([[
				<LuaComponent
					_enabled="1"
					script_death="data/archipelago/scripts/ap_death_component.lua"
					script_source_file="data/archipelago/scripts/ap_death_component.lua"
					execute_on_removed="1"
					execute_every_n_frame="-1">
				</LuaComponent>]]))
			ModTextFileSetContent(path, tostring(xml))
		else
			print("UH OH:" .. path)
		end
	end
	
end

APAddDeathComponent()