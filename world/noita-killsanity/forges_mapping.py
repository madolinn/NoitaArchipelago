from enum import IntEnum
from typing import Dict, NamedTuple

class ForgeLocationFlag(IntEnum):
    none = 0
    items_only = 1
    side_path = 2
    main_world = 3
    never = 99

class ForgeLocation(NamedTuple):
    id: int
    region: str
    flag: ForgeLocationFlag = 99
    ltype = "Forge"
    mod: int = 0

location_forge_mapping: Dict[str, ForgeLocation] = {
	"Forge Emerald Tablet - Volume I": ForgeLocation(111900, "The Sky"), #Unforgeable
	"Forge Emerald of Thoth": ForgeLocation(111901, "Pyramid"), #Unforgeable
	"Forge Emerald Tablet - Volume II": ForgeLocation(111902, "Frozen Vault", ForgeLocationFlag.main_world),
	"Forge Emerald Tablet - Volume III": ForgeLocation(111903, "Below Lava Lake"), #Unforgeable
	"Forge Emerald Tablet - Volume IV": ForgeLocation(111904, "Sandcave", ForgeLocationFlag.main_world),
	"Forge Emerald Tablet - Volume V": ForgeLocation(111905, "Magical Temple", ForgeLocationFlag.side_path),
	"Forge Emerald Tablet - Volume VI": ForgeLocation(111906, "Lukki Lair", ForgeLocationFlag.side_path),
	"Forge Emerald Tablet - Volume VII": ForgeLocation(111907, "Hiisi Base", ForgeLocationFlag.side_path), #Hiisi Base is the earliest zone we can place the check, since the anvil is in it.
	"Forge Emerald Tablet - Volume VIII": ForgeLocation(111908, "The Work (Hell)", ForgeLocationFlag.main_world),
	"Forge Emerald Tablet - Volume IX": ForgeLocation(111909, "Snowy Chasm", ForgeLocationFlag.main_world),
	"Forge Emerald Tablet - Volume X": ForgeLocation(111910, "Desert Chasm", ForgeLocationFlag.main_world),

	"Forge Portal Spell": ForgeLocation(111899, "Hiisi Base", ForgeLocationFlag.items_only),
	"Forge Broken Wand": ForgeLocation(111898, "Hiisi Base", ForgeLocationFlag.items_only),
}