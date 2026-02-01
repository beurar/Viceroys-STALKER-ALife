/*
    STALKER ALife – postInit
*/


// --- PostInit event handlers migrated from fn_masterInit.sqf ---
["postInit", {
    missionNamespace setVariable ["STALKER_activityRadius", ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting];
    [] call VIC_fnc_registerEmissionHooks;
    if (call VIC_fnc_isAntistasiUltimate && { ["VSA_disableA3UWeather", false] call VIC_fnc_getSetting }) then {
        [] call VIC_fnc_disableA3UWeather;
    };
    if (isServer && {isNil "VIC_activityThread"}) then {
        VIC_activityThread = [] spawn {
            sleep 8;
            while {true} do {
                [] call VIC_fnc_updateProximity;
                sleep 6;
            };
        };
    };
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] remoteExec ["VIC_fnc_markPlayerRanges", 0];
    };
}] call CBA_fnc_addEventHandler;

["masterInit completed"] call VIC_fnc_debugLog;

// Track units killed during emissions for later zombification
["EntityKilled", {
    params ["_unit"];
    [_unit] call VIC_fnc_trackDeadForZombify;
    [_unit] call VIC_fnc_markDeathLocation;
}] call CBA_fnc_addEventHandler;

["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (_setting isEqualTo "VSA_debugMode") then {
        if (hasInterface) then {
            if (_value) then {
                [] call VIC_fnc_setupDebugActions;
                [] call VIC_fnc_markPlayerRanges;
            } else {
                if (!isNil "STALKER_playerRangeMarker" && {STALKER_playerRangeMarker != ""}) then {
                    deleteMarkerLocal STALKER_playerRangeMarker;
                };
                STALKER_playerRangeMarker = "";
                missionNamespace setVariable ["VSA_rangeMarkersActive", false];
            };
        };
    };
}] call CBA_fnc_addEventHandler;
