/*
    Registers a minefield into spatial chunks
    Params:
    0: site index
    1: center position
*/

params ["_siteIndex", "_center"];
if (!isServer) exitWith {};

private _cellSize = 1000;

private _cx = floor ((_center#0) / _cellSize);
private _cy = floor ((_center#1) / _cellSize);
private _cellId = format ["%1_%2", _cx, _cy];

if (isNil "STALKER_minefieldCells") then { STALKER_minefieldCells = createHashMap };

private _arr = STALKER_minefieldCells getOrDefault [_cellId, []];
if ({ _siteIndex in _arr } count [] == 0) then { _arr pushBack _siteIndex };
STALKER_minefieldCells set [_cellId, _arr];

_cellId
