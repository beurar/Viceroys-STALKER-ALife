/*
    Finds a building suitable for a stalker camp near any player.
    Params:
        0: NUMBER - minimum distance from player (default 700)
        1: NUMBER - maximum distance from player (default 1500)
    Returns:
        OBJECT - building or objNull if none found
*/
params [["_min",700],["_max",1500]];

["findCampBuilding"] call VIC_fnc_debugLog;

private _players = allPlayers select { alive _x && {!isNull _x} };
if (_players isEqualTo []) exitWith { objNull };

private _candidates = [];
{
    private _pPos = getPosATL _x;
    private _blds = nearestObjects [_pPos, ["House"], _max];
    {
        private _dist = _x distance2D _pPos;
        if (_dist > _min && { _dist <= _max }) then {
            _candidates pushBack _x;
        };
    } forEach _blds;
} forEach _players;

if (_candidates isEqualTo []) exitWith { objNull };
selectRandom _candidates
