/*
    Finds and returns the FIRST valid land position that meets the
    supplied constraints.

    Params
    ──────────────────────────────────────────────────────────────
      0: ARRAY centrePos        – centre of search area (ASL or ATL)
      1: NUMBER searchRadius    – metres (default 1000)
      2: NUMBER minWaterDist    – metres from shoreline/water (30)
      3: NUMBER maxSlopeDeg     – maximum ground slope in degrees (30)
      4: ARRAY  blacklistPos    – array of positions to avoid (default [])
      5: NUMBER clearanceRad    – empty space radius for BIS_fnc_isPosEmpty (5)
      6: NUMBER maxAttempts     – failsafe loop guard (200)

    Returns
    ──────────────────────────────────────────────────────────────
      ARRAY positionATL         – the first good position
      []                        – if none found within attempt budget
*/
params [
    ["_centrePos",   [0,0,0],   [[]]  ],
    ["_radius",         1000,   [0]   ],
    ["_minWaterDist",     30,   [0]   ],
    ["_maxSlope",         30,   [0]   ],
    ["_blacklist",        [],   [[]]  ],
    ["_clearanceRad",      5,   [0]   ],
    ["_maxAttempts",     200,   [0]   ]
];

private _degToSlope = {
    /* converts a surfaceNormal vector into slope-angle in degrees   */
    90 - acos (_this vectorDotProduct [0,0,1])
};

scopeName "findLand";
private _result = [];
for "_i" from 1 to _maxAttempts do {

    /* ─ generate a random candidate in the search circle ───────── */
    private _p = [[[ _centrePos, _radius ]], ["water"]] call BIS_fnc_randomPos;
    if ((_p isEqualTo [0,0]) || { _p isEqualTo [0,0,0] }) then { continue };
    private _surf = [_p] call VIC_fnc_getSurfacePosition;

    /* ─ REJECT #1: below sea level implies water ──────────────── */
    if ((ASLToAGL _surf select 2) <= 0) then { continue };

    /* ─ REJECT #2: coastline / lake edge too close? ────────────── */
    private _nearWater = false;
    for "_a" from 0 to 315 step 45 do {
        private _edgeSurf = [_p getPos [_minWaterDist, _a]] call VIC_fnc_getSurfacePosition;
        if ((ASLToAGL _edgeSurf select 2) <= 0) exitWith { _nearWater = true };
    };
    if (_nearWater) then { continue };

    /* ─ REJECT #3: slope too steep? ────────────────────────────── */
    if ([surfaceNormal ASLToATL _surf] call _degToSlope > _maxSlope) then { continue };

    /* ─ REJECT #4: inside map clutter or other objects? ───────── */
    if !([ ASLToATL _surf, _clearanceRad, [], 0, "CAN_COLLIDE" ] call BIS_fnc_isPosEmpty) then { continue };

    /* ─ REJECT #5: user black-list check (25 m radius) ────────── */
    private _nearBlk = {
        _surf distance2D _x < 25
    } count _blacklist > 0;
    if (_nearBlk) then { continue };

    _result = ASLToATL _surf;
    breakOut "findLand";
};

_result
