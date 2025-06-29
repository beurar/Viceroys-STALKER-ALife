/*
    Finds a building suitable for a stalker camp near any player.
    Params:
        0: NUMBER - minimum distance from player (default 700)
        1: NUMBER - maximum distance from player (default 1500)
        2: NUMBER - minimum building positions (default setting or 1)
    Returns:
        OBJECT - building or objNull if none found
*/
params [
    ["_min",700],
    ["_max",1500],
    ["_minPos",-1]
];

if (_minPos < 0) then {
    _minPos = ["VSA_minCampPositions", 1] call VIC_fnc_getSetting;
};

["findCampBuilding"] call VIC_fnc_debugLog;

private _players = allPlayers select { alive _x && {!isNull _x} };
if (_players isEqualTo []) exitWith { objNull };

private _candidates = [];
{
    private _pPos = getPosATL _x;
    private _blds = nearestObjects [_pPos, ["House"], _max];
    {
        private _dist = _x distance2D _pPos;
        private _posCount = count (_x buildingPos -1);
        if (
            _dist > _min &&
            { _dist <= _max } &&
            { _posCount >= _minPos }
        ) then {
            _candidates pushBack _x;
        };
    } forEach _blds;
} forEach _players;

if (_candidates isEqualTo []) exitWith { objNull };
selectRandom _candidates
