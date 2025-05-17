function APPatchPerkPickup()
	local fullPath = "data/scripts/perks/perk.lua"
	local content = ModTextFileGetContent(fullPath)
	content = content:gsub(
		"if entity_perk ~= entity_item then",
		"if entity_perk ~= entity_item and EntityHasTag(entity_perk, \"ap_perk\") ~= true then"
	);
	ModTextFileSetContent(fullPath, tostring(content))
end

APPatchPerkPickup()