dofile_once("data/archipelago/scripts/ap_utils.lua")

function death ( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items, ... )
	local need_credit = GlobalsGetValue("ap_animals_need_credit")

	local flag = true
	
	--[[
	-- Unfortunately all kills that aren't environmental are considered killed by Mina 
	if need_credit == 1 then
		if EntityHasTag(entity_thats_responsible, "player_unit") then
			flag = true
		end
	else
		flag = true
	end
	]]
	
	if flag then
		local Globals = dofile("data/archipelago/scripts/globals.lua")
	
		local entity_id = GetUpdatedEntityID()
		local filename = EntityGetFilename(entity_id)

		print(filename)
	
		filename:gsub("/([^/.]+).xml", function(name)
			if name == "turret_left" then name = "turret_right" end -- Thanks Noita :(

			local location_id = getLocationByAnimalName(name)
			print(location_id)
			if location_id ~= nil then
				GameAddFlagRun("ap" .. location_id)
				Globals.LocationUnlockQueue:append(location_id)
			else
				print("BAD FILENAME?:", filename, name)
			end
		end)
	end
end