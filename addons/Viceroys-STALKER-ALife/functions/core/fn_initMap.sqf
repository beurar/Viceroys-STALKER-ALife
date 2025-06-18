/*
    Caches all map positions required by STALKER ALife systems.
*/

["initMap"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

[] call VIC_fnc_findRockClusters;
[] call VIC_fnc_findSniperSpots;
[] call VIC_fnc_findSwamps;
[] call VIC_fnc_findBeachesInMap;
[] call VIC_fnc_findValleys;
[] call VIC_fnc_findBridges;
[] call VIC_fnc_findRoads;
[] call VIC_fnc_findCrossroads;
[] call VIC_fnc_findBuildingClusters;
[] call VIC_fnc_findWrecks;

true
