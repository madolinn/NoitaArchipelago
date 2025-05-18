dofile_once("data/scripts/lib/utilities.lua")
local Globals = dofile("data/archipelago/scripts/globals.lua")
dofile_once("data/archipelago/scripts/ap_utils.lua")


-- Called when the entity is picked up
function item_pickup(entity_item, entity_who_picked, name)
	local location_id = getInternalVariableValue(entity_item, "ap_location_id", "value_int")
	GameAddFlagRun("ap" .. location_id)
	Globals.LocationUnlockQueue:append(location_id)
end

function death ( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items, ... )
	local entity_id = GetUpdatedEntityID()
	if entity_id ~= nil then
		item_pickup(entity_id)
	end
end