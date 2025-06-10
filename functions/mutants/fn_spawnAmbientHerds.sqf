/*
    Spawns passive mutant herds roaming the world.
    Settings via CBA:
      - VSA_ambientHerdCount:   number of herds to spawn (default 2)
      - VSA_ambientHerdSize:    units per herd (default 4)
      - VSA_ambientNightOnly:   spawn only at night if true (default false)
      - VSA_enableMutants:      master toggle for mutant systems
*/

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

private _herdCount = ["VSA_ambientHerdCount", 2] call CBA_fnc_getSetting;
private _herdSize  = ["VSA_ambientHerdSize", 4]  call CBA_fnc_getSetting;
private _nightOnly = ["VSA_ambientNightOnly", false] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _herdCount do {
    private _pos = [random worldSize, random worldSize, 0];
    private _grp = createGroup civilian;
    for "_j" from 1 to _herdSize do {
        private _unit = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
        _unit disableAI "TARGET";
        _unit disableAI "AUTOTARGET";
    };
    [_grp, _pos] call BIS_fnc_taskPatrol;
};
