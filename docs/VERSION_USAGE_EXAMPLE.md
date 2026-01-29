# Using Version Macros in SQF

The version information defined in `addons/main/script_version.hpp` can be used throughout your SQF code.

## Including the Header

At the top of any SQF file that needs version information:

```sqf
#include "..\..\addons\main\script_version.hpp"
```

Or from within the main addon itself:

```sqf
#include "script_version.hpp"
```

## Available Macros

### Individual Components (Numeric)
- `VERSION_MAJOR` - Major version number (e.g., 1)
- `VERSION_MINOR` - Minor version number (e.g., 0)
- `VERSION_PATCH` - Patch version number (e.g., 0)
- `VERSION_BUILD` - Build number (auto-incremented)

### Individual Components (String)
- `VERSION_MAJOR_STR` - Major as string (e.g., "1")
- `VERSION_MINOR_STR` - Minor as string (e.g., "0")
- `VERSION_PATCH_STR` - Patch as string (e.g., "0")
- `VERSION_BUILD_STR` - Build as string (e.g., "0")

### Combined Strings
- `VERSION_STR` - Standard format (e.g., "1.0.0")
- `VERSION_STR_FULL` - Full format with build (e.g., "1.0.0.0")

### Integer Comparison
- `VERSION_INT` - Single integer for comparisons (Major * 10000 + Minor * 100 + Patch)

## Usage Examples

### Simple Version Display

```sqf
#include "..\..\addons\main\script_version.hpp"

if (isServer) then {
    diag_log "========================================";
    diag_log format ["Viceroy's STALKER ALife v%1", VERSION_STR];
    diag_log format ["Build: %1", VERSION_BUILD];
    diag_log "========================================";
};
```

### Version-Dependent Logic

```sqf
#include "..\..\addons\main\script_version.hpp"

// Only execute code if version is 1.1.0 or higher
if (VERSION_INT >= 10100) then {
    diag_log "Running enhanced features from v1.1.0+";
};

// Check for specific version
if (VERSION_MAJOR == 1 && VERSION_MINOR >= 2) then {
    diag_log "Running features from v1.2.0+";
};
```

### Version Info in Init Script

```sqf
#include "..\..\addons\main\script_version.hpp"

if (!isServer) exitWith {
    diag_log format ["Client: Viceroy's STALKER ALife %1", VERSION_STR_FULL];
};

// Server initialization
diag_log format ["Server: Starting STALKER ALife v%1.%2.%3 (Build %4)", 
    VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH, VERSION_BUILD];
```

## Automatic Version Updates

The build number (`VERSION_BUILD`) is automatically incremented during GitHub Actions CI/CD when commits are pushed to the main branch. The version string in `script_version.hpp` is updated by the HEMTT build system before compilation.

## Best Practices

1. **Server Check First**: Use `if (!isServer) exitWith {};` before version logging to avoid client-side spam
2. **Use VERSION_INT for Comparisons**: For numeric version comparisons, always use `VERSION_INT` instead of comparing strings
3. **Include Once**: Include the header at the top of files that need it, not in every function
4. **Document Version Requirements**: If your feature requires a specific version, document it in comments
