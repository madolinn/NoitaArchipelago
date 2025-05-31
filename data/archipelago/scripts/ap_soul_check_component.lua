dofile("data/archipelago/scripts/ap_utils.lua")
local Animals = dofile("data/archipelago/scripts/ap_animal_mapping.lua")

local entity_id = GetUpdatedEntityID()
local need_credit = GlobalsGetValue("ap_animals_need_credit")

local spawn_entity = getInternalVariableValue(entity_id, "spawn_entity", "value_string")
local soul_id = getInternalVariableValue(entity_id, "soul_id", "value_string")

local function handle_special_spawns(entity)
	--if soul_id == "AP_SOUL_BOSS_CENTIPEDE" then
	--	dofile("data/entities/animals/boss_centipede/sampo_pickup.lua")
	--end
end

local function spawn_real_entity()
	local x, y = EntityGetTransform(entity_id)
	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
	local spawned_boss = EntityLoad(spawn_entity, x, y)
	handle_special_spawns(spawned_boss)
	EntityKill(entity_id)
end

if spawn_entity == nil or soul_id == nil then
	print("SoulCheck spawned with improper setup, cleaning up")
	EntityKill(entity_id)
	return
end

if GlobalsGetValue("ap_souls_enabled", "-1") == "0" or GlobalsGetValue(soul_id, "0") == "1" then
	spawn_real_entity()
elseif GlobalsGetValue("ap_souls_enabled", "-1") == "1" then
	local entity_name = soul_id:gsub("AP_SOUL_", ""):lower()
	local boss_threshold = tonumber(GlobalsGetValue("ap_bosses_as_checks", "0"))
	local entity_path = Animals.path_data[entity_name]
	if entity_path ~= nil then
		if entity_path > boss_threshold then
			spawn_real_entity()
		end
	else
		print("SoulsCheck: " .. entity_name .. " is missing from the mappings; we're spawning them to be safe.")
		spawn_real_entity()
	end
end