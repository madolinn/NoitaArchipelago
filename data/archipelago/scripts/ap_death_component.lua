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
		local Animals = dofile("data/archipelago/scripts/ap_animal_mapping.lua")

		local entity_id = GetUpdatedEntityID()
		local filename = EntityGetFilename(entity_id)

		print("[KILLED] " .. filename)
		return

		filename:gsub("/([^/.]+).xml", function(name)
			if name == "turret_left" then name = "turret_right" -- Thanks Noita :(
			elseif name == "suspended_seamine" then name = "seamine" end

			if (EntityHasTag(entity_id, "ap_death_proc")) then
				print("already processed:" .. name)
				return
			end
			EntityAddTag(entity_id, "ap_death_proc")

			local location_id = Animals["by_animal_name"][name]
			if location_id ~= nil then
				print(name .. ":" .. location_id)
				GameAddFlagRun("ap" .. location_id)
				Globals.LocationUnlockQueue:append(location_id)
			else
				print("KILLSANITY CANDIDATE:", filename, name)
			end
		end)
	end
end