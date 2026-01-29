/*
    Spawns bridge anomaly fields on every detected bridge.
    Params:
        0: NUMBER - forces stable (1) or unstable (0) fields (optional, -1 uses setting)
*/
params [["_type", -1]];
["spawnBridgeAnomalyFields"] call VIC_fnc_debugLog;

// Gather known bridges
private _bridges = missionNamespace getVariable ["VIC_cachedBridges", []];
if (_bridges isEqualTo []) then {
    _bridges = [] call VIC_fnc_findBridges;
    missionNamespace setVariable ["VIC_cachedBridges", _bridges];
};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = [] };
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };

private _stableChance = ["VSA_stableFieldChance", 50] call VIC_fnc_getSetting;

{
    private _pos = getPosATL _x;
    // Skip if a field already exists for this bridge
    private _exists = (STALKER_anomalyFields select {
        (_x select 3) isEqualTo VIC_fnc_createField_bridgeAnomaly && { (_x select 7) distance2D _pos < 10 }
    }) isNotEqualTo [];
    if (_exists) then { continue };

    private _stable = if (_type == -1) then { (random 100) < _stableChance } else { _type == 1 };
    private _spawned = [_pos, 75, -1, _pos] call VIC_fnc_createField_bridgeAnomaly;
    if (_spawned isEqualTo []) then { continue };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;
    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    private _site   = if (_marker isEqualTo "") then { getPosATL (_spawned select 0) } else { getMarkerPos _marker };
    if (_marker != "") then {
        _marker setMarkerBrushLocal "Border";
        _marker setMarkerAlpha 1;
        if (_stable) then { _marker setMarkerText (["bridge", _site] call VIC_fnc_generateFieldName); };
    };
    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    private _exp = diag_tickTime + (_dur * 60);
    STALKER_anomalyFields pushBack [_pos,_anchor,75,VIC_fnc_createField_bridgeAnomaly,count _spawned,_spawned,_marker,_site,_exp,_stable,false];
    [format ["spawnBridgeAnomalyFields: spawned %1 bridge", count _spawned]] call VIC_fnc_debugLog;
} forEach _bridges;

true
