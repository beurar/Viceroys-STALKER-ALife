/*
    Places debug markers for all cached map data.
*/

["placeCachedMarkers"] call VIC_fnc_debugLog;

[] call VIC_fnc_markRockClusters;
[] call VIC_fnc_markSniperSpots;
[] call VIC_fnc_markSwamps;
[] call VIC_fnc_markBeaches;
[] call VIC_fnc_markValleys;
[] call VIC_fnc_markLandZones;
[] call VIC_fnc_markBuildingClusters;
[] call VIC_fnc_markBridges;
[] call VIC_fnc_markRoads;
[] call VIC_fnc_markWrecks;

true
