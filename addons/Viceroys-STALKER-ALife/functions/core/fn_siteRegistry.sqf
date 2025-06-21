/*
    Maintains a registry of ALife sites keyed by activity grid cell.
    Provides helpers for registering a site and routing activation
    or deactivation events to subsystem handlers.
*/

if (isNil "STALKER_siteRegistry") then { STALKER_siteRegistry = []; };

VIC_fnc_sitePlaced = {
    params ["_key", "_type", "_index"];
    if (isNil "STALKER_siteRegistry") then { STALKER_siteRegistry = []; };
    private _idx = STALKER_siteRegistry findIf { (_x select 0) isEqualTo _key };
    if (_idx < 0) then {
        STALKER_siteRegistry pushBack [_key, [[_type, _index]]];
    } else {
        private _sites = STALKER_siteRegistry select _idx select 1;
        _sites pushBack [_type, _index];
        STALKER_siteRegistry set [_idx, [_key, _sites]];
    };
};

VIC_fnc_activateSite = {
    params ["_type", "_index"];
    switch (_type) do {
        case "anomaly":  { [_index] call anomalies_fnc_activateSite; };
        case "minefield": { [_index] call minefields_fnc_activateSite; };
        case "chemical": { [_index] call chemical_fnc_activateSite; };
        default {};
    };
};

VIC_fnc_deactivateSite = {
    params ["_type", "_index"];
    switch (_type) do {
        case "anomaly":  { [_index] call anomalies_fnc_deactivateSite; };
        case "minefield": { [_index] call minefields_fnc_deactivateSite; };
        case "chemical": { [_index] call chemical_fnc_deactivateSite; };
        default {};
    };
};
