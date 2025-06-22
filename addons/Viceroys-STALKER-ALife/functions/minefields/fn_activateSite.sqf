/*
    Activates the minefield at the given registry index.
*/

["minefields_activateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_minefields") exitWith {};
if (_index < 0 || {_index >= count STALKER_minefields}) exitWith {};

private _entry = STALKER_minefields select _index;
_entry params ["_center","_type","_size","_objs","_marker",["_active",false]];

if (_objs isEqualTo []) then {
    _objs = switch (_type) do {
        case "APERS": { [_center,_size] call VIC_fnc_spawnAPERSField };
        case "IED":   { [_center] call VIC_fnc_spawnIED };
        default { [] };
    };
};
_active = true;
if (_marker != "") then { _marker setMarkerAlpha 1; };
STALKER_minefields set [_index, [_center,_type,_size,_objs,_marker,_active]];

true
