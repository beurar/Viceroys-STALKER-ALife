/*
    Deactivates the minefield at the given registry index.
*/

["minefields_deactivateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_minefields") exitWith {};
if (_index < 0 || {_index >= count STALKER_minefields}) exitWith {};

private _entry = STALKER_minefields select _index;
_entry params ["_center","_type","_size","_objs","_marker"];

if ((count _objs) > 0) then {
    { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
    _objs = [];
};
if (_marker != "") then { _marker setMarkerAlpha 0.2; };

STALKER_minefields set [_index, [_center,_type,_size,_objs,_marker]];

true
