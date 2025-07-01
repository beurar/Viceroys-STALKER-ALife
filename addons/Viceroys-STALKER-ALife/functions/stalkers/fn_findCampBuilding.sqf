/*
    Finds a building suitable for a stalker camp.
    Camps are distributed across the map but only activate when
    players come within range. Camp selection ignores player
    distance and draws from cached building clusters.
    Params:
        0: NUMBER - minimum building positions (default setting or 1)
    Returns:
        OBJECT - building or objNull if none found
*/
params [["_minPos",-1]];

if (_minPos < 0) then {
    _minPos = ["VSA_minCampPositions", 1] call VIC_fnc_getSetting;
};

["findCampBuilding"] call VIC_fnc_debugLog;

if (isNil "STALKER_campCooldowns") then { STALKER_campCooldowns = [] };
STALKER_campCooldowns = STALKER_campCooldowns select { diag_tickTime - (_x select 1) < 300 };

private _clusters = missionNamespace getVariable ["STALKER_buildingClusters", []];
if (_clusters isEqualTo []) exitWith { objNull };

private _candidates = [];
{
    {
        private _building = nearestObject [_x, "House"];
        if (!isNull _building && {count (_building buildingPos -1) >= _minPos}) then {
            private _onCooldown = false;
            {
                _x params ["_p","_t"];
                if (_p distance _building < 5 && {diag_tickTime - _t < 300}) exitWith { _onCooldown = true };
            } forEach STALKER_campCooldowns;
            if (!_onCooldown) then { _candidates pushBack _building; };
        };
    } forEach _x;
} forEach _clusters;

if (_candidates isEqualTo []) exitWith { objNull };
selectRandom _candidates
