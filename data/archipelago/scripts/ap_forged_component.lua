dofile_once("data/archipelago/scripts/ap_utils.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if EntityHasTag(entity_id, "tablet") then
	-- Handle Tablet Forges.
	local my_comps = EntityGetComponent( entity_id, "ItemComponent" )
	local my_desc = ""
	
	if ( my_comps ~= nil ) then
		for _,itemc in ipairs(my_comps) do
			my_desc = ComponentGetValue2( itemc, "ui_description" )
		end
	end

	for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "forged_tablet")) do
		local item_comps = EntityGetComponent( id, "ItemComponent" )

		if ( item_comps ~= nil ) then
			for _,itemc in ipairs(item_comps) do
				local item_desc = ComponentGetValue( itemc, "ui_description" )
				if ( my_desc .. "_forged" == item_desc) then
					local AP = dofile("data/archipelago/scripts/constants.lua")
					local Globals = dofile("data/archipelago/scripts/globals.lua")

					local location_id_offset = my_desc:gsub("[^%d]", "")
					local location_id = AP.FIRST_TABLET_ID + location_id_offset -- There actually is a 0th book surprisingly.
					GameAddFlagRun("ap" .. location_id)
					Globals.LocationUnlockQueue:append(location_id)
				end
			end
		end
	end
elseif EntityHasTag(entity_id, "broken_wand") then
	-- Handle Broken Wand Forge.
	for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "wand")) do
		local item_comps = EntityGetComponent( id, "ItemComponent" )

		if ( item_comps ~= nil ) then
			for _,itemc in ipairs(item_comps) do
				local is_hovering = ComponentGetValue( itemc, "play_hover_animation" )
				if is_hovering == "1" then
					local AP = dofile("data/archipelago/scripts/constants.lua")
					local Globals = dofile("data/archipelago/scripts/globals.lua")

					local location_id = AP.FORGE_WAND_ID
					GameAddFlagRun("ap" .. location_id)
					Globals.LocationUnlockQueue:append(location_id)
				end
			end
		end
	end
elseif EntityHasTag(entity_id, "card_summon_portal_broken") then
	-- Handle Portal Spell Forge.
	for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "card_action")) do
		local item_comps = EntityGetComponent( id, "ItemActionComponent" )
		if ( item_comps ~= nil ) then
			for _,itemc in ipairs(item_comps) do
				local item_action = ComponentGetValue( itemc, "action_id" )
				if item_action == "SUMMON_PORTAL" then
					local AP = dofile("data/archipelago/scripts/constants.lua")
					local Globals = dofile("data/archipelago/scripts/globals.lua")
					
					local location_id = AP.FORGE_SPELL_ID
					GameAddFlagRun("ap" .. location_id)
					Globals.LocationUnlockQueue:append(location_id)
				end
			end
		end
	end
end