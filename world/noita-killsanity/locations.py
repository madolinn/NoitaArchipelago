# Locations are specific points that you would obtain an item at.
from enum import IntEnum
from typing import Dict, NamedTuple, Optional, Set

from BaseClasses import Location


class NoitaLocation(Location):
    game: str = "Noita-Killsanity"


class LocationData(NamedTuple):
    id: int
    flag: int = 0
    ltype: str = "Shop"


class LocationFlag(IntEnum):
    none = 0
    main_path = 1
    side_path = 2
    main_world = 3
    parallel_worlds = 4
    
class AnimalLocationFlag(IntEnum):
    none = 0
    main_path = 1
    side_path = 2
    reasonable = 3
    pain = 4
    never = 99


# Mapping of items in each region.
# Only the first Hidden Chest and Pedestal are mapped here, the others are created in Regions.
# ltype key: "Chest" = Hidden Chests, "Pedestal" = Pedestals, "Boss" = Boss, "Orb" = Orb, "Kill" = Animals.
# 110000-110671
location_region_mapping: Dict[str, Dict[str, LocationData]] = {
    "Coal Pits Holy Mountain": {
        "Coal Pits Holy Mountain Shop Item 1":   LocationData(110000),
        "Coal Pits Holy Mountain Shop Item 2":   LocationData(110001),
        "Coal Pits Holy Mountain Shop Item 3":   LocationData(110002),
        "Coal Pits Holy Mountain Shop Item 4":   LocationData(110003),
        "Coal Pits Holy Mountain Shop Item 5":   LocationData(110004),
        "Coal Pits Holy Mountain Spell Refresh": LocationData(110005),
    },
    "Snowy Depths Holy Mountain": {
        "Snowy Depths Holy Mountain Shop Item 1":   LocationData(110006),
        "Snowy Depths Holy Mountain Shop Item 2":   LocationData(110007),
        "Snowy Depths Holy Mountain Shop Item 3":   LocationData(110008),
        "Snowy Depths Holy Mountain Shop Item 4":   LocationData(110009),
        "Snowy Depths Holy Mountain Shop Item 5":   LocationData(110010),
        "Snowy Depths Holy Mountain Spell Refresh": LocationData(110011),
    },
    "Hiisi Base Holy Mountain": {
        "Hiisi Base Holy Mountain Shop Item 1":   LocationData(110012),
        "Hiisi Base Holy Mountain Shop Item 2":   LocationData(110013),
        "Hiisi Base Holy Mountain Shop Item 3":   LocationData(110014),
        "Hiisi Base Holy Mountain Shop Item 4":   LocationData(110015),
        "Hiisi Base Holy Mountain Shop Item 5":   LocationData(110016),
        "Hiisi Base Holy Mountain Spell Refresh": LocationData(110017),
    },
    "Underground Jungle Holy Mountain": {
        "Underground Jungle Holy Mountain Shop Item 1":   LocationData(110018),
        "Underground Jungle Holy Mountain Shop Item 2":   LocationData(110019),
        "Underground Jungle Holy Mountain Shop Item 3":   LocationData(110020),
        "Underground Jungle Holy Mountain Shop Item 4":   LocationData(110021),
        "Underground Jungle Holy Mountain Shop Item 5":   LocationData(110022),
        "Underground Jungle Holy Mountain Spell Refresh": LocationData(110023),
    },
    "Vault Holy Mountain": {
        "Vault Holy Mountain Shop Item 1":   LocationData(110024),
        "Vault Holy Mountain Shop Item 2":   LocationData(110025),
        "Vault Holy Mountain Shop Item 3":   LocationData(110026),
        "Vault Holy Mountain Shop Item 4":   LocationData(110027),
        "Vault Holy Mountain Shop Item 5":   LocationData(110028),
        "Vault Holy Mountain Spell Refresh": LocationData(110029),
    },
    "Temple of the Art Holy Mountain": {
        "Temple of the Art Holy Mountain Shop Item 1":   LocationData(110030),
        "Temple of the Art Holy Mountain Shop Item 2":   LocationData(110031),
        "Temple of the Art Holy Mountain Shop Item 3":   LocationData(110032),
        "Temple of the Art Holy Mountain Shop Item 4":   LocationData(110033),
        "Temple of the Art Holy Mountain Shop Item 5":   LocationData(110034),
        "Temple of the Art Holy Mountain Spell Refresh": LocationData(110035),
    },
    "Laboratory Holy Mountain": {
        "Laboratory Holy Mountain Shop Item 1":   LocationData(110036),
        "Laboratory Holy Mountain Shop Item 2":   LocationData(110037),
        "Laboratory Holy Mountain Shop Item 3":   LocationData(110038),
        "Laboratory Holy Mountain Shop Item 4":   LocationData(110039),
        "Laboratory Holy Mountain Shop Item 5":   LocationData(110040),
        "Laboratory Holy Mountain Spell Refresh": LocationData(110041),
    },
    "Secret Shop": {
        "Secret Shop Item 1": LocationData(110042),
        "Secret Shop Item 2": LocationData(110043),
        "Secret Shop Item 3": LocationData(110044),
        "Secret Shop Item 4": LocationData(110045),
    },
    "The Sky": {
        "Kivi": LocationData(110670, LocationFlag.main_world, "Boss"),
    },
    "Floating Island": {
        "Floating Island Orb": LocationData(110658, LocationFlag.main_path, "Orb"),
    },
    "Pyramid": {
        "Kolmisilmän Koipi": LocationData(110649, LocationFlag.main_world, "Boss"),
        "Pyramid Orb":       LocationData(110659, LocationFlag.main_world, "Orb"),
        "Sandcave Orb":      LocationData(110662, LocationFlag.main_world, "Orb"),
    },
    "Overgrown Cavern": {
        "Overgrown Cavern Chest":    LocationData(110526, LocationFlag.main_world, "Chest"),
        "Overgrown Cavern Pedestal": LocationData(110546, LocationFlag.main_world, "Pedestal"),
    },
    "Lake": {
        "Syväolento": LocationData(110651, LocationFlag.main_world, "Boss"),
        "Tapion vasalli": LocationData(110669, LocationFlag.main_world, "Boss"),
    },
    "Frozen Vault": {
        "Frozen Vault Orb":      LocationData(110660, LocationFlag.main_world, "Orb"),
        "Frozen Vault Chest":    LocationData(110566, LocationFlag.main_world, "Chest"),
        "Frozen Vault Pedestal": LocationData(110586, LocationFlag.main_world, "Pedestal"),
    },
    "Mines": {
        "Mines Chest":    LocationData(110046, LocationFlag.main_path, "Chest"),
        "Mines Pedestal": LocationData(110066, LocationFlag.main_path, "Pedestal"),
    },
    # Collapsed Mines is a very small area, combining it with the Mines. Leaving this here as a reminder

    "Ancient Laboratory": {
        "Ylialkemisti": LocationData(110656, LocationFlag.side_path, "Boss"),
    },
    "Abyss Orb Room": {
        "Sauvojen Tuntija": LocationData(110650, LocationFlag.side_path, "Boss"),
        "Abyss Orb":        LocationData(110665, LocationFlag.main_path, "Orb"),
    },
    "Below Lava Lake": {
        "Lava Lake Orb": LocationData(110661, LocationFlag.side_path, "Orb"),
    },
    "Coal Pits": {
        "Coal Pits Chest":    LocationData(110126, LocationFlag.main_path, "Chest"),
        "Coal Pits Pedestal": LocationData(110146, LocationFlag.main_path, "Pedestal"),
    },
    "Fungal Caverns": {
        "Fungal Caverns Chest":    LocationData(110166, LocationFlag.side_path, "Chest"),
        "Fungal Caverns Pedestal": LocationData(110186, LocationFlag.side_path, "Pedestal"),
    },
    "Snowy Depths": {
        "Snowy Depths Chest":    LocationData(110206, LocationFlag.main_path, "Chest"),
        "Snowy Depths Pedestal": LocationData(110226, LocationFlag.main_path, "Pedestal"),
    },
    "Magical Temple": {
        "Magical Temple Orb":  LocationData(110663, LocationFlag.side_path, "Orb"),
    },
    "Hiisi Base": {
        "Hiisi Base Chest":    LocationData(110246, LocationFlag.main_path, "Chest"),
        "Hiisi Base Pedestal": LocationData(110266, LocationFlag.main_path, "Pedestal"),
    },
    "Underground Jungle": {
        "Suomuhauki":                  LocationData(110648, LocationFlag.main_path, "Boss"),
        "Underground Jungle Chest":    LocationData(110286, LocationFlag.main_path, "Chest"),
        "Underground Jungle Pedestal": LocationData(110306, LocationFlag.main_path, "Pedestal"),
    },
    "Lukki Lair": {
        "Lukki Lair Orb":      LocationData(110664, LocationFlag.side_path, "Orb"),
        "Lukki Lair Chest":    LocationData(110326, LocationFlag.side_path, "Chest"),
        "Lukki Lair Pedestal": LocationData(110346, LocationFlag.side_path, "Pedestal"),
    },
    "The Vault": {
        "The Vault Chest":    LocationData(110366, LocationFlag.main_path, "Chest"),
        "The Vault Pedestal": LocationData(110386, LocationFlag.main_path, "Pedestal"),
    },
    "Temple of the Art": {
        "Gate Guardian":              LocationData(110652, LocationFlag.main_path, "Boss"),
        "Temple of the Art Chest":    LocationData(110406, LocationFlag.main_path, "Chest"),
        "Temple of the Art Pedestal": LocationData(110426, LocationFlag.main_path, "Pedestal"),
    },
    "The Tower": {
        "The Tower Chest":    LocationData(110606, LocationFlag.main_world, "Chest"),
        "The Tower Pedestal": LocationData(110626, LocationFlag.main_world, "Pedestal"),
    },
    "Wizards' Den": {
        "Mestarien Mestari":     LocationData(110655, LocationFlag.main_world, "Boss"),
        "Wizards' Den Orb":      LocationData(110668, LocationFlag.main_world, "Orb"),
        "Wizards' Den Chest":    LocationData(110446, LocationFlag.main_world, "Chest"),
        "Wizards' Den Pedestal": LocationData(110466, LocationFlag.main_world, "Pedestal"),
    },
    "Powerplant": {
        "Kolmisilmän silmä":    LocationData(110657, LocationFlag.main_world, "Boss"),
        "Power Plant Chest":    LocationData(110486, LocationFlag.main_world, "Chest"),
        "Power Plant Pedestal": LocationData(110506, LocationFlag.main_world, "Pedestal"),
    },
    "Snow Chasm": {
        "Unohdettu":      LocationData(110653, LocationFlag.main_world, "Boss"),
        "Snow Chasm Orb": LocationData(110667, LocationFlag.main_world, "Orb"),
    },
    "Meat Realm": {
        "Meat Realm Chest": LocationData(110086, LocationFlag.main_world, "Chest"),
        "Meat Realm Pedestal": LocationData(110106, LocationFlag.main_world, "Pedestal"),
        "Limatoukka": LocationData(110647, LocationFlag.main_world, "Boss"),
    },
    "West Meat Realm": {
        "Kolmisilmän sydän": LocationData(110671, LocationFlag.main_world, "Boss"),
    },
    "The Laboratory": {
        "Kolmisilmä": LocationData(110646, LocationFlag.main_path, "Boss"),
    },
    "Friend Cave": {
        "Toveri": LocationData(110654, LocationFlag.main_world, "Boss"),
    },
    "The Work (Hell)": {
        "The Work (Hell) Orb": LocationData(110666, LocationFlag.main_world, "Orb"),
    },
}

# Use an array to keep the ordering consistent. Sorry..
animal_location_names = [
    ["player", AnimalLocationFlag.main_path],
    ["sheep", AnimalLocationFlag.reasonable],
    ["sheep_bat", AnimalLocationFlag.reasonable],
    ["sheep_fly", AnimalLocationFlag.reasonable],
    ["scorpion", AnimalLocationFlag.main_path],
    ["fish", AnimalLocationFlag.main_path],
    ["fish_large", AnimalLocationFlag.side_path],
    ["duck", AnimalLocationFlag.reasonable],
    ["wolf", AnimalLocationFlag.reasonable],
    ["deer", AnimalLocationFlag.reasonable],
    ["elk", AnimalLocationFlag.reasonable],
    ["eel", AnimalLocationFlag.reasonable],
    ["zombie_weak", AnimalLocationFlag.main_path],
    ["zombie", AnimalLocationFlag.main_path],
    ["miner_weak", AnimalLocationFlag.main_path],
    ["miner", AnimalLocationFlag.main_path],
    ["miner_fire", AnimalLocationFlag.main_path],
    ["miner_santa", AnimalLocationFlag.never],
    ["miner_chef", AnimalLocationFlag.never],
    ["goblin_bomb", AnimalLocationFlag.main_path],
    ["shotgunner_weak", AnimalLocationFlag.main_path],
    ["shotgunner", AnimalLocationFlag.main_path],
    ["scavenger_smg", AnimalLocationFlag.main_path],
    ["scavenger_grenade", AnimalLocationFlag.main_path],
    ["scavenger_mine", AnimalLocationFlag.main_path],
    ["scavenger_heal", AnimalLocationFlag.main_path],
    ["scavenger_glue", AnimalLocationFlag.main_path],
    ["scavenger_invis", AnimalLocationFlag.main_path],
    ["scavenger_shield", AnimalLocationFlag.side_path],
    ["scavenger_poison", AnimalLocationFlag.main_path],
    ["scavenger_clusterbomb", AnimalLocationFlag.main_path],
    ["scavenger_leader", AnimalLocationFlag.main_path],
    ["alchemist", AnimalLocationFlag.main_path],
    ["sniper", AnimalLocationFlag.main_path],
    ["shaman", AnimalLocationFlag.main_path],
    ["coward", AnimalLocationFlag.main_path],
    ["flamer", AnimalLocationFlag.main_path],
    ["icer", AnimalLocationFlag.main_path],
    ["bigzombie", AnimalLocationFlag.main_path],
    ["bigzombietorso", AnimalLocationFlag.main_path],
    ["bigzombiehead", AnimalLocationFlag.main_path],
    ["slimeshooter_weak", AnimalLocationFlag.main_path],
    ["slimeshooter", AnimalLocationFlag.main_path],
    ["acidshooter_weak", AnimalLocationFlag.main_path],
    ["acidshooter", AnimalLocationFlag.main_path],
    ["lasershooter", AnimalLocationFlag.main_path],
    ["giantshooter_weak", AnimalLocationFlag.main_path],
    ["giantshooter", AnimalLocationFlag.main_path],
    ["miniblob", AnimalLocationFlag.main_path],
    ["blob", AnimalLocationFlag.main_path],
    ["ant", AnimalLocationFlag.side_path],
    ["rat", AnimalLocationFlag.main_path],
    ["bat", AnimalLocationFlag.main_path],
    ["bigbat", AnimalLocationFlag.main_path],
    ["firebug", AnimalLocationFlag.main_path],
    ["bigfirebug", AnimalLocationFlag.main_path],
    ["bloom", AnimalLocationFlag.main_path],
    ["shooterflower", AnimalLocationFlag.main_path],
    ["fly", AnimalLocationFlag.main_path],
    ["frog", AnimalLocationFlag.side_path],
    ["frog_big", AnimalLocationFlag.side_path],
    ["fungus", AnimalLocationFlag.main_path], #Laahustussieni
    ["fungus_big", AnimalLocationFlag.side_path], #Nuijamalikka
    ["fungus_giga", AnimalLocationFlag.side_path], #Huhtasieni
    ["lurker", AnimalLocationFlag.reasonable], #Varjokupla
    ["maggot", AnimalLocationFlag.side_path],
    ["skullrat", AnimalLocationFlag.main_path],
    ["skullfly", AnimalLocationFlag.main_path],
    ["tentacler_small", AnimalLocationFlag.main_path],
    ["tentacler", AnimalLocationFlag.main_path],
    ["ghoul", AnimalLocationFlag.pain], #Sylkyri
    ["giant", AnimalLocationFlag.main_path],
    ["pebble_physics", AnimalLocationFlag.reasonable], #Lohkare
    ["longleg", AnimalLocationFlag.main_path],
    ["lukki_tiny", AnimalLocationFlag.main_path],
    ["lukki", AnimalLocationFlag.main_path],
    ["lukki_longleg", AnimalLocationFlag.main_path],
    ["lukki_creepy_long", AnimalLocationFlag.reasonable],
    ["lukki_dark", AnimalLocationFlag.reasonable],
    ["worm_tiny", AnimalLocationFlag.reasonable],
    ["worm", AnimalLocationFlag.main_path],
    ["worm_big", AnimalLocationFlag.reasonable],
    ["worm_skull", AnimalLocationFlag.main_path],
    ["worm_end", AnimalLocationFlag.pain],
    ["drone_physics", AnimalLocationFlag.main_path], #Lennokki
    ["drone_lasership", AnimalLocationFlag.main_path], #Jättilaser-lennokki
    ["drone_shield", AnimalLocationFlag.side_path], #Turvalennokki
    ["basebot_sentry", AnimalLocationFlag.pain], #Tarkkailija
    ["basebot_hidden", AnimalLocationFlag.pain], #Vakoilija
    ["basebot_neutralizer", AnimalLocationFlag.pain], #Pysäyttäjä
    ["basebot_soldier", AnimalLocationFlag.pain], #Pysäyttäjä
    ["healerdrone_physics", AnimalLocationFlag.reasonable], #Korjauslennokki
    ["roboguard", AnimalLocationFlag.main_path], #Robottikyttä
    ["roboguard_big", AnimalLocationFlag.pain], #Kyrmyniska
    ["assassin", AnimalLocationFlag.main_path],
    ["spearbot", AnimalLocationFlag.main_path], #Peitsivartija
    ["tank", AnimalLocationFlag.main_path],
    ["tank_rocket", AnimalLocationFlag.main_path],
    ["tank_super", AnimalLocationFlag.main_path],
    ["turret_left", AnimalLocationFlag.never],
    ["turret_right", AnimalLocationFlag.main_path], #Torjuntalaite - Left inherits right; duplicate
    ["monk", AnimalLocationFlag.main_path],
    ["missilecrab", AnimalLocationFlag.main_path],
    ["necrobot", AnimalLocationFlag.reasonable],
    ["necrobot_super", AnimalLocationFlag.pain],
    ["fireskull", AnimalLocationFlag.main_path],
    ["iceskull", AnimalLocationFlag.main_path],
    ["thunderskull", AnimalLocationFlag.main_path],
    ["firemage_weak", AnimalLocationFlag.main_path],
    ["firemage", AnimalLocationFlag.main_path],
    ["icemage", AnimalLocationFlag.main_path],
    ["thundermage", AnimalLocationFlag.main_path],
    ["thundermage_big", AnimalLocationFlag.reasonable],
    ["barfer", AnimalLocationFlag.main_path],
    ["wizard_dark", AnimalLocationFlag.main_path],
    ["wizard_tele", AnimalLocationFlag.main_path],
    ["wizard_poly", AnimalLocationFlag.reasonable], #Only because they're so dangerous.
    ["wizard_swapper", AnimalLocationFlag.main_path],
    ["wizard_neutral", AnimalLocationFlag.main_path],
    ["wizard_returner", AnimalLocationFlag.main_path],
    ["wizard_hearty", AnimalLocationFlag.main_path],
    ["wizard_homing", AnimalLocationFlag.side_path],
    ["wizard_weaken", AnimalLocationFlag.side_path],
    ["wizard_twitchy", AnimalLocationFlag.main_path],
    ["enlightened_alchemist", AnimalLocationFlag.main_path],
    ["failed_alchemist", AnimalLocationFlag.main_path],
    ["failed_alchemist_b", AnimalLocationFlag.main_path],
    ["wraith", AnimalLocationFlag.main_path],
    ["wraith_storm", AnimalLocationFlag.pain],
    ["wraith_glowing", AnimalLocationFlag.main_path],
    ["statue", AnimalLocationFlag.side_path],
    ["statue_physics", AnimalLocationFlag.main_path],
    ["snowcrystal", AnimalLocationFlag.reasonable],
    ["hpcrystal", AnimalLocationFlag.reasonable],
    ["ghost", AnimalLocationFlag.main_path],
    ["wand_ghost", AnimalLocationFlag.side_path],
    ["ethereal_being", AnimalLocationFlag.reasonable],
    ["playerghost", AnimalLocationFlag.never], #Kummitus, good luck.
    ["phantom_a", AnimalLocationFlag.side_path],
    ["phantom_b", AnimalLocationFlag.side_path],
    ["confusespirit", AnimalLocationFlag.reasonable], #
    ["berserkspirit", AnimalLocationFlag.reasonable], # These 4 combined are just really uncommon, though technically available in numerous locations.
    ["weakspirit", AnimalLocationFlag.reasonable], #
    ["slimespirit", AnimalLocationFlag.reasonable], # 
    ["necromancer", AnimalLocationFlag.main_path],
    ["gazer", AnimalLocationFlag.pain],
    ["skygazer", AnimalLocationFlag.pain],
    ["spitmonster", AnimalLocationFlag.pain],
    ["crystal_physics", AnimalLocationFlag.main_path],
    ["bloodcrystal_physics", AnimalLocationFlag.pain],
    ["skycrystal_physics", AnimalLocationFlag.pain],
    ["chest_mimic", AnimalLocationFlag.pain],
    ["chest_leggy", AnimalLocationFlag.never], # Good luck ever finding this
    ["miner_hell", AnimalLocationFlag.pain],
    ["shotgunner_hell", AnimalLocationFlag.pain],
    ["sniper_hell", AnimalLocationFlag.pain],
    ["dark_alchemist", AnimalLocationFlag.never], # Good luck ever finding this x4
    ["shaman_wind", AnimalLocationFlag.never], # Good luck ever finding this x4
    ["necromancer_shop", AnimalLocationFlag.reasonable], #Steve
    ["necromancer_super", AnimalLocationFlag.reasonable],
    # Start bosses here. Most are handled by other logic, but we need to keep this list intact.
    ["boss_dragon", AnimalLocationFlag.never],
    ["boss_limbs", AnimalLocationFlag.never],
    ["boss_meat", AnimalLocationFlag.never],
    ["boss_alchemist", AnimalLocationFlag.never],
    ["parallel_alchemist", AnimalLocationFlag.pain],
    ["boss_ghost", AnimalLocationFlag.never],
    ["boss_ghost_polyp", AnimalLocationFlag.never],
    ["islandspirit", AnimalLocationFlag.never],
    ["boss_pit", AnimalLocationFlag.never],
    ["boss_robot", AnimalLocationFlag.never],
    ["fish_giga", AnimalLocationFlag.never],
    ["maggot_tiny", AnimalLocationFlag.never],
    ["parallel_tentacles", AnimalLocationFlag.pain],
    ["minipit", AnimalLocationFlag.never],
    ["gate_monster_a", AnimalLocationFlag.never],
    ["gate_monster_b", AnimalLocationFlag.never],
    ["gate_monster_c", AnimalLocationFlag.never],
    ["gate_monster_d", AnimalLocationFlag.never],
    ["boss_wizard", AnimalLocationFlag.never],
    ["boss_centipede", AnimalLocationFlag.never],
    ["ultimate_killer", AnimalLocationFlag.never],
    ["friend", AnimalLocationFlag.never],
]

for ind, animal in enumerate(animal_location_names):
    locname = "Kill " + animal[0].replace("_", " ").title()
    location_region_mapping["Coal Pits"][locname] = LocationData(ind + 112000 + 1, animal[1], "Kill") # Lua starts at 1


def make_location_range(location_name: str, base_id: int, amt: int) -> Dict[str, int]:
    if amt == 1:
        return {location_name: base_id}
    return {f"{location_name} {i+1}": base_id + i for i in range(amt)}


location_name_groups: Dict[str, Set[str]] = {"Shop": set(), "Orb": set(), "Boss": set(), "Chest": set(),
                                             "Pedestal": set(), "Kill": set()}
location_name_to_id: Dict[str, int] = {}


for region_name, location_group in location_region_mapping.items():
    location_name_groups[region_name] = set()
    for locname, locinfo in location_group.items():
        # Iterating the hidden chest and pedestal locations here to avoid clutter above
        amount = 20 if locinfo.ltype in ["Chest", "Pedestal"] else 1
        entries = make_location_range(locname, locinfo.id, amount)

        location_name_to_id.update(entries)
        location_name_groups[locinfo.ltype].update(entries.keys())
        location_name_groups[region_name].update(entries.keys())

shop_locations = {name for name in location_name_to_id.keys() if "Shop Item" in name}