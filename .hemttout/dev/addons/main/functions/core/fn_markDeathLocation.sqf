/*
    Creates a red X marker at the location where a player dies.
    The marker is removed automatically once the corpse is deleted.
*/


params ["_unit", ["_global", false]];

["markDeathLocation"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _pos = getPosATL _unit;
private _name = format ["death_%1", diag_tickTime];

private _marker = [_name, _pos, "ICON", "mil_destroy", VIC_colorMeatRed, 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;

if (isNil "STALKER_deathMarkers") then { STALKER_deathMarkers = [] };
STALKER_deathMarkers pushBack [_unit, _marker];

[_unit, _marker] spawn {
    params ["_corpse", "_markerName"];
    waitUntil { isNull _corpse };
    if (_markerName != "") then { deleteMarker _markerName; };
    if (!isNil "STALKER_deathMarkers") then {
        STALKER_deathMarkers = STALKER_deathMarkers select { (_x select 1) != _markerName };
    };
};

true
