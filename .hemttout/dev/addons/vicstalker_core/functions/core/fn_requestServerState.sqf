/*
    Client-side: request current server state and apply it locally.
    Sends lightweight counts to allow the server to return only changed sections.
*/
private _cooldown = 5; // minimum seconds between requests
private _last = missionNamespace getVariable ["VIC_lastStateReq", 0];
if (diag_tickTime - _last < _cooldown) exitWith { false };
missionNamespace setVariable ["VIC_lastStateReq", diag_tickTime];

private _var = format ["VIC_stateReq_%1_%2", clientOwner, diag_tickTime];
missionNamespace setVariable [_var, nil];

// prepare client counts for quick diffing on server
private _clientCounts = [];
_clientCounts pushBack (if (isNil "STALKER_anomalyFields") then { -1 } else { count STALKER_anomalyFields });
_clientCounts pushBack (if (isNil "STALKER_activeHerds") then { -1 } else { count STALKER_activeHerds });
_clientCounts pushBack (if (isNil "STALKER_minefields") then { -1 } else { count STALKER_minefields });
_clientCounts pushBack (if (isNil "STALKER_boobyTraps") then { -1 } else { count STALKER_boobyTraps });
_clientCounts pushBack (if (isNil "STALKER_iedSites") then { -1 } else { count STALKER_iedSites });
_clientCounts pushBack (if (isNil "STALKER_mutantNests") then { -1 } else { count STALKER_mutantNests });
_clientCounts pushBack (if (isNil "STALKER_camps") then { -1 } else { count STALKER_camps });
_clientCounts pushBack (if (isNil "STALKER_wreckPositions") then { -1 } else { count STALKER_wreckPositions });

[_var, clientOwner, _clientCounts] remoteExec ["VIC_fnc_sendServerState", 2];

waitUntil { !isNil { missionNamespace getVariable _var } };
private _state = missionNamespace getVariable _var;
missionNamespace setVariable [_var, nil];

[ _state ] call VIC_fnc_applyServerState;

true
