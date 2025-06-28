/*
    Spawns a single stalker camp at the given position.
    Camp side is chosen randomly using configured side weights.
    Params:
        0: POSITION - camp position
*/
params ["_pos"];

["spawnStalkerCamp"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_camps") then { STALKER_camps = []; };

private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;
private _wBlu = ["VSA_stalkerCampBLUChance", 34] call VIC_fnc_getSetting;
private _wOpf = ["VSA_stalkerCampOPFChance", 33] call VIC_fnc_getSetting;
private _wInd = ["VSA_stalkerCampINDChance", 33] call VIC_fnc_getSetting;

private _side = selectRandomWeighted [blufor,_wBlu,opfor,_wOpf,independent,_wInd];

private _factions = ["Bandits","ClearSky","Ecologists","Military","Duty","Freedom","Loners","Mercs"];
private _faction  = selectRandom _factions;

private _grp = createGroup _side;
private _class = switch (_side) do {
    case blufor: { "B_Soldier_F" };
    case opfor: { "O_Soldier_F" };
    default { "I_Soldier_F" };
};
for "_i" from 1 to _size do {
    _grp createUnit [_class, _pos, [], 0, "FORM"];
};

private _campfire = "Campfire_burning_F" createVehicle _pos;

// Random loot crate near the camp
private _cratePos = _pos getPos [2, random 360];
private _crate = "Box_NATO_Equip_F" createVehicle _cratePos;
private _weapons = ["arifle_AK12_F","arifle_MX_F","SMG_02_F"];
private _items   = ["FirstAidKit","NVGoggles_INDEP","binocular"];
{ _crate addItemCargoGlobal [_x,1] } forEach (selectRandom _items);
_crate addWeaponCargoGlobal [selectRandom _weapons,1];

// Tripflare perimeter around camp
[_pos, 12, 8] call VIC_fnc_spawnFlareTripwires;

// Some units relax by the fire
private _sitCount = (count units _grp) min 2;
for "_i" from 0 to (_sitCount - 1) do {
    private _unit = (units _grp) select _i;
    private _p = _campfire getPos [1.5 + random 0.5, random 360];
    _unit setPos _p;
    _unit disableAI "PATH";
    _unit playMove "Acts_SittingWounded_loop";
};
if (local _grp) then {
    if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
        [_grp, _pos, 50] call lambs_wp_fnc_taskCamp;
    } else {
        [_grp, _pos] call BIS_fnc_taskDefend;
    };
} else {
    if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
        [_grp, _pos, 50] remoteExecCall ["lambs_wp_fnc_taskCamp", groupOwner _grp];
    } else {
        [_grp, _pos] remoteExecCall ["BIS_fnc_taskDefend", groupOwner _grp];
    };
};

private _marker = "";
if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    _marker = format ["camp_%1", diag_tickTime];
    private _color = switch (_faction) do {
        case "Bandits": {"ColorOrange"};
        case "ClearSky": {"ColorCyan"};
        case "Ecologists": {"ColorKhaki"};
        case "Military": {"ColorGreen"};
        case "Duty": {"ColorRed"};
        case "Freedom": {"ColorBlue"};
        case "Loners": {"ColorWhite"};
        case "Mercs": {"ColorPink"};
        default {"ColorWhite"};
    };
    [_marker, _pos, "ICON", "mil_box", _color, 0.2, _faction] call VIC_fnc_createGlobalMarker;
};

STALKER_camps pushBack [_campfire, _grp, _pos, _marker, _side, _faction, false];
