/*
    Spawns all anomaly fields at the end of an emission.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
*/
params ["_center","_radius"];

[_center,_radius] call VSTKR_fnc_createField_burner;
[_center,_radius] call VSTKR_fnc_createField_clicker;
[_center,_radius] call VSTKR_fnc_createField_electra;
[_center,_radius] call VSTKR_fnc_createField_fruitpunch;
[_center,_radius] call VSTKR_fnc_createField_gravi;
[_center,_radius] call VSTKR_fnc_createField_meatgrinder;
[_center,_radius] call VSTKR_fnc_createField_springboard;
[_center,_radius] call VSTKR_fnc_createField_whirligig;
