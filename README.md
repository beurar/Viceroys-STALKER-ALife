# Viceroy's STALKER ALife

This project implements a dynamic **ALife** system inspired by the S.T.A.L.K.E.R. series. It is designed to provide a living Zone filled with dangers and events. The scripts are structured to run inside Arma 3 using common mod dependencies.

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

### Mutants
* Spawns roaming mutant packs and ambient herds.
* Example mutants include pseudodogs, snorks and other Zone creatures.

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
   * [KJW's Radiate](https://steamcommunity.com/sharedfiles/filedetails/?id=2917867026)
3. Place `initServer.sqf` in your mission or call `VCAL_fnc_masterInit` from your own init script.
4. Review `cba_settings.sqf` for adjustable options.

## Usage

All functions are contained under the `functions` directory and follow the `TAG_fnc_functionName` convention. Key entry points include:

* **VCAL_fnc_masterInit** – Initializes all subsystems.
* **VCAL_fnc_registerEmissionHooks** – Adds mission-specific callbacks for storm events.
* **VCAL_fnc_spawnAllAnomalyFields** – Places anomaly fields across the map.

Mission makers can tweak or remove individual systems as needed. Most features are script-only and do not require placing special modules in the editor, though some settings may be exposed through CBA.

## Dependencies

* CBA A3
* Diwako’s Anomalies
* WebKnight’s Zombies & Demons

These mods must be loaded for the scripts in this repository to function correctly.

## License

See [LICENSE.md](LICENSE.md) for license information.
