/*
    Returns true when Antistasi Ultimate patches are loaded.
*/

private _patches = configProperties [configFile >> "CfgPatches", "isClass _x"];
(_patches findIf {
    private _name = toLower configName _x;
    (_name find "a3u") >= 0 || (_name find "antistasi") >= 0
}) > -1
