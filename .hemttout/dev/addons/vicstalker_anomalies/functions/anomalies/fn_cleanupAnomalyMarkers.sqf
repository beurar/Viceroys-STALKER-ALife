/*
    Removes map markers created for anomaly fields.
    Iterates over the global STALKER_anomalyMarkers array, deletes each
    marker and then clears the array.

    Returns: BOOL
        True when the cleanup completes.
*/

["cleanupAnomalyMarkers"] call VIC_fnc_debugLog;

if (isNil "STALKER_anomalyMarkers") exitWith { false };

for [{_i = (count STALKER_anomalyMarkers) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _marker = STALKER_anomalyMarkers select _i;
    if (_marker != "") then { deleteMarker _marker; };
};

STALKER_anomalyMarkers = [];

true
