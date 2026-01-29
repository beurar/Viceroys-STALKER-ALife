/*
    Returns true when Antistasi Ultimate patches are loaded.
*/

private _result = false;
private _patches = configProperties [configFile >> "CfgPatches", "isClass _x"];
{
    private _name = toLower configName _x;
    if ((_name find "a3u") >= 0 || (_name find "antistasi") >= 0) exitWith { _result = true };
} forEach _patches;
_result
