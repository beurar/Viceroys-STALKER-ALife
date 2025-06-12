/*
    Creates circle markers around all players showing the range used
    for nearby checks. Only runs on clients when debug mode is enabled.

    Returns: BOOL
*/

["markPlayerRanges"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };
if (missionNamespace getVariable ["VSA_rangeMarkersActive", false]) exitWith { true };
missionNamespace setVariable ["VSA_rangeMarkersActive", true];

if (isNil "STALKER_playerRangeMarkers") then { STALKER_playerRangeMarkers = [] };

[] spawn {
    while (["VSA_debugMode", false] call VIC_fnc_getSetting) do {
        private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
        private _players = allPlayers;

        {
            private _idx = _forEachIndex;
            private _m = if (_idx < count STALKER_playerRangeMarkers) then {
                STALKER_playerRangeMarkers select _idx
            } else {
                private _name = format ["playerRange_%1_%2", _idx, diag_tickTime];
                private _marker = createMarkerLocal [_name, getPosATL _x];
                _marker setMarkerShape "ELLIPSE";
                _marker setMarkerColor "ColorBlue";
                STALKER_playerRangeMarkers pushBack _marker;
                _marker
            };
            _m setMarkerPosLocal getPosATL _x;
            _m setMarkerSizeLocal [_range, _range];
        } forEach _players;

        for [{_i = count STALKER_playerRangeMarkers - 1}, {_i >= count _players}, {_i = _i - 1}] do {
            deleteMarkerLocal (STALKER_playerRangeMarkers deleteAt _i);
        };

        sleep 1;
    };
    { deleteMarkerLocal _x } forEach STALKER_playerRangeMarkers;
    STALKER_playerRangeMarkers = [];
    missionNamespace setVariable ["VSA_rangeMarkersActive", false];
};

true
