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

STALKER_camps pushBack [_campfire, _grp, _pos, _marker, _side, _faction];
