/*
    Activates the chemical zone at the given registry index.
*/

["chemical_activateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_chemicalZones") exitWith {};
if (_index < 0 || {_index >= count STALKER_chemicalZones}) exitWith {};

private _entry = STALKER_chemicalZones select _index;
_entry params ["_pos","_radius","_active","_marker","_expires"];

if (!_active) then {
    private _dur = if (_expires < 0) then {-1} else {_expires - diag_tickTime};
    [_pos,_radius,_dur] call VIC_fnc_spawnChemicalZone;
    _active = true;
};
if (_marker != "") then { _marker setMarkerAlpha 1; };

STALKER_chemicalZones set [_index, [_pos,_radius,_active,_marker,_expires]];

true
