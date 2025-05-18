local nxml = dofile_once("data/archipelago/lib/nxml.lua")


local ForgeList = {
	"data/entities/items/books/base_book.xml",
	"data/entities/misc/custom_cards/summon_portal_broken.xml",
	"data/entities/items/pickup/broken_wand.xml"
}

function APAddForgedComponent()
	for _, entityPath in ipairs(ForgeList) do
		local content = ModTextFileGetContent(entityPath)
		local xml = nxml.parse(content)
		xml:add_child(nxml.parse([[
			<LuaComponent
				_tags="enabled_in_world"
				script_source_file="data/archipelago/scripts/ap_forged_component.lua"
				execute_on_removed="1"
				execute_every_n_frame="-1">
			</LuaComponent>]]))
		ModTextFileSetContent(entityPath, tostring(xml))
	end
end

APAddForgedComponent()