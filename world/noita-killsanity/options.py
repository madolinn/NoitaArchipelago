from Options import Choice, DeathLink, DefaultOnToggle, Toggle, Range, StartInventoryPool, PerGameCommonOptions
from dataclasses import dataclass


class PathOption(Choice):
    """
    Choose where you would like Hidden Chest and Pedestal checks to be placed.
    Main Path includes the main 7 biomes you typically go through to get to the final boss.
    Side Path includes the Lukki Lair and Fungal Caverns. 9 biomes total.
    Main World includes the full world (excluding parallel worlds). 15 biomes total.
    Note: The Collapsed Mines have been combined into the Mines as the biome is tiny.
    """
    display_name = "Path Option"
    option_main_path = 1
    option_side_path = 2
    option_main_world = 3
    default = 1


class HiddenChests(Range):
    """
    Number of hidden chest checks added to the applicable biomes.
    Note: The number of hidden chests that spawn per run in each biome varies.
    You are expected do multiple runs to get all of your checks.
    """
    display_name = "Hidden Chests per Biome"
    range_start = 0
    range_end = 20
    default = 3


class PedestalChecks(Range):
    """
    Number of checks that will spawn on pedestals in the applicable biomes.
    Note: The number of pedestals that spawn per run in each biome varies.
    You are expected do multiple runs to get all of your checks.
    """
    display_name = "Pedestal Checks per Biome"
    range_start = 0
    range_end = 20
    default = 6


class Traps(DefaultOnToggle):
    """
    Whether negative effects on the Noita world are added to the item pool.
    """
    display_name = "Traps"


class OrbsAsChecks(Choice):
    """
    Decides whether finding the orbs that naturally spawn in the world count as checks.
    The Main Path option includes only the Floating Island and Abyss Orb Room orbs.
    The Side Path option includes the Main Path, Magical Temple, Lukki Lair, and Lava Lake orbs.
    The Main World option includes all 11 orbs.
    """
    display_name = "Orbs as Location Checks"
    option_no_orbs = 0
    option_main_path = 1
    option_side_path = 2
    option_main_world = 3
    default = 0


class BossesAsChecks(Choice):
    """
    Makes bosses count as location checks. The boss only needs to die, you do not need the kill credit.
    The Main Path option includes Gate Guardian, Suomuhauki, and Kolmisilmä.
    The Side Path option includes the Main Path bosses, Sauvojen Tuntija, and Ylialkemisti.
    The All Bosses option includes all 15 bosses.
    """
    display_name = "Bosses as Location Checks"
    option_no_bosses = 0
    option_main_path = 1
    option_side_path = 2
    option_all_bosses = 3
    default = 0


# Note: Most damageable entities are referred to internally as "Animals", including things such as the player character, Bosses, Crystals, Sheep, etc.
# This option currently avoids bosses, except for the 2 common parallel bosses
class AnimalsAsChecks(Choice):
    """
    Makes all enemies count as location checks, apart from 1 time bosses.
    The Main Path option includes only the enemies appearing in the main biomes.
    The Side Path option includes the Main Path enemies, as well as the directly adjacent biomes.
    The Reasonable option includes everything that is accessible with some exploration.
    The Pain option includes everything that is accessible in the game, that isn't pure RNG.
    """
    display_name = "Enemies as Location Checks"
    option_no_enemies = 0
    option_main_path = 1
    option_side_path = 2
    option_reasonable = 3
    option_pain = 4
    default = 0


# Until we find a way to discern who killed what properly, get rid of this :(
#class AnimalChecksNeedCredit(Toggle):
#    """
#    When combined with Enemies as Location Checks, this option requires the player to personally dispatch the enemy to acquire credit.
#    Trick Kills and whackier wands may prevent credits from being awarded, as is a totally intended vanilla mechanic.
#    """
#    display_name = "Enemies require Kill Credit"
class ForgesAsChecks(Choice):
    """
    Makes forgeable items to count as location checks, apart from 1 time bosses. There is an option to toggle whether you need the kill credit yourself.
    The Items Only option only includes a single Broken Wand, and the Broken Portal Spell.
    The Side Path option includes Items, as well as Emerald Tablets from the Magical Temple, Lukki Lair, and past the Lava Lake.
    THe Main World option includes Items, as well as all Forgeable Emerald Tablets. 
    """
    display_name = "Forgeables as Location Checks"
    option_no_forges = 0
    option_items_only = 1
    option_side_path = 2
    option_main_world = 3
    default = 0


# Note: the Sampo is an item that is picked up to trigger the boss fight at the normal ending location.
# The sampo is required for every ending (having orbs and bringing the sampo to a different spot changes the ending).
class VictoryCondition(Choice):
    """
    Greed is to get to the bottom, beat the boss, and win the game.
    Pure is to get 11 orbs, grab the sampo, and bring it to the mountain altar.
    Peaceful is to get all 33 orbs, grab the sampo, and bring it to the mountain altar.
    Orbs will be added to the randomizer pool based on which victory condition you chose.
    The base game orbs will not count towards these victory conditions.
    """
    display_name = "Victory Condition"
    option_greed_ending = 0
    option_pure_ending = 1
    option_peaceful_ending = 2
    default = 0


class ExtraOrbs(Range):
    """
    Add extra orbs to your item pool, to prevent you from needing to wait as long for the last orb you need for your victory condition.
    Extra orbs received past your victory condition's amount will be received as hearts instead.
    Can be turned on for the Greed Ending goal, but will only really make it harder.
    """
    display_name = "Extra Orbs"
    range_start = 0
    range_end = 10
    default = 0


class ShopPrice(Choice):
    """
    Reduce the costs of Archipelago items in shops.
    By default, the price of Archipelago items matches the price of wands at that shop.
    """
    display_name = "Shop Price Reduction"
    option_full_price = 100
    option_25_percent_off = 75
    option_50_percent_off = 50
    option_75_percent_off = 25
    default = 100


class NoitaDeathLink(DeathLink):
    """
    When you die, everyone dies. Of course, the reverse is true too.
    You can disable this in the in-game mod options.
    """


@dataclass
class NoitaOptions(PerGameCommonOptions):
    start_inventory_from_pool: StartInventoryPool
    death_link: NoitaDeathLink
    bad_effects: Traps
    victory_condition: VictoryCondition
    path_option: PathOption
    hidden_chests: HiddenChests
    pedestal_checks: PedestalChecks
    orbs_as_checks: OrbsAsChecks
    bosses_as_checks: BossesAsChecks
    animals_as_checks: AnimalsAsChecks
    forges_as_checks: ForgesAsChecks
    extra_orbs: ExtraOrbs
    shop_price: ShopPrice