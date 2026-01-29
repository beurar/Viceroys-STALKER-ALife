/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
call compile preprocessFileLineNumbers "..\cba_settings.sqf";

["masterInit"] call VIC_fnc_debugLog;

// --- Custom marker colours -------------------------------------------------
VIC_colorMutant      = "#(0.545,0.27,0.074,1)";   // Brown
VIC_colorClearSky    = "#(0.529,0.808,0.922,1)";   // Sky blue
VIC_colorDuty        = "#(0.502,0,0,1)";           // Maroon
VIC_colorFreedom     = "#(0.565,0.933,0.565,1)";   // Light green
VIC_colorEcologists  = "#(0.941,0.902,0.549,1)";   // Khaki
VIC_colorBandits     = "#(0,0,0,1)";               // Black
VIC_colorLoners      = "#(0.722,0.525,0.043,1)";   // Dark yellow
VIC_colorMercs       = "#(0,0,0.545,1)";           // Dark blue
VIC_colorWard        = "#(0.961,0.961,0.863,1)";   // Beige
VIC_colorIPSF        = "#(0.804,0.498,0.196,1)";   // Bronze
VIC_colorMilitary    = "#(0,0.392,0,1)";           // Dark green
VIC_colorMonolith    = "#(0.294,0,0.510,1)";       // Dark purple
VIC_colorCopper      = "#(0.72,0.45,0.20,1)";      // Copper
VIC_colorSilver      = "#(0.75,0.75,0.75,1)";      // Silver
VIC_colorFruitGreen  = "#(0,1,0,1)";               // Bright green
VIC_colorGasYellow   = "#(0.8,0.8,0,1)";           // Sickly yellow
VIC_colorPyroOrange  = "#(1,0.647,0,1)";           // Orange
VIC_colorTeleport    = "#(0.5,0,0.5,1)";           // Purple
VIC_colorElectroBlue = "#(0,0,1,1)";               // Blue
VIC_colorMeatRed     = "#(1,0,0,1)";               // Red
VIC_colorSpringYellow = "#(1,1,0,1)";              // Yellow
VIC_colorLeechGrey   = "#(0.4,0.4,0.4,1)";         // Dark grey
VIC_colorClickerMagenta = "#(1,0,1,1)";            // Magenta
VIC_colorTrapdoorTurq = "#(0.251,0.878,0.816,1)";  // Turquoise
VIC_colorZapperCyan  = "#(0,1,1,1)";               // Cyan
VIC_colorBridgeCyan  = "#(0,0.6,0.6,1)";           // Dark cyan

// All functions should be registered via CfgFunctions in config.cpp.
// Functions are automatically available through the config.cpp registration system.
// No manual compilation needed here.

// --- PostInit ---------------------------------------------------------------
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
        // Additional managers have been disabled for quicker startup and can be
        // invoked via debug actions when needed.
    };
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] remoteExec ["VIC_fnc_markPlayerRanges", 0];
    };
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    ["masterInit completed"] call VIC_fnc_debugLog;
    // Track units killed during emissions for later zombification
    ["EntityKilled", {
        params ["_unit"];
        [_unit] call VIC_fnc_trackDeadForZombify;
        [_unit] call VIC_fnc_markDeathLocation;
    }] call CBA_fnc_addEventHandler;
} else {
    // Client-side initialization
};

// Allow toggling debug mode mid-mission
["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (_setting isEqualTo "VSA_debugMode") then {
        if (hasInterface) then {
            if (_value) then {
                [] call VIC_fnc_setupDebugActions;
                [] call VIC_fnc_markPlayerRanges;
            } else {
                if (!isNil "STALKER_playerRangeMarker" &&
                    {STALKER_playerRangeMarker != ""}) then {
                    deleteMarkerLocal STALKER_playerRangeMarker;
                };
                STALKER_playerRangeMarker = "";
                missionNamespace setVariable ["VSA_rangeMarkersActive", false];
            };
        };
    };
}] call CBA_fnc_addEventHandler;
