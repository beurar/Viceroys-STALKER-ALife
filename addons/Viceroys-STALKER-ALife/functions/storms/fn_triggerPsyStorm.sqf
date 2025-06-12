/*
    Author: Codex
    Description:
        Applies screen effects and optional hallucinations, damages exposed units
        and can spawn spooks or zombies.

    Params:
        0: NUMBER - duration of the storm in seconds (default 60)
        1: NUMBER - strikes spawned each second (default 3)
        2: NUMBER - damage applied to exposed units per tick (default 0.03)
        3: BOOL   - enable hallucination effects (default true)
        4: BOOL   - spawn spook zone when finished (default false)
        5: BOOL   - spawn zombies when finished (default false)
*/

params [
    ["_duration", 60],
    ["_intensity", 3],
    ["_damage", 0.03],
    ["_hallucinations", true],
    ["_spawnSpooks", false],
    ["_spawnZombies", false]
];

["triggerPsyStorm"] call VIC_fnc_debugLog;

private _effect = ppEffectCreate ["ColorCorrections", 1500];
_effect ppEffectEnable true;
_effect ppEffectAdjust [0.2, 1, 0, [1,0.2,1,0.2], [0,0,0,1], [1,1,1,0]];
_effect ppEffectCommit 0;

private _ticks = floor _duration;
for "_i" from 1 to _ticks do {
    {
        if (alive _x) then {
            private _from = eyePos _x;
            private _to = _from vectorAdd [0,0,50];
            if (lineIntersectsSurfaces [_from, _to, _x, objNull, true] isEqualTo []) then {
                _x setDamage ((damage _x) + _damage);
            };
        };
    } forEach allUnits;

    for "_j" from 1 to _intensity do {
        private _pos = [random worldSize, random worldSize, 0];
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        private _module = "diwako_anomalies_main_modulePsyDischarge" createVehicle _surf;
        ["init", _module] call diwako_anomalies_main_fnc_modulePsyDischarge;
        [_surf] call BIS_fnc_moduleLightning;
    };

    if (_hallucinations && {random 1 < 0.15}) then {
        private _sounds = [
            "a3\sounds_f\characters\human-sfx\personality\tired-breathing-02.wss",
            "a3\sounds_f\sfx\alarm_independent.wss"
        ];
        playSound3D [selectRandom _sounds, player];
    };

    sleep 1;
};

_effect ppEffectEnable false;
ppEffectDestroy _effect;

if (_spawnSpooks) then {
    [] call VIC_fnc_spawnSpookZone;
};

if (_spawnZombies) then {
    [] call VIC_fnc_spawnZombiesFromQueue;
};
