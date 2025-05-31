-- Keeping this slim to prevent conflicts when included in patch files
-- redeliverable means it will be delivered in async
-- newgame means it will be delivered on new game
return {
	[110000] = {},	-- Trap

	[110001] = { items = { "data/entities/items/pickup/heart.xml" }, redeliverable = true, newgame = true },
	[110002] = { items = { "data/entities/items/pickup/spell_refresh.xml" }, redeliverable = true },
	[110003] = { items = { "data/entities/items/pickup/potion.xml" }, potion = true },

	[110004] = { items = { "data/entities/items/pickup/goldnugget_200.xml" }, gold_amount = 200, redeliverable = true },
	[110005] = { items = { "data/entities/items/pickup/goldnugget_1000.xml" }, gold_amount = 1000, redeliverable = true },

	[110006] = { items = { "data/entities/items/wand_level_01.xml", "data/entities/items/wand_unshuffle_01.xml" }, redeliverable = true, newgame = true, wand = true },
	[110007] = { items = { "data/entities/items/wand_level_02.xml", "data/entities/items/wand_unshuffle_02.xml" }, redeliverable = true, newgame = true, wand = true },
	[110008] = { items = { "data/entities/items/wand_level_03.xml", "data/entities/items/wand_unshuffle_03.xml" }, redeliverable = true, newgame = true, wand = true },
	[110009] = { items = { "data/entities/items/wand_level_04.xml", "data/entities/items/wand_unshuffle_04.xml" }, redeliverable = true, newgame = true, wand = true },
	[110010] = { items = { "data/entities/items/wand_level_05.xml", "data/entities/items/wand_unshuffle_05.xml" }, redeliverable = true, newgame = true, wand = true },
	[110011] = { items = { "data/entities/items/wand_level_06.xml", "data/entities/items/wand_unshuffle_06.xml" }, redeliverable = true, newgame = true, wand = true },
	[110012] = { items = { "data/archipelago/entities/items/ap_kantele.xml" }, redeliverable = true, newgame = true, wand = true },

	[110013] = { perk = "PROTECTION_FIRE", redeliverable = true, newgame = true },
	[110014] = { perk = "PROTECTION_RADIOACTIVITY", redeliverable = true, newgame = true },
	[110015] = { perk = "PROTECTION_EXPLOSION", redeliverable = true, newgame = true },
	[110016] = { perk = "PROTECTION_MELEE", redeliverable = true, newgame = true },
	[110017] = { perk = "PROTECTION_ELECTRICITY", redeliverable = true, newgame = true },
	[110018] = { perk = "EDIT_WANDS_EVERYWHERE", redeliverable = true, newgame = true },
	[110019] = { perk = "REMOVE_FOG_OF_WAR", redeliverable = true, newgame = true },
	[110020] = { perk = "MAP", redeliverable = true, newgame = true }, -- spatial awareness perk, for runs including toveri boss
	[110021] = { perk = "RESPAWN", redeliverable = true, newgame = true }, -- extra life

	[110022] = { items = { "mods/archipelago/data/archipelago/entities/items/orbs/ap_orb_randomizer_spawned.xml" }, orb = true, redeliverable = true, newgame = true },

	[110023] = { items = { "data/entities/items/pickup/potion_random_material.xml" }, potion = true }, -- random potion
	[110024] = { items = { "data/entities/items/pickup/potion_secret.xml" }, potion = true }, -- secret potion
	[110025] = { items = { "data/entities/items/pickup/powder_stash.xml" }, redeliverable = true, newgame = true }, -- powder pouch
	[110026] = { items = { "data/entities/items/pickup/physics_die.xml" } }, -- chaos die
	[110027] = { items = { "data/entities/items/pickup/physics_greed_die.xml" } }, -- greed die
	[110028] = { items = { "data/entities/items/pickup/safe_haven.xml" }, redeliverable = true, newgame = true }, -- kammi
	[110029] = { items = { "data/entities/items/pickup/gourd.xml" }, redeliverable = true, newgame = true }, -- gourd
	[110030] = { items = { "data/entities/items/pickup/beamstone.xml" }, redeliverable = true, newgame = true }, -- sadekivi
	[110031] = { items = { "data/entities/items/pickup/broken_wand.xml" }, redeliverable = true, newgame = true }, -- broken wand

	[110032] = { items = { "data/archipelago/entities/items/pw_teleporter.xml" }, redeliverable = true, newgame = true, wand = true }, -- pw teleporter for pw options

	[110033] = { spells = { "GAMMA" }, redeliverable = true, newgame = true },

	[110161] = { perk = "AP_SOUL_BOSS_DRAGON", soul = "Suomuhauki", rediverable = true, newgame = true },
	[110162] = { perk = "AP_SOUL_BOSS_LIMBS", soul = "Kolmisilmän Koipi", rediverable = true, newgame = true },
	[110163] = { perk = "AP_SOUL_BOSS_MEAT", soul = "Kolmisilmän sydän", rediverable = true, newgame = true },
	[110164] = { perk = "AP_SOUL_BOSS_ALCHEMIST", soul = "Ylialkemisti", rediverable = true, newgame = true },
	[110165] = { perk = "AP_SOUL_PARALLEL_ALCHEMIST", soul = "Alkemistin Varjo", rediverable = true, newgame = true },
	[110166] = { perk = "AP_SOUL_BOSS_GHOST", soul = "Unohdettu", rediverable = true, newgame = true },
	[110167] = { perk = "AP_SOUL_BOSS_GHOST_POLYP", soul = "Häive", rediverable = true, newgame = true },
	[110168] = { perk = "AP_SOUL_ISLANDSPIRIT", soul = "Tapion vasalli", rediverable = true, newgame = true },
	[110169] = { perk = "AP_SOUL_BOSS_PIT", soul = "Sauvojen tuntija", rediverable = true, newgame = true },
	[110170] = { perk = "AP_SOUL_BOSS_ROBOT", soul = "Kolmisilmän silmä", rediverable = true, newgame = true },
	[110171] = { perk = "AP_SOUL_FISH_GIGA", soul = "Syväolento", rediverable = true, newgame = true },
	[110172] = { perk = "AP_SOUL_MAGGOT_TINY", soul = "Limatoukka", rediverable = true, newgame = true },
	[110173] = { perk = "AP_SOUL_PARALLEL_TENTACLES", soul = "Kolmisilmän Kätyri", rediverable = true, newgame = true },
	[110174] = { perk = "AP_SOUL_GATE_GUARDIAN", soul = "Gate Guardian", rediverable = true, newgame = true },

	[110178] = { perk = "AP_SOUL_BOSS_WIZARD", soul = "Mestarien mestari", rediverable = true, newgame = true },
	[110179] = { perk = "AP_SOUL_BOSS_CENTIPEDE", soul = "Kolmisilmä", rediverable = true, newgame = true },
	[110180] = { perk = "AP_SOUL_ULTIMATE_KILLER", soul = "Kauhuhirviö", rediverable = true, newgame = true },
	[110181] = { perk = "AP_SOUL_FRIEND", soul = "Toveri", rediverable = true, newgame = true },
	[110182] = { perk = "AP_SOUL_BOSS_SKY", soul = "Kivi", rediverable = true, newgame = true },

}
