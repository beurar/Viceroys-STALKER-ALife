/*
    Updates the grid-based activity map around players and draws debug markers.
    Uses simple arrays for compatibility with sqflint.

    Returns: BOOL
*/

["updateActivityGrid"] call VIC_fnc_debugLog;

if (!isServer) exitWith {false};

if (isNil "STALKER_activityGrid") then { STALKER_activityGrid = [] };
if (isNil "STALKER_activityMarkers") then { STALKER_activityMarkers = [] };

private _size = missionNamespace getVariable ["STALKER_activityGridSize", 500];
private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
private _diag  = sqrt 2 * (_size / 2);
private _half  = _size / 2;

private _cells = [];

{
    if (!alive _x) then { continue };
    private _pos = getPos _x;
    private _gx = floor ((_pos select 0) / _size);
    private _gy = floor ((_pos select 1) / _size);
    private _depth = ["VSA_activityZoneDepth", 4] call VIC_fnc_getSetting;
    private _rad = _depth max ceil((_range + _diag) / _size);
    for "_ix" from (_gx - _rad) to (_gx + _rad) do {
        for "_iy" from (_gy - _rad) to (_gy + _rad) do {
            private _cx = _ix * _size + _half;
            private _cy = _iy * _size + _half;
            if (_pos distance2D [_cx,_cy,0] <= (_range + _diag)) then {
                private _key = format ["%1_%2", _ix, _iy];
                if (_cells find _key < 0) then { _cells pushBack _key; };
            };
        };
    };
} forEach allPlayers;

// Update grid states
for "_i" from 0 to ((count STALKER_activityGrid) - 1) do {
    private _entry = STALKER_activityGrid select _i;
    private _key = _entry select 0;
    private _isActive = (_cells find _key) > -1;
    STALKER_activityGrid set [_i, [_key, _isActive]];
};

// Add new active cells
{
    private _key = _x;
    private _exists = false;
    for "_i" from 0 to ((count STALKER_activityGrid) - 1) do {
        if ((STALKER_activityGrid select _i) select 0 == _key) exitWith { _exists = true; };
    };
    if (!_exists) then { STALKER_activityGrid pushBack [_key, true]; };
} forEach _cells;

private _debug = ["VSA_debugMode", false] call VIC_fnc_getSetting;

if (_debug) then {
    {
        _x params ["_key","_active"];
        private _idx = -1;
        for "_j" from 0 to ((count STALKER_activityMarkers) - 1) do {
            if ((STALKER_activityMarkers select _j) select 0 == _key) exitWith { _idx = _j; };
        };
        private _marker = "";
        if (_idx >= 0) then {
            _marker = STALKER_activityMarkers select _idx select 1;
        } else {
            private _parts = _key splitString "_";
            private _mx = (parseNumber (_parts select 0)) * _size + _half;
            private _my = (parseNumber (_parts select 1)) * _size + _half;
            private _name = format ["grid_%1", _key];
            _marker = [_name, [_mx, _my, 0], "RECTANGLE", "", "ColorRed", 1, "", [_size, _size], true] call VIC_fnc_createGlobalMarker;
            _marker setMarkerBrush "SolidFull";
            STALKER_activityMarkers pushBack [_key, _marker];
        };
        _marker setMarkerColor (if (_active) then {"ColorYellow"} else {"ColorRed"});
        _marker setMarkerAlpha 0.2;
    } forEach STALKER_activityGrid;
} else {
    {
        private _marker = _x select 1;
        if (_marker != "") then { deleteMarker _marker; };
    } forEach STALKER_activityMarkers;
    STALKER_activityMarkers = [];
};

true
