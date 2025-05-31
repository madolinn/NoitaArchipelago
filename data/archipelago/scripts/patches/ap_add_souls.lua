--local nxml = dofile_once("data/archipelago/lib/nxml.lua")

local vanillaPatchEntities = {
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
	'data/entities/animals/boss_meat/boss_meat.xml',
	'data/entities/animals/boss_alchemist/boss_alchemist.xml',
	'data/entities/animals/parallel/alchemist/parallel_alchemist.xml',
	'data/entities/buildings/wizardcave_gate_monster_spawner.xml',
	'data/entities/animals/ultimate_killer.xml',
	'data/entities/animals/friend.xml',
	'data/entities/animals/boss_sky/boss_sky.xml',
}

for _, path in ipairs(vanillaPatchEntities) do
	local path_info = {}
	for split in path:gmatch("[^%.]+") do table.insert(path_info, split) end
	local real_data = ModTextFileGetContent(path)
	local new_path  = path_info[1] .. "_real." .. path_info[2]
	local entity_name = path_info[1]:match("[^/]+$")

	if entity_name == "wizardcave_gate_monster_spawner" then
		entity_name = "gate_guardian"
	end

	ModTextFileSetContent(new_path, real_data)

	ModTextFileSetContent(path, string.format([[
<Entity>
	<LuaComponent
		script_source_file="data/archipelago/scripts/ap_soul_check_component.lua"
		execute_every_n_frame="36"
		>
	</LuaComponent>
	<VariableStorageComponent
		name="spawn_entity"
		value_string="%s"
	/>
	<VariableStorageComponent
		name="soul_id"
		value_string="%s"
	/>
</Entity>
]], new_path, "AP_SOUL_" .. entity_name:upper()))

end

local function addSoulToSampo()
	local path = 'data/entities/animals/boss_centipede/sampo.xml'

	local path_info = {}
	for split in path:gmatch("[^%.]+") do table.insert(path_info, split) end
	local real_data = ModTextFileGetContent(path)
	local new_path  = path_info[1] .. "_real." .. path_info[2]

	ModTextFileSetContent(new_path, real_data)

	ModTextFileSetContent(path, string.format([[
<Entity>
	<LuaComponent
		script_source_file="data/archipelago/scripts/ap_soul_check_component.lua"
		execute_every_n_frame="36"
		>
	</LuaComponent>
	<VariableStorageComponent
		name="spawn_entity"
		value_string="%s"
	/>
	<VariableStorageComponent
		name="soul_id"
		value_string="%s"
	/>
</Entity>
]], new_path, "AP_SOUL_BOSS_CENTIPEDE"))

end

addSoulToSampo()