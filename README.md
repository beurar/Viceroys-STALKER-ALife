# Viceroy's STALKER ALife

This project implements a dynamic **ALife** system inspired by the S.T.A.L.K.E.R. series. It is an **Arma 3** mod that creates a living Zone filled with dangers and events using common mod dependencies.

## Purpose

The goal of this mod is to add atmosphere and unpredictable encounters to missions. Mutants roam freely, anomalies manifest across the map, chemical gas pockets appear and disappear, and AI units respond to threats with panic or by seeking shelter from emissions. The system is modular so mission makers can enable only the elements they need.

## Major Systems

### AI Panic
* AI groups react to nearby emissions or scary events by fleeing to cover positions.
* Uses **fn_triggerAIPanic.sqf** and **fn_resetAIBehavior.sqf** to manage behavior states.
* Optional avoidance of nearby anomalies controlled by **VSA_aiAnomalyAvoidChance**.

### Anomalies
* Procedurally spawns anomaly fields using scripts in `functions/anomalies`.
* Supports common anomaly types like burners, electras, fruit punches and springboards.
* Relies on **Diwako’s Anomalies** for the core anomaly logic.
* Fields are distributed randomly across the entire map but avoid towns by 500 meters.
* Fields can be **Permanent** or **Temporary**. Permanent fields remain in place
  and only reshuffle their anomalies during an emission. Temporary fields are
  deleted after an emission and respawn at new random positions. The ratio of
  permanent fields is controlled by `VSA_permanentFieldChance`. Permanent fields
  also receive thematic names on their map markers. When no towns are nearby the
  names fall back to generic locations like the coast, a hill or a forest based
  on the surrounding terrain.
* Anomalies only activate when players are nearby and go dormant when no one is in range.

### Mutants
* Spawns roaming mutant packs and ambient herds.
* Example mutants include pseudodogs, snorks and other Zone creatures.
* Dedicated nest spawns for every mutant type keep their territories dangerous.
* Ambient herds keep one leader active while sleeping and only spawn the rest of
  the herd when players come within a configurable nearby range (default 1500
  meters). Their population slowly regenerates over time.
* Predator ambushes depend on the time of day. Daylight attacks can bring
  packs of dogs, herds of boars or even snorks. When night falls chimeras,
  bloodsuckers, cats or pseudodogs stalk their prey. Very rarely a lone goliath
  or crusher may strike.
* Predator attack checks use separate day and night intervals via
  `VSA_predatorCheckIntervalDay` and `VSA_predatorCheckIntervalNight`.

### Mutant Habitats
* Defines territory areas via **fn_setupMutantHabitats.sqf**.
* Each habitat now uses an ellipse marker to show its bounds and a labeled icon displaying the current population (e.g. `Bloodsucker Habitat: 4/12`).
* Systems rely on **fn_hasPlayersNearby.sqf** so habitats sleep and despawn when players are farther than the configured nearby range (default 1500m).
* Habitats now spawn empty and gain one mutant each habitat cycle when no players are nearby.
* Player proximity is checked every 5 seconds via `VSA_proximityCheckInterval`.
* Habitat updates run on their own timer via `VSA_habitatCheckInterval`.
* Habitat and herd counts update immediately when mutants are killed.
* Habitat placement now selects random buildings, forests and swamps with weighted preferences.
* Swamp detection scans neighbouring grid cells for shallow water so habitats reliably appear in marshy areas.
  Locations are offset slightly each mission so nests appear in different spots every time.
* Habitats will never overlap one another so each territory is distinct.
* CBA settings allow mission makers to customize these behaviors.

### Stalker Camps
* Roaming stalker groups wander the wilderness providing ambient life.
* Random camps appear in buildings or open terrain.
* Camps may belong to BLUFOR, OPFOR or Independent factions based on configurable chances.
* Group counts and sizes are fully adjustable through CBA settings.

### Chemical Zones
* Randomly creates chemical gas zones that damage unprotected units.
* Fields favour low terrain so gas tends to pool in valleys.
* Valley-based placement now spawns clusters of gas clouds at each low point.
* Zones sleep when no players are nearby and reactivate on approach.
* Cleanup functions remove old zones to keep performance reasonable.

### Minefields
* Generates APERS minefields on town outskirts and single IEDs on roads.
* Mines despawn when no players are nearby and respawn when someone approaches.
* Enable debug mode to visualize fields and place test minefields via the action menu. Ambush sites can also be spawned this way.
* Abandoned and damaged vehicles may appear on or near roads.
* Tripwires and booby traps can spawn inside buildings around towns.
* Fallen players leave a red X marker that vanishes once the body is removed.

### Spooks
* Lightweight supernatural events to unsettle players.

### Storms
* Periodic psy-storms that force players to seek shelter.
* During a storm lightning and Psy Discharges strike separately across the map. Their frequency ramps up over time.
* Fog, rain and overcast intensify as the storm builds, then fade once it passes.
* Duration, lightning and discharge intensity curves, and the delay between storms can all be configured via CBA settings.
* New settings `VSA_stormFogEnd`, `VSA_stormRainEnd`, `VSA_stormOvercast` and `VSA_stormOvercastTime` control weather effects and how quickly overcast builds up.
* Duration, lightning and discharge intensity curves, the radius around players for effects, and the delay between storms can all be configured via CBA settings.
* Works with the emission hook system for mission-specific consequences.
* Optional Nova Gas clouds spawn at every Psy Discharge by default.
  Controlled by `VSA_stormGasDischarges`, this creates a 20m zone that
  appears five seconds after each discharge, lasts 20 seconds, and
  uses a mist density of 3 with greater vertical spread.
  The radius, density and vertical spread can be tweaked via the
  `VSA_stormGasRadius`, `VSA_stormGasDensity` and `VSA_stormGasVertical`
  CBA settings.

### Blowouts
* Severe emission waves triggered via the included functions.
* AI and players caught outside of shelter are lethal casualties by default.
* Behaviour can be toggled through the `VSA_killAIEmission` CBA setting.

### Zombification
* Tracks dead units and may reanimate them as zombies after a delay.
* Integrates with **WebKnight’s Zombies & Demons** and **Necroplague** to handle the zombies themselves.
* Units that die while an emission is active will reanimate as zombies when the
  storm ends.
  
### Necroplague
* Random event that unleashes zombie hordes from hidden positions.
* Zombies spawn behind nearby buildings so players often hear them before they see them.
* Controlled via CBA settings for delay and horde size.
* Can be manually triggered from debug actions which also mark the spawn points.

## Anomaly Types
Each anomaly behaves differently and creates unique hazards:

* **Burner** – Columns of fire that ignite anything passing through.
* **Electra** – Violent bursts of electricity arcing between objects.
* **Fruit Punch** – Acidic eruptions that corrode armour and flesh.
* **Springboard** – Kinetic traps that launch the unlucky into the air.
* **Gravi** – Crushing gravitational wells that draw victims inward.
* **Meatgrinder** – Shredding vortex of debris and metal.
* **Whirligig** – Swirling force that pulls nearby objects to its centre.
* **Comet** – Mobile anomaly that follows a looping path.
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
* **Snork** – Feral mutants that charge at enemies with terrifying leaps.
* **Controller** – Psionic mutants capable of mind tricks.
* **Pseudogiant** – Towering brutes that shake the ground.
* **Izlom** – Twisted humanoids shuffling across the Zone.
* **Corruptor** – Parasitic creature that can seize control of a host body.
* **Goliath** – Massive mutant that hurls rocks and bone shards, devastating everything in its path.
* **Smasher** – Mini-boss monster that leaps and crushes obstacles with ease.
* **Acid Smasher** – Corrosive variant that spews acid while smashing through targets.
* **Parasite** – Small insectoid horrors that can cause instant death.
* **Jumper** – Mutated humans that pounce from afar.
* **Spitter** – Hulking mutants that spit acid at range.
* **Stalker** – Mutated canines that live in toxic clouds and swamps.
* **Bully** – Brawny humanoid mutants.
* **Hivemind** – Organic growths that mindcontrol and psionically attack stalkers.
* **Zombie** – Standard undead from WebKnight's mod.

## Spooks and Other Anomalies
Drongo’s system adds creepy events such as ghostly whispers or sudden darkening of the sky. These spook zones appear mostly at night and vanish after a short time, keeping players uneasy as they travel. When a zone spawns the mod now creates one of the DSA creature classes (currently only `DSA_Abomination`) at the location and cleans it up once the zone expires.

## Setup
1. Install the mod and load it in your Arma 3 launcher.
2. Ensure the following dependencies are also loaded:
   * [CBA A3](https://github.com/CBATeam/CBA_A3)
   * [Diwako’s Anomalies](https://github.com/diwako/Anomaly)
   * [WebKnight’s Zombies & Demons](https://steamcommunity.com/sharedfiles/filedetails/?id=2378964543)
   * [Drongo’s Spooks and Anomalies](https://steamcommunity.com/sharedfiles/filedetails/?id=2262255106)
   * [Stalker Stuff](https://steamcommunity.com/sharedfiles/filedetails/?id=2781344095)
   * [Chemical Warfare Plus](https://steamcommunity.com/sharedfiles/filedetails/?id=3295358796)
   * [Necroplague](https://steamcommunity.com/workshop/filedetails/?id=2616555444)
3. Review `cba_settings.sqf` for adjustable options such as the player nearby range used by many systems.
4. Enable **VSA_autoInit** if you want the world to populate automatically on mission start. When disabled, use the debug actions to spawn systems manually.
5. Enable **VSA_debugMode** to show on-screen debug messages and access testing actions.
   This option can now be toggled while a mission is running and the debug
   actions will appear automatically.
6. When debug mode is active, your scroll menu includes options to trigger storms, spawn permanent or temporary anomaly fields, cycle existing fields, spawn spook zones, generate habitats, spawn ambient herds, place booby traps in town buildings, summon predator attacks, trigger AI panic or reset their behaviour, and other test helpers. All spawn actions run on the server so they work correctly in multiplayer. Permanent fields will show a randomly generated name on their marker for easy reference.
7. Use the **Mark All Buildings** and **Mark Bridges** actions from this menu if you need to visualize these objects. Buildings are no longer marked automatically when debug mode is enabled.

## Usage

All functions are contained under the `functions` directory and follow the `TAG_fnc_functionName` convention. Key entry points include:

* **VIC_fnc_masterInit** – Initializes all subsystems.
* **VIC_fnc_registerEmissionHooks** – Adds mission-specific callbacks for storm events.
* **VIC_fnc_spawnAllAnomalyFields** – Spawns anomaly fields at random positions
  across the map, marks them and tracks their lifetime. Missions must call this
  function (or use the provided `initServer.sqf`) to populate the world.
* **VIC_fnc_cycleAnomalyFields** – Reshuffles permanent fields and relocates temporary ones. Useful for testing without a full emission.
* **VIC_fnc_generateFieldName** – Produces themed names for permanent anomaly field markers using local town names when possible.

Mission makers can tweak or remove individual systems as needed. Most features are script-only and do not require placing special modules in the editor, though some settings may be exposed through CBA.

## SQF Syntax

The SQF language is intentionally minimal and relies heavily on built-in
operators. An operator can be **nular** (no arguments), **unary** (one argument)
or **binary** (two arguments). Understanding how these operators consume their
arguments helps prevent subtle bugs.

### Terminating an Expression

Each statement must end with a semicolon (`;`) or a comma. Semicolons are the
common convention and make intent clear.

```sqf
_num = 10;
_num = _num + 20; systemChat str _num;
```

The above code contains three expressions separated by semicolons even though
two share the same line.

### Brackets

* `()` override the default order of precedence or simply aid readability.
* `[]` create arrays.
* `{}` enclose code blocks and are used in control structures.

### Whitespaces and Blank Lines

Leading or trailing spaces and tabs are ignored by the engine. Lines containing
only whitespace are skipped entirely.

### Comments

`//` starts a single-line comment while `/* */` encloses a block comment.
Comments are removed during preprocessing and must not appear inside strings.
Avoid using the legacy `comment` unary operator as it still executes without any
benefit.

### Operator Types

**Nular operators** recompute a value each time they are accessed:

```sqf
_unitsArray = allUnits;
systemChat str count _unitsArray;
group player createUnit ["B_RangeMaster_F", getPosATL player, [], 0, "NONE"];
systemChat str count _unitsArray;
systemChat str count allUnits;
```

This prints `5`, `5`, then `6` because `allUnits` generates a fresh array on
every call while `_unitsArray` stores a snapshot.

**Unary operators** consume the expression on their right. Parentheses are often
required when combining them with other operators:

```sqf
_arr = [[1,2,3,4,5],[1,2,3,4],[1,2]];
count (_arr select 2); // evaluates to 2
```

**Binary operators** take a left and right argument and follow their precedence
from left to right. Complex expressions benefit from parentheses for clarity:

```sqf
_arr = [[[[[1]]]]];
_arr select 0 select 1 - 1 select 15 / 3 - 5 select 0 select 10 * 10 + 4 * 0 - 100;
```

Adding brackets to the above expression reveals the actual order of evaluation.

### exitWith Usage

In SQF, exitWith must be followed by a single expression that returns a value.

A block enclosed in `{}` is valid only if it is treated as a single expression,
like an array, a function call, or a single value.

But writing `exitWith { statement1; statement2; }` is not valid if those
statements are not themselves returning a final value. In your case, you have:

## Dependencies

   * [CBA A3](https://github.com/CBATeam/CBA_A3)
   * [Diwako’s Anomalies](https://github.com/diwako/Anomaly)
   * [WebKnight’s Zombies & Demons](https://steamcommunity.com/sharedfiles/filedetails/?id=2378964543)
   * [Drongo’s Spooks and Anomalies](https://steamcommunity.com/sharedfiles/filedetails/?id=2262255106)
   * [Stalker Stuff](https://steamcommunity.com/sharedfiles/filedetails/?id=2781344095)
   * [Chemical Warfare Plus](https://steamcommunity.com/sharedfiles/filedetails/?id=3295358796)
   * [Necroplague](https://steamcommunity.com/workshop/filedetails/?id=2616555444)

These mods must be loaded for the scripts in this repository to function correctly.

## Antistasi Integration

When Antistasi Ultimate is detected, several helper functions can create side missions:

* **VIC_fnc_startMutantHunt** – awards money for each mutant killed during the hunt period.
* **VIC_fnc_startArtefactHunt** – places an artefact in an existing anomaly field and tasks players to retrieve it.
* **VIC_fnc_startChemSample** – chooses a chemical zone and requires players to stay inside for 90 seconds to collect samples.

These helpers do nothing if Antistasi Ultimate is not loaded.

## Branding

The repository ships with `logo.paa` as the main logo and `Icon.paa` for smaller
launcher displays. These images are referenced in `mod.cpp` so that Arma 3
shows the mod's branding in the launcher and in-game menus.

## Remote Execution

Engine commands like `createMarker` and `setMarkerType` cannot be executed via
`remoteExecCall` directly. They must run inside a script that you remote execute.
Functions such as `VIC_fnc_createGlobalMarker` handle this by calling a local
helper on each machine.

## License

This project is licensed under the **Arma Public License Share Alike (APL-SA)**.
See [LICENSE.md](LICENSE.md) for details.
