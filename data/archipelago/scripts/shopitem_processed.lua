-- Script run when shop item is picked up
dofile_once("data/scripts/lib/utilities.lua")
local JSON = dofile("data/archipelago/lib/json.lua")
local Globals = dofile("data/archipelago/scripts/globals.lua")


local function decodeXML(str)
	return str:gsub("&quot;", "\"")
end


local function get_transferred_values(entity_id)
	local component = get_variable_storage_component(entity_id, "ap_shop_data")
	local data_str = ComponentGetValue2(component, "value_string")
	return JSON:decode(decodeXML(data_str))
end


-- Calculates the X offset for the text of the price, used to center the text over the item
local function get_cost_x_offset(price)
	local text = tostring(price)
	local textwidth = 0

	for i=1,#text do
		local l = string.sub( text, i, i )

		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	return textwidth * 0.5 - 0.5
end -- get_cost_x_offset


-- Called when the entity gets created
function init(entity_id)
	if EntityGetFirstComponent(entity_id, "ItemCostComponent", "shop_cost") ~= nil then return end
	local data = get_transferred_values(entity_id)
	if data.price <= 0 then return end

	local x, y = EntityGetTransform(entity_id)

	-- These are typical shopitem components that would get added in Noita's vanilla shopitem file
	if data.sale then
		EntityLoad("data/entities/misc/sale_indicator.xml", x, y)
	end

	-- https://noita.wiki.gg/wiki/Documentation:_SpriteComponent
	EntityAddComponent(entity_id, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml",
		is_text_sprite="1", 
		offset_x=tostring(get_cost_x_offset(data.price)),
		offset_y="20",
		update_transform="1",
		update_transform_rotation="0",
		text=tostring(data.price),
		z_index="-1",
	})

	local is_stealable = 0
	if BiomeMapGetName(x, y) == "$biome_holymountain" then
		is_stealable = 1
	end
	-- https://noita.wiki.gg/wiki/Documentation:_ItemCostComponent
	EntityAddComponent(entity_id, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world",
		cost=data.price,
		stealable=is_stealable
	})

	-- https://noita.wiki.gg/wiki/Documentation:_LuaComponent
	EntityAddComponent(entity_id, "LuaComponent", {
		script_item_picked_up="data/scripts/items/shop_effect.lua"
	})

	-- We also want to disable auto-pickup on any other items
	edit_all_components2(entity_id, "ItemComponent", function(comp,vars)
		vars.auto_pickup = false
	end)
end


-- Called when the entity is picked up
function item_pickup(entity_item, entity_who_picked, name)
	local data = get_transferred_values(entity_item)
	local component_id = get_variable_storage_component(entity_item, "ap_shop_data")
	EntityRemoveComponent(entity_item, component_id)
	GameAddFlagRun("ap" .. data.location_id)
	Globals.LocationUnlockQueue:append(data.location_id)
end

function death ( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items, ... )
	local entity_id = GetUpdatedEntityID()
	item_pickup(entity_id)
end