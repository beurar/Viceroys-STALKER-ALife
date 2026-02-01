/*
    Client-side: apply server-packed state locally.
    Params:
        0: ARRAY - state array produced by `fn_sendServerState`
*/
params ["_state"];

if (isNil "_state") exitWith { false };

// Payload format (indexes):
// 0: anomalies, 1: herds, 2: minefields, 3: booby traps,
// 4: ied sites, 5: mutant nests, 6: camps, 7: wreck positions, 8: serverCounts
if (count _state > 0) then {
    private _v = _state select 0;
    if !(_v isEqualTo nil) then { STALKER_anomalyFields = _v };
};
if (count _state > 1) then {
    private _v = _state select 1;
    if !(_v isEqualTo nil) then { STALKER_activeHerds = _v };
};
if (count _state > 2) then {
    private _v = _state select 2;
    if !(_v isEqualTo nil) then { STALKER_minefields = _v };
};
if (count _state > 3) then {
    private _v = _state select 3;
    if !(_v isEqualTo nil) then { STALKER_boobyTraps = _v };
};
if (count _state > 4) then {
    private _v = _state select 4;
    if !(_v isEqualTo nil) then { STALKER_iedSites = _v };
};
if (count _state > 5) then {
    private _v = _state select 5;
    if !(_v isEqualTo nil) then { STALKER_mutantNests = _v };
};
if (count _state > 6) then {
    private _v = _state select 6;
    if !(_v isEqualTo nil) then { STALKER_camps = _v };
};
if (count _state > 7) then {
    private _v = _state select 7;
    if !(_v isEqualTo nil) then { STALKER_wreckPositions = _v };
};

// update client-side cached counts if provided
if (count _state > 8) then {
    private _sc = _state select 8;
    if !(_sc isEqualTo nil) then { missionNamespace setVariable ["VIC_serverCounts", _sc] };
};

// Place cached markers and other helpful debug visuals locally
if (!isNil "VIC_fnc_placeCachedMarkers") then {
    [] call VIC_fnc_placeCachedMarkers;
};

true
