/*
    Spawns roaming stalker groups that patrol random areas of the map.
    Settings via CBA:
      - VSA_enableAmbientStalkers: enable spawning
      - VSA_ambientStalkerGroups:  number of groups
      - VSA_ambientStalkerSize:    units per group
      - VSA_ambientStalkerNightOnly: spawn only at night
*/

["spawnAmbientStalkers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableAmbientStalkers", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_stalkerGroups") then { STALKER_stalkerGroups = []; };

private _groupCount = ["VSA_ambientStalkerGroups", 2] call VIC_fnc_getSetting;
private _groupSize  = ["VSA_ambientStalkerSize", 4] call VIC_fnc_getSetting;
private _nightOnly  = ["VSA_ambientStalkerNightOnly", false] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _groupCount do {
    private _pos = [random worldSize, random worldSize, 0];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (_pos isEqualTo []) then { continue };
    private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
    if (!([_pos, _dist] call VIC_fnc_hasPlayersNearby)) then { continue };

    private _grp = createGroup independent;
    for "_j" from 1 to _groupSize do {
        _grp createUnit ["I_Soldier_F", _pos, [], 0, "FORM"];
    };
    [_grp, _pos] call BIS_fnc_taskPatrol;

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        private _name = format ["stk_%1_%2", count STALKER_stalkerGroups, diag_tickTime];
        _marker = createMarker [_name, _pos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorGreen";
        _marker setMarkerAlpha 0.2;
    };

    STALKER_stalkerGroups pushBack [_grp, _marker];
};
