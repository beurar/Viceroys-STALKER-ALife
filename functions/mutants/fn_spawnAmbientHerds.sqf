/*
    Spawns passive mutant herds roaming the world.
    Settings via CBA:
      - ALF_ambientHerdCount: number of herds to spawn (default 2)
      - ALF_ambientHerdSize:  units per herd (default 4)
      - ALF_ambientNightOnly: spawn only at night if true (default false)
*/

if (!isServer) exitWith {};

private _herdCount = ["ALF_ambientHerdCount", 2] call CBA_fnc_getSetting;
private _herdSize  = ["ALF_ambientHerdSize", 4]  call CBA_fnc_getSetting;
private _nightOnly = ["ALF_ambientNightOnly", false] call CBA_fnc_getSetting;

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
