/*
    Activates or deactivates booby traps based on player proximity.
    STALKER_boobyTraps entries: [position, anchor, objects, marker, active]
    Proximity checks use the stored position so anchors are not required
    after initial placement.
*/
// ["manageBoobyTraps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_boobyTraps") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_pos","_anchor","_objs","_marker",["_active",false]];
    // Rely on the stored position instead of the anchor object so traps remain
    // functional if the anchor is removed
    private _newActive = [_pos,_dist,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (!_active) then {
            // Spawn tripwire or fallback APERS mine vehicles
            private _tripMine = ["APERSMine", "APERSTripMine"] select (isClass ((configFile >> "CfgVehicles") >> "APERSTripMine"));
            private _type = selectRandom [_tripMine, "IEDUrbanSmall_F"];
            private _mine = createMine [_type, _pos, [], 0];
            _objs = [_mine];
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (_active && {(count _objs) > 0}) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_boobyTraps set [_forEachIndex, [_pos,_anchor,_objs,_marker,_newActive]];
} forEach STALKER_boobyTraps;

true
