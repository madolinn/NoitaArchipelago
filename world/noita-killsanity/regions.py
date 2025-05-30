# Regions are areas in your game that you travel to.
from typing import Dict, List, TYPE_CHECKING

from BaseClasses import Entrance, Region
from . import locations
from .events import create_all_events

if TYPE_CHECKING:
    from . import NoitaWorld


def create_locations(world: "NoitaWorld", region: Region) -> None:
    locs = locations.location_region_mapping.get(region.name, {})
    for location_name, location_data in locs.items():
        location_type = location_data.ltype
        mod_type = location_data.mod
        flag = location_data.flag

        is_orb_allowed = location_type == "Orb" and flag <= world.options.orbs_as_checks
        is_boss_allowed = location_type == "Boss" and flag <= world.options.bosses_as_checks
        is_animal_allowed = location_type == "Kill" and flag <= world.options.animals_as_checks
        is_forge_allowed = location_type == "Forge" and flag <= world.options.forges_as_checks

        is_mod_allowed = mod_type <= world.options.apotheosis_enabled

        amount = 0
        if is_mod_allowed:
            if flag == locations.LocationFlag.none or is_orb_allowed or is_boss_allowed or is_animal_allowed or is_forge_allowed:
                amount = 1
            elif location_type == "Chest" and flag <= world.options.path_option:
                amount = world.options.hidden_chests.value
            elif location_type == "Pedestal" and flag <= world.options.path_option:
                amount = world.options.pedestal_checks.value

        region.add_locations(locations.make_location_range(location_name, location_data.id, amount),
                             locations.NoitaLocation)


# Creates a new Region with the locations found in `location_region_mapping` and adds them to the world.
def create_region(world: "NoitaWorld", region_name: str) -> Region:
    new_region = Region(region_name, world.player, world.multiworld)
    create_locations(world, new_region)
    return new_region


def create_regions(world: "NoitaWorld") -> Dict[str, Region]:
    append_mod_connections(noita_connections)
    noita_regions = sorted(set(noita_connections.keys()).union(*noita_connections.values()))
    return {name: create_region(world, name) for name in noita_regions}


# An "Entrance" is really just a connection between two regions
def create_entrance(player: int, source: str, destination: str, regions: Dict[str, Region]) -> Entrance:
    entrance = Entrance(player, f"From {source} To {destination}", regions[source])
    entrance.connect(regions[destination])
    return entrance


# Creates connections based on our access mapping in `noita_connections`.
def create_connections(player: int, regions: Dict[str, Region]) -> None:
    for source, destinations in noita_connections.items():
        new_entrances = [create_entrance(player, source, destination, regions) for destination in destinations]
        regions[source].exits = new_entrances


# Creates all regions and connections. Called from NoitaWorld.
def create_all_regions_and_connections(world: "NoitaWorld") -> None:
    created_regions = create_regions(world)
    create_connections(world.player, created_regions)
    create_all_events(world, created_regions)

    world.multiworld.regions += created_regions.values()

def append_mod_connections(connections) -> None:
    for region_name, region_data in apotheosis_connections.items():
        if region_name in connections:
            connections[region_name] += region_data
        else:
            connections[region_name] = region_data

# Oh, what a tangled web we weave
# Notes to create artificial spheres:
# - Shaft is excluded to disconnect Mines from the Snowy Depths
# - Lukki Lair is disconnected from The Vault
# - Overgrown Cavern is connected to the Underground Jungle instead of the Desert due to similar difficulty
# - Power Plant is disconnected from the Sandcave due to difficulty and sphere creation
# - Snowy Chasm is disconnected from the Snowy Wasteland
# - Pyramid is connected to the Hiisi Base instead of the Desert due to similar difficulty
# - Frozen Vault is connected to the Vault instead of the Snowy Wasteland due to similar difficulty
# - Lake is connected to The Laboratory, since the bosses are hard without specific set-ups (which means late game)
# - Snowy Depths connects to Lava Lake orb since you need digging for it, so fairly early is acceptable
# - Ancient Laboratory is connected to the Coal Pits, so that Ylialkemisti isn't sphere 1
noita_connections: Dict[str, List[str]] = {
    "Menu": ["Forest"],
    "Forest": ["Mines", "Floating Island", "Desert", "Snowy Wasteland"],
    "Frozen Vault": ["The Vault"],
    "Overgrown Cavern": ["Sandcave", "Desert Chasm"],

    ###
    "Mines": ["Collapsed Mines", "Coal Pits Holy Mountain", "Lava Lake"],
    "Lava Lake": ["Abyss Orb Room"],

    ###
    "Coal Pits Holy Mountain": ["Coal Pits"],
    "Coal Pits": ["Fungal Caverns", "Snowy Depths Holy Mountain", "Ancient Laboratory"],

    ###
    "Snowy Depths Holy Mountain": ["Snowy Depths"],
    "Snowy Depths": ["Hiisi Base Holy Mountain", "Magical Temple", "Below Lava Lake"],

    ###
    "Hiisi Base Holy Mountain": ["Hiisi Base"],
    "Hiisi Base": ["Secret Shop", "Pyramid", "Underground Jungle Holy Mountain"],

    ###
    "Underground Jungle Holy Mountain": ["Underground Jungle"],
    "Underground Jungle": ["Dragoncave", "Overgrown Cavern", "Vault Holy Mountain", "Lukki Lair", "Snowy Chasm", "West Meat Realm"],

    ###
    "Vault Holy Mountain": ["The Vault"],
    "The Vault": ["Frozen Vault", "Temple of the Art Holy Mountain"],

    ###
    "Temple of the Art Holy Mountain": ["Temple of the Art"],
    "Temple of the Art": ["Laboratory Holy Mountain", "The Tower", "Wizards' Den"],
    "Wizards' Den": ["Power Plant"],
    "Power Plant": ["Meat Realm"],

    ###
    "Laboratory Holy Mountain": ["The Laboratory"],
    "The Laboratory": ["The Work", "Friend Cave", "The Work (Hell)", "Lake", "The Sky", "Unsorted"],
    ###
}

apotheosis_connections: Dict[str, List[str]] = {
    "Hiisi Base": ["Ant Nest"],
    "Snowy Chasm": ["Sunken Cavern"],
    "Ant Nest": ["Core Mines"],
    "Power Plant": ["Virulent Caverns"],
    "Virulent Caverns": ["Sinkhole", "Temple of Sacrilegious Remains"],
}

noita_regions: List[str] = {}