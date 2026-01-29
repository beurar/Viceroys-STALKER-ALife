/*
    Trigger a single blowout using Diwako's Anomalies.
    Params: None. All emission settings are handled by
    Diwako's Anomalies and should not be modified here.
*/
params [];

["triggerBlowout"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["triggerBlowout exit: not server"] call VIC_fnc_debugLog;
};

// Start blowout using Diwako's server event with default parameters
["diwako_anomalies_main_startBlowout", []] call CBA_fnc_serverEvent;

["triggerBlowout completed"] call VIC_fnc_debugLog;
