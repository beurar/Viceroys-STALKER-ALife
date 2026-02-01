/*
    Draws a circle marker around the local player showing the range used
    for nearby checks.

    Returns: BOOL
*/

["markPlayerRanges"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };
if (missionNamespace getVariable ["VSA_rangeMarkersActive", false]) exitWith { true };
missionNamespace setVariable ["VSA_rangeMarkersActive", true];

if (isNil "STALKER_playerRangeMarker") then { STALKER_playerRangeMarker = "" };

[] spawn {
    while { missionNamespace getVariable ["VSA_debugMode", true] } do {
        private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];
        if (STALKER_playerRangeMarker isEqualTo "") then {
            private _name = format ["playerRange_%1", diag_tickTime];
            STALKER_playerRangeMarker = createMarkerLocal [_name, position player];
            STALKER_playerRangeMarker setMarkerShapeLocal "ELLIPSE";
            STALKER_playerRangeMarker setMarkerColor "ColorBlue";
            STALKER_playerRangeMarker setMarkerAlphaLocal 0.15;
        };
        STALKER_playerRangeMarker setMarkerPosLocal position player;
        STALKER_playerRangeMarker setMarkerSizeLocal [_range, _range];
        sleep 1;
    };
    if (STALKER_playerRangeMarker != "") then { deleteMarkerLocal STALKER_playerRangeMarker; };
    STALKER_playerRangeMarker = "";
    missionNamespace setVariable ["VSA_rangeMarkersActive", false];
};

true
