/*
    Activates or deactivates minefields based on player proximity.
    STALKER_minefields entries: [center, anchor, type, size, objects, marker, active]
    The stored position is used for proximity checks so the anchor object is
    optional and only kept for debugging purposes.
*/
// ["manageMinefields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_minefields") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_center","_anchor","_type","_size","_objs","_marker",["_active",false]];
    // Use the stored position rather than the anchor object so proximity works
    // even if the logic was deleted
    private _newActive = [_center,_dist,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (!_active) then {
            _objs = switch (_type) do {
                case "APERS": { [_center,_size] call VIC_fnc_spawnAPERSField };
                case "IED":   { [_center] call VIC_fnc_spawnIED };
                default { [] };
            };
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (_active && {(count _objs) > 0}) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_minefields set [_forEachIndex, [_center,_anchor,_type,_size,_objs,_marker,_newActive]];
} forEach STALKER_minefields;

true

