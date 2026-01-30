/*
    Spawns roaming mutant herds that sleep when players are far away.
    Only a single leader unit is created initially and used as an anchor
    for the herd while the rest of the members are tracked virtually.
    Settings via CBA:
      - VSA_ambientHerdCount:   number of herds to spawn (default 2)
      - VSA_ambientHerdSize:    maximum units per herd (default 4)
      - VSA_ambientNightOnly:   spawn only at night if true (default false)
      - VSA_enableMutants:      master toggle for mutant systems
*/

["spawnAmbientHerds"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_activeHerds") then { STALKER_activeHerds = []; };

private _herdCount = ["VSA_ambientHerdCount", 2] call VIC_fnc_getSetting;
private _herdSize  = ["VSA_ambientHerdSize", 4]  call VIC_fnc_getSetting;
private _nightOnly = ["VSA_ambientNightOnly", false] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {};

for "_i" from 1 to _herdCount do {
    private _pos = [random worldSize, random worldSize, 0];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (isNil {_pos} || {_pos isEqualTo []}) then { continue };
    private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
    if (!([_pos, _dist] call VIC_fnc_hasPlayersNearby)) then { continue };
    private _grp = createGroup civilian;
    private _leader = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
    [_leader] call VIC_fnc_initMutantUnit;
    _leader disableAI "TARGET";
    _leader disableAI "AUTOTARGET";
    _leader setVariable ["VSA_herdIndex", count STALKER_activeHerds];
    _leader addEventHandler ["Killed", { [_this#0] call VIC_fnc_onMutantKilled }];
    [_grp, _pos] call BIS_fnc_taskPatrol;
    private _markerName = format ["herd_%1_%2", count STALKER_activeHerds, diag_tickTime];
    private _marker = _markerName;
    [_marker, _pos, "ICON", "mil_dot", VIC_colorMutant, 0.2, "Ambient Herd"] call VIC_fnc_createGlobalMarker;

    STALKER_activeHerds pushBack [_leader, _grp, _herdSize, _herdSize, false, _marker];
};
