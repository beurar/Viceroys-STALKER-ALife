# Viceroy's STALKER ALife

This project implements a dynamic **ALife** system inspired by the S.T.A.L.K.E.R. series. It is an **Arma 3** mod that creates a living Zone filled with dangers and events using common mod dependencies.

## Purpose

The goal of this mod is to add atmosphere and unpredictable encounters to missions. Mutants roam freely, anomalies manifest across the map, radiation pockets appear and disappear, and AI units respond to threats with panic or by seeking shelter from emissions. The system is modular so mission makers can enable only the elements they need.

## Major Systems

### Emission Hooks
* Centralized hooks that allow missions to react to emission or psy-storm events.
* Mission makers can register custom functions that run before, during and after storms.

### AI Panic
* AI groups react to nearby emissions or scary events by fleeing to cover positions.
* Uses **fn_triggerAIPanic.sqf** and **fn_resetAIBehavior.sqf** to manage behavior states.

### Anomalies
* Procedurally spawns anomaly fields using scripts in `functions/anomalies`.
* Supports common anomaly types like burners, electras, fruit punches and springboards.
* Relies on **Diwako’s Anomalies** for the core anomaly logic.
* Map markers are removed when their anomaly field despawns after `STALKER_AnomalyFieldDuration` minutes.

### Mutants
* Spawns roaming mutant packs and ambient herds.
* Example mutants include pseudodogs, snorks and other Zone creatures.
* Dedicated nest spawns for every mutant type keep their territories dangerous.

### Mutant Habitats
* Defines simple territory markers via **fn_setupMutantHabitats.sqf**.
* Systems rely on **fn_hasPlayersNearby.sqf** so activity sleeps when players are far away.
* CBA settings allow mission makers to customize these behaviors.

### Radiation
* Randomly creates radiation zones that damage unprotected units.
* Cleanup functions remove old zones to keep performance reasonable.

### Spooks
* Lightweight supernatural events to unsettle players.
* Random zones may spawn spooky audio or visual effects.

### Storms
* Periodic psy-storms that force players to seek shelter.
* Works with the emission hook system for mission-specific consequences.

### Zombification
* Tracks dead units and may reanimate them as zombies after a delay.
* Integrates with **WebKnight’s Zombies & Demons** to handle the zombies themselves.

## Anomaly Types
Each anomaly behaves differently and creates unique hazards:

* **Burner** – Columns of fire that ignite anything passing through.
* **Electra** – Violent bursts of electricity arcing between objects.
* **Fruit Punch** – Acidic eruptions that corrode armour and flesh.
* **Springboard** – Kinetic traps that launch the unlucky into the air.
* **Gravi** – Crushing gravitational wells that draw victims inward.
* **Meatgrinder** – Shredding vortex of debris and metal.
* **Whirligig** – Swirling force that pulls nearby objects to its centre.
* **Clicker** – Emits clicking sounds before discharging lethal energy.
* **Launchpad** – Hurls victims a random distance away.
* **Leech** – Drains stamina and may sap health.
* **Trapdoor** – Teleports the unwary up to a kilometre.
* **Zapper** – Strikes intruders with bolts of lightning.

## Mutant Creatures and Nests
Every mutant type can establish a nest which spawns defenders when players are near:

* **Bloodsucker** – Stealthy predators that lurk in ruined structures.
* **Boar** – Aggressive packs of tusked beasts.
* **Cat** – Fast moving felines that stalk lone travellers.
* **Flesh** – Slow but hardy pig-like creatures.
* **Blind Dog** – Pack hunters that overwhelm with numbers.
* **Pseudodog** – Mutated canines with psychic screeches.
* **Controller** – Psionic mutants capable of mind tricks.
* **Pseudogiant** – Towering brutes that shake the ground.
* **Izlom** – Twisted humanoids shuffling across the Zone.
* **Corruptor** – Parasitic creature that can seize control of a host body.
* **Goliath** – Massive mutant that hurls rocks and bone shards, devastating everything in its path.
* **Smasher** – Mini-boss monster that leaps and crushes obstacles with ease.
* **Acid Smasher** – Corrosive variant that spews acid while smashing through targets.

## Spooks and Other Anomalies
Drongo’s system adds creepy events such as ghostly whispers or sudden darkening of the sky. These spook zones appear mostly at night and vanish after a short time, keeping players uneasy as they travel.

Common spook types include:
* **Wendigo** – Deer-like humanoid that leaps at nearby prey.
* **Shadowman** – Jet-black figure able to teleport and strike with psychic blasts.
* **Vampires** – Fast, tough monsters that dive into melee with powerful leaps.
* **Mindflayer** – Slow but dangerous psy-creature capable of mind control.
* **411** – Near-invisible hunter that kills those who turn their backs.
* **Rake** – Pale crouched mutant attacking with vicious claws.
* **Abomination** – Shrouded in darkness, stabbing victims from range.
* **Snatcher** – Semi-visible shapeshifter that teleports targets far away.
* **Cursed Idol** – Animated idol requiring heavy weapons to destroy.

## Setup

1. Install the mod and load it in your Arma 3 launcher.
2. Ensure the following dependencies are also loaded:
   * [CBA A3](https://github.com/CBATeam/CBA_A3)
   * [Diwako’s Anomalies](https://github.com/diwako/Anomaly)
   * [WebKnight’s Zombies & Demons](https://steamcommunity.com/sharedfiles/filedetails/?id=2378964543)
   * [Drongo’s Spooks and Anomalies](https://steamcommunity.com/sharedfiles/filedetails/?id=2262255106)
   * [Healthy Stalker Mutants](https://steamcommunity.com/sharedfiles/filedetails/?id=3105717594)
   * [Healthy Stalker Items](https://steamcommunity.com/sharedfiles/filedetails/?id=3105592413)
   * [Chemical Warfare Plus](https://steamcommunity.com/sharedfiles/filedetails/?id=3295358796)
3. Review `cba_settings.sqf` for adjustable options.
4. Enable **VSA_debugMode** to show on-screen debug messages and access testing actions.
   This option can now be toggled while a mission is running and the debug
   actions will appear automatically.
5. When debug mode is active, your scroll menu includes options to trigger storms, spawn anomaly fields or spook zones, generate habitats, spawn ambient herds and other test helpers.

## Usage

All functions are contained under the `functions` directory and follow the `TAG_fnc_functionName` convention. Key entry points include:

* **VIC_fnc_masterInit** – Initializes all subsystems.
* **VIC_fnc_registerEmissionHooks** – Adds mission-specific callbacks for storm events.
* **VIC_fnc_spawnAllAnomalyFields** – Places anomaly fields across the map.

Mission makers can tweak or remove individual systems as needed. Most features are script-only and do not require placing special modules in the editor, though some settings may be exposed through CBA.

## Dependencies

   * [CBA A3](https://github.com/CBATeam/CBA_A3)
   * [Diwako’s Anomalies](https://github.com/diwako/Anomaly)
   * [WebKnight’s Zombies & Demons](https://steamcommunity.com/sharedfiles/filedetails/?id=2378964543)
   * [Drongo’s Spooks and Anomalies](https://steamcommunity.com/sharedfiles/filedetails/?id=2262255106)
   * [Healthy Stalker Mutants](https://steamcommunity.com/sharedfiles/filedetails/?id=3105717594)
   * [Healthy Stalker Items](https://steamcommunity.com/sharedfiles/filedetails/?id=3105592413)
   * [Chemical Warfare Plus](https://steamcommunity.com/sharedfiles/filedetails/?id=3295358796)

These mods must be loaded for the scripts in this repository to function correctly.

## Branding

The repository ships with `logo.paa` as the main logo and `Icon.paa` for smaller
launcher displays. These images are referenced in `mod.cpp` so that Arma 3
shows the mod's branding in the launcher and in-game menus.

## License

This project is licensed under the **Arma Public License Share Alike (APL-SA)**.
See [LICENSE.md](LICENSE.md) for details.
