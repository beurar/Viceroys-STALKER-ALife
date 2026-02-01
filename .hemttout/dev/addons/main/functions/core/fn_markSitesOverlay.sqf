/*
    Places local debug markers for all known sites with text describing type and active state.
    Params: none
*/
if (!hasInterface) exitWith { false };

// Clear previous debug markers
private _existing = missionNamespace getVariable ["VIC_debug_siteMarkers", []];
{
    if (_x != "") then { deleteMarkerLocal _x }; 
} forEach _existing;
missionNamespace setVariable ["VIC_debug_siteMarkers", []];

private _markers = [];

// Helper to add marker for a site
private _addMarker = {
    params ["_pos", "_text", "_col"];
    private _name = format ["VIC_debug_site_%1", floor (diag_tickTime * 1000) + random 1000];
    private _m = [_name, _pos, "ICON", "mil_dot", _col, 0.8, _text, [1.5,1.5]] call VIC_fnc_createLocalMarker;
    _markers pushBack _name;
};

// Anomaly fields
if (!isNil "STALKER_anomalyFields") then {
    {
        private _f = _x;
        private _pos = _f select 0;
        private _siteName = _f select 1;
        private _radius = _f select 2;
        private _count = _f select 3;
        private _marker = _f select 4;
        private _stable = _f select 5;
        private _active = _f select 6;
        private _txt = format ["Anomaly: %1\nRadius:%2\nCount:%3\nStable:%4\nActive:%5", _siteName, _radius, _count, _stable, _active];
        [_pos, _txt, "ColorWhite"] call _addMarker;
    } forEach STALKER_anomalyFields;
};

// Minefields
if (!isNil "STALKER_minefields") then {
    {
        private _m = _x;
        private _pos = _m select 0;
        private _type = _m select 1;
        private _size = _m select 2;
        private _marker = _m select 3;
        private _active = _m select 4;
        private _txt = format ["Minefield: %1\nSize:%2\nActive:%3", _type, _size, _active];
        [_pos, _txt, "ColorRed"] call _addMarker;
    } forEach STALKER_minefields;
};

// IED sites
if (!isNil "STALKER_iedSites") then {
    {
        private _s = _x;
        private _pos = _s select 0;
        private _marker = _s select 1;
        private _active = _s select 2;
        private _txt = format ["IED Site\nActive:%1", _active];
        [_pos, _txt, "ColorYellow"] call _addMarker;
    } forEach STALKER_iedSites;
};

// Booby traps
if (!isNil "STALKER_boobyTraps") then {
    {
        private _b = _x;
        private _pos = _b select 0;
        private _marker = _b select 1;
        private _active = _b select 2;
        [_pos, format ["Booby Trap\nActive:%1", _active], "ColorWhite"] call _addMarker;
    } forEach STALKER_boobyTraps;
};

// Mutant nests
if (!isNil "STALKER_mutantNests") then {
    {
        private _n = _x;
        private _pos = _n select 0;
        private _class = _n select 1;
        private _gcount = _n select 2;
        [_pos, format ["Nest: %1\nSize:%2", _class, _gcount], "ColorWhite"] call _addMarker;
    } forEach STALKER_mutantNests;
};

missionNamespace setVariable ["VIC_debug_siteMarkers", _markers];

true
