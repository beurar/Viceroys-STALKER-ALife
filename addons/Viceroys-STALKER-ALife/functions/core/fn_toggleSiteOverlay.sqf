/*
    Toggle client-side overlay showing all known sites.
*/
if (!hasInterface) exitWith { false };

private _active = missionNamespace getVariable ["VIC_debug_sitesActive", false];
if (_active) then {
    // turn off
    private _existing = missionNamespace getVariable ["VIC_debug_siteMarkers", []];
    {
        if (_x != "") then { deleteMarkerLocal _x };
    } forEach _existing;
    missionNamespace setVariable ["VIC_debug_siteMarkers", []];
    missionNamespace setVariable ["VIC_debug_sitesActive", false];
    hintSilent "Site overlay disabled";
} else {
    // turn on
    [] call VIC_fnc_markSitesOverlay;
    missionNamespace setVariable ["VIC_debug_sitesActive", true];
    hintSilent "Site overlay enabled";
};

true
