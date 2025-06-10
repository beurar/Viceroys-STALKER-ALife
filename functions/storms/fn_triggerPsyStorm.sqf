/*
    Author: Codex
    Description:
        Applies screen effects and optional hallucinations, damages exposed units
        and can spawn spooks or zombies.

    Params:
        0: NUMBER - duration of the storm in seconds (default 60)
        1: NUMBER - damage applied to exposed units per tick (default 0.03)
        2: BOOL   - enable hallucination effects (default true)
        3: BOOL   - spawn spook zone when finished (default false)
        4: BOOL   - spawn zombies when finished (default false)
*/

params [
    ["_duration", 60],
    ["_damage", 0.03],
    ["_hallucinations", true],
    ["_spawnSpooks", false],
    ["_spawnZombies", false]
];

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
    [] call AL_fnc_spawnSpookZone;
};

if (_spawnZombies) then {
    [] call AL_fnc_spawnZombiesFromQueue;
};
