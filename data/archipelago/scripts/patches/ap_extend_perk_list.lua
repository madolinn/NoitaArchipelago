local item_table = dofile("data/archipelago/scripts/item_mappings.lua")

local function ap_extend_perk_list()
	local function remove_from_pool(perk_name)
		for _, perk in pairs(perk_list) do
			if (perk.id == perk_name) then
				perk.not_in_default_perk_pool = true
			end
		end
	end

	remove_from_pool("PROTECTION_ELECTRICITY")
	remove_from_pool("PROTECTION_MELEE")
	remove_from_pool("PROTECTION_RADIOACTIVITY")
	remove_from_pool("PROTECTION_FIRE")
	remove_from_pool("PROTECTION_EXPLOSION")
	remove_from_pool("EDIT_WANDS_EVERYWHERE")
	remove_from_pool("REMOVE_FOG_OF_WAR")

	table.insert(perk_list,
			{
	id = "AP_LEGGY_FEET",
	ui_name = "$perk_ap_leggy_feet",
	ui_description = "$perkdesc_ap_leggy_feet",
	ui_icon = "data/archipelago/entities/items/icons/ap_leggy_feet_perk_ui_icon.png",
	perk_icon = "data/archipelago/entities/items/icons/ap_leggy_feet_perk_icon.png",
	stackable = STACKABLE_YES,
	stackable_is_rare = true,
	usable_by_enemies = true,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name, pickup_count )
		local x, y = EntityGetTransform( entity_who_picked )
		local child_id
		local is_stacking = GameHasFlagRun( "AP_ATTACK_FOOT_CLIMBER" )

		local function add_leg(identifier)
			local leg_child_id = EntityLoad("data/archipelago/entities/animals/legs/chest_limb_" .. identifier .. ".xml", x, y)
			EntityAddComponent2(leg_child_id, "InheritTransformComponent")
			local walker_id = EntityGetFirstComponent(leg_child_id, "IKLimbWalkerComponent")
			ComponentSetValue2(walker_id, "affect_flying", true)
			EntityAddTag(leg_child_id, "perk_entity")
			EntityAddTag(leg_child_id, "ap_leggy_foot_walker")
			EntityAddChild(entity_who_picked, leg_child_id)
		end

		child_id = EntityLoad( "data/entities/misc/perks/attack_leggy/leggy_limb_attacker.xml", x, y )
		EntityAddTag(child_id, "perk_entity")
		EntityAddChild( entity_who_picked, child_id )

		local num_legs = #EntityGetInRadiusWithTag(x, y, 40, "ap_leggy_foot_walker")

		if num_legs ~= 0 then
			if num_legs%3 == 0 then
				add_leg("left_red")
				add_leg("right_orange")
			elseif num_legs%3 == 1 then
				add_leg("left_yellow")
				add_leg("right_green")
			elseif num_legs%3 == 2 then
				add_leg("left_blue")
				add_leg("right_pink")
			end
		end

		if not is_stacking then
			add_leg("left_red")
			add_leg("left_yellow")
			add_leg("left_blue")
			add_leg("right_green")
			add_leg("right_pink")
			add_leg("right_orange")
			child_id = EntityLoad( "data/entities/misc/perks/attack_foot/limb_climb.xml", x, y )
			EntityAddTag( child_id, "perk_entity" )
			EntityAddChild( entity_who_picked, child_id )
			GameAddFlagRun( "AP_ATTACK_FOOT_CLIMBER" )
		else
			-- add length to limbs
			for _,v in ipairs(EntityGetAllChildren(entity_who_picked)) do
				if EntityHasTag(v, "ap_leggy_foot_walker") then
					component_readwrite(EntityGetFirstComponent(v, "IKLimbComponent"), { length = 50 }, function(comp)
						comp.length = comp.length * 1.5
					end)
				end
			end
		end

		local platformingcomponents = EntityGetComponent( entity_who_picked, "CharacterPlatformingComponent" )
		if platformingcomponents ~= nil then
			for _, component in ipairs(platformingcomponents) do
				local run_speed = tonumber( ComponentGetMetaCustom( component, "run_velocity" ) ) * 1.25
				local vel_x = math.abs( tonumber( ComponentGetMetaCustom( component, "velocity_max_x" ) ) ) * 1.25

				local vel_x_min = 0 - vel_x
				local vel_x_max = vel_x

				ComponentSetMetaCustom( component, "run_velocity", run_speed )
				ComponentSetMetaCustom( component, "velocity_min_x", vel_x_min )
				ComponentSetMetaCustom( component, "velocity_max_x", vel_x_max )
			end
		end

		perk_pickup_event("LUKKI")

		if pickup_count <= 2 then
			add_lukkiness_level(entity_who_picked)
		end
	end,
	func_remove = function( entity_who_picked )
		reset_perk_pickup_event("LUKKI")
		GameRemoveFlagRun( "AP_ATTACK_FOOT_CLIMBER" )
		local platformingcomponents = EntityGetComponent( entity_who_picked, "CharacterPlatformingComponent" )
		if platformingcomponents ~= nil then
			for _, component in ipairs(platformingcomponents) do
				ComponentSetMetaCustom( component, "run_velocity", 154 )
				ComponentSetMetaCustom( component, "velocity_min_x", -57 )
				ComponentSetMetaCustom( component, "velocity_max_x", 57 )
			end
		end
	end,
	})

	for _, item in pairs(item_table) do
		if item.soul ~= nil then

			local icon_name = item.perk:gsub("AP_SOUL_", ""):lower()
			if icon_name == "gate_guardian" then icon_name = "gate_monster_b" end

			table.insert(perk_list,
				{
					id = item.perk,
					ui_name = "$perk_" .. item.perk,
					ui_description = "$perkdesc_" .. item.perk,
					ui_icon = "data/ui_gfx/animal_icons/" .. icon_name  .. ".png",
					perk_icon = "data/ui_gfx/animal_icons/" .. icon_name .. ".png",
					usable_by_enemies = false,
					stackable = STACKABLE_NO,
					max_in_perk_pool = 1,
					not_in_default_perk_pool = true,
					func = function( entity_perk_item, entity_who_picked, item_name )
						GlobalsSetValue( item.perk, "1" )
					end,
					func_remove = function( entity_who_picked )
						GlobalsSetValue( item.perk, "0" )
					end,
				}
			)
		end
	end

end

ap_extend_perk_list()
