# Version Management System

This project uses a semantic versioning system managed through `project.toml` and `script_version.hpp`.

## Files

### `project.toml`
Main configuration file for the mod build system. Contains:
- **Version table**: Major, minor, patch, and build numbers
- **Build settings**: Lists all addons to compile
- **Publishing settings**: Auto-increment configuration
- **Mod metadata**: Name, author, description

### `addons/main/script_version.hpp`
SQF header file with version macros for use in scripts:
- `VERSION_MAJOR`, `VERSION_MINOR`, `VERSION_PATCH`, `VERSION_BUILD` - Integer defines
- `VERSION_*_STR` - String versions of each component
- `VERSION_STR` - Combined version string (e.g., "1.0.0")
- `VERSION_STR_FULL` - Full version with build (e.g., "1.0.0.0")
- `VERSION_INT` - Integer encoding (Major * 10000 + Minor * 100 + Patch)

### `scripts/update_version.py`
Python script to update both version files. Automatically called by CI/CD.

## Usage

### Local Development
To manually increment the patch version:
```bash
python scripts/update_version.py --patch
```

To increment minor version (resets patch to 0):
```bash
python scripts/update_version.py --minor
```

To increment major version (resets minor and patch to 0):
```bash
python scripts/update_version.py --major
```

### Automatic Updates (GitHub Actions)
The CI/CD workflow automatically:
1. Runs checks on all pull requests
2. On merge to `main`, automatically increments the patch version
3. Builds all addons with HEMTT
4. Creates release artifacts

## How It Works

1. **Version Source of Truth**: `project.toml` contains the authoritative version
2. **Header File**: `script_version.hpp` is updated to match when versions change
3. **CI/CD Integration**: GitHub Actions runs `update_version.py` on each push to `main`
4. **Build System**: HEMTT uses the version during compilation

## Using Version Macros in SQF

Include the version header in your SQF scripts:
```sqf
#include "..\main\script_version.hpp"

diag_log format ["Running STALKER ALife v%1", VERSION_STR];
```

## Version Format

```
MAJOR.MINOR.PATCH.BUILD

- MAJOR: Significant gameplay changes
- MINOR: New features or systems
- PATCH: Bug fixes and improvements
- BUILD: CI/CD build number (auto-incremented)
```

Example: `1.2.5.42` means Major version 1, with 2 minor features, 5 patches, built as CI run #42.

## Best Practices

- **Don't manually edit `script_version.hpp`** - It's auto-generated
- **Edit `project.toml` version only for releases** - Normal development uses auto-increment
- **Always pull before pushing** to avoid version conflicts
- **Run `update_version.py` locally** before building releases
