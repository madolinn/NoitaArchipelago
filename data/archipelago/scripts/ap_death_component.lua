dofile_once("data/archipelago/scripts/ap_utils.lua")

function death ( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items, ... )
	local need_credit = GlobalsGetValue("ap_animals_need_credit")
	
	local flag = false
	
	if need_credit == 1 then
		if EntityHasTag(entity_thats_responsible, "player_unit") then
			flag = true
		end
	else
		flag = true
	end
	
	if flag then
		local Globals = dofile("data/archipelago/scripts/globals.lua")
	
		local entity_id = GetUpdatedEntityID()
		local filename = EntityGetFilename(entity_id)
	
		filename:gsub("/([^/.]+).xml", function(name)
			local location_id = getLocationByAnimalName(name)
			GameAddFlagRun("ap" .. location_id)
			Globals.LocationUnlockQueue:append(location_id)
		end)
	end
end