/*
    Deactivates the chemical zone at the given registry index.
*/

["chemical_deactivateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_chemicalZones") exitWith {};
if (_index < 0 || {_index >= count STALKER_chemicalZones}) exitWith {};

private _entry = STALKER_chemicalZones select _index;
_entry params ["_pos","_radius","_active","_marker","_expires"];

if (_active) then { _active = false; };
if (_marker != "") then { _marker setMarkerAlpha 0.2; };

STALKER_chemicalZones set [_index, [_pos,_radius,_active,_marker,_expires]];

true
