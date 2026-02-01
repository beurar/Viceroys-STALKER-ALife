/*
    Server-side: package current runtime state and send back to requesting client.
    Uses client's counts to only send changed sections.
    Params:
        0: STRING - variable name client expects
        1: NUMBER - client id (remote exec owner)
        2: ARRAY  - client counts for sections (see requestServerState)
*/
params ["_var", "_client", "_clientCounts"];

if (!isServer) exitWith {};

// Build a serializable, simplified payload for clients
private _payload = [];

// Build server counts for comparison
private _serverCounts = [];
_serverCounts pushBack (if (isNil "STALKER_anomalyFields") then { 0 } else { count STALKER_anomalyFields });
_serverCounts pushBack (if (isNil "STALKER_activeHerds") then { 0 } else { count STALKER_activeHerds });
_serverCounts pushBack (if (isNil "STALKER_minefields") then { 0 } else { count STALKER_minefields });
_serverCounts pushBack (if (isNil "STALKER_boobyTraps") then { 0 } else { count STALKER_boobyTraps });
_serverCounts pushBack (if (isNil "STALKER_iedSites") then { 0 } else { count STALKER_iedSites });
_serverCounts pushBack (if (isNil "STALKER_mutantNests") then { 0 } else { count STALKER_mutantNests });
_serverCounts pushBack (if (isNil "STALKER_camps") then { 0 } else { count STALKER_camps });
_serverCounts pushBack (if (isNil "STALKER_wreckPositions") then { 0 } else { count STALKER_wreckPositions });

// Anomalies: convert each entry to [pos, siteName, radius, count, marker, stable, active]
private _anom = [];
private _sendAnom = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 0) == (_serverCounts select 0)) then { _sendAnom = false } };
if (_sendAnom) then {
    if (!(isNil "STALKER_anomalyFields")) then {
        {
            private _f = _x;
            private _pos = _f select 0;
            private _radius = _f select 2;
            private _count = _f select 4;
            private _marker = _f select 6;
            private _site = _f select 7;
            private _stable = _f select 9;
            private _active = if ((count _f) > 10) then { _f select 10 } else { false };
            _anom pushBack [_pos, _site, _radius, _count, _marker, _stable, _active];
        } forEach STALKER_anomalyFields;
    };
};
_payload pushBack (if (_sendAnom) then { _anom } else { nil });

// Active herds: send [pos, herdSize, marker]
private _herds = [];
private _sendHerds = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 1) == (_serverCounts select 1)) then { _sendHerds = false } };
if (_sendHerds) then {
    if (!(isNil "STALKER_activeHerds")) then {
        {
            private _h = _x;
            private _leader = _h select 0;
            private _herdSize = _h select 2;
            private _marker = _h select 5;
            private _pos = [getPos _leader, []] select (isNil {_leader});
            _herds pushBack [_pos, _herdSize, _marker];
        } forEach STALKER_activeHerds;
    };
};
_payload pushBack (if (_sendHerds) then { _herds } else { nil });

// Minefields: [pos, type, size, marker, active]
private _mfields = [];
private _sendMine = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 2) == (_serverCounts select 2)) then { _sendMine = false } };
if (_sendMine) then {
    if (!(isNil "STALKER_minefields")) then {
        {
            private _m = _x;
            private _pos = _m select 0;
            private _type = _m select 2;
            private _size = _m select 3;
            private _marker = _m select 5;
            private _active = _m select 6;
            _mfields pushBack [_pos, _type, _size, _marker, _active];
        } forEach STALKER_minefields;
    };
};
_payload pushBack (if (_sendMine) then { _mfields } else { nil });

// Booby traps: [pos, marker, active]
private _traps = [];
private _sendTraps = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 3) == (_serverCounts select 3)) then { _sendTraps = false } };
if (_sendTraps) then {
    if (!(isNil "STALKER_boobyTraps")) then {
        {
            private _t = _x;
            private _pos = _t select 0;
            private _marker = _t select 3;
            private _active = _t select 4;
            _traps pushBack [_pos, _marker, _active];
        } forEach STALKER_boobyTraps;
    };
};
_payload pushBack (if (_sendTraps) then { _traps } else { nil });

// IED sites: [pos, marker, active]
private _ieds = [];
private _sendIeds = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 4) == (_serverCounts select 4)) then { _sendIeds = false } };
if (_sendIeds) then {
    if (!(isNil "STALKER_iedSites")) then {
        {
            private _s = _x;
            private _pos = _s select 0;
            private _marker = _s select 2;
            private _active = _s select 3;
            _ieds pushBack [_pos, _marker, _active];
        } forEach STALKER_iedSites;
    };
};
_payload pushBack (if (_sendIeds) then { _ieds } else { nil });

// Mutant nests: [pos, class, groupSize]
private _nests = [];
private _sendNests = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 5) == (_serverCounts select 5)) then { _sendNests = false } };
if (_sendNests) then {
    if (!(isNil "STALKER_mutantNests")) then {
        {
            private _n = _x;
            private _pos = _n select 2;
            private _class = _n select 3;
            private _grp = _n select 1;
            private _gcount = [count units _grp, 0] select (isNil {_grp});
            _nests pushBack [_pos, _class, _gcount];
        } forEach STALKER_mutantNests;
    };
};
_payload pushBack (if (_sendNests) then { _nests } else { nil });

// Camps: [pos, side, faction, marker, active]
private _camps = [];
private _sendCamps = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 6) == (_serverCounts select 6)) then { _sendCamps = false } };
if (_sendCamps) then {
    if (!(isNil "STALKER_camps")) then {
        {
            private _c = _x;
            private _pos = _c select 2;
            private _side = _c select 5;
            private _faction = _c select 6;
            private _marker = _c select 4;
            private _active = _c select 7;
            _camps pushBack [_pos, _side, _faction, _marker, _active];
        } forEach STALKER_camps;
    };
};
_payload pushBack (if (_sendCamps) then { _camps } else { nil });

// Wreck positions
private _sendWrecks = true;
if (!isNil "_clientCounts") then { if ((_clientCounts select 7) == (_serverCounts select 7)) then { _sendWrecks = false } };
_payload pushBack (if (_sendWrecks) then { (if (isNil "STALKER_wreckPositions") then { [] } else { STALKER_wreckPositions }) } else { nil });

// include serverCounts for client to update its idea of counts
_payload pushBack _serverCounts;

// Send packaged state back to the requesting client using remoteReturn helper
[_var, _payload] remoteExecCall ["VIC_fnc_remoteReturn", _client];

true
