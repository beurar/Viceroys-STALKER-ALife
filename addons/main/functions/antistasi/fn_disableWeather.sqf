/*
    Disables the Antistasi persistent weather script when the mod is loaded.

    Returns:
        BOOL - true if any weather scripts were disabled
*/

if !(call VIC_fnc_isAntistasiUltimate) exitWith {false};
if (!isServer) exitWith {false};

["Disabling Antistasi persistent weather"] call VIC_fnc_debugLog;

private _changed = false;

// Disable Antistasi persistent weather script if present
if (!isNil "AU_persistentWeather") then {
    missionNamespace setVariable ["AU_persistentWeather", nil];
    _changed = true;
};

_changed
