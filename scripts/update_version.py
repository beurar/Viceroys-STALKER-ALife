#!/usr/bin/env python3
"""
Auto-increment patch version in project.toml and script_version.hpp
Run this before building/releasing
"""

import re
import sys
from pathlib import Path

def update_version(increment_patch=True, increment_minor=False, increment_major=False):
    """
    Update version in project.toml and script_version.hpp
    """
    project_root = Path(__file__).parent.parent
    project_toml = project_root / "project.toml"
    script_version = project_root / "addons" / "main" / "script_version.hpp"
    
    if not project_toml.exists():
        print(f"Error: {project_toml} not found")
        return False
    
    if not script_version.exists():
        print(f"Error: {script_version} not found")
        return False
    
    # Read current version from project.toml
    with open(project_toml, 'r') as f:
        content = f.read()
    
    # Extract version numbers
    major_match = re.search(r'major\s*=\s*(\d+)', content)
    minor_match = re.search(r'minor\s*=\s*(\d+)', content)
    patch_match = re.search(r'patch\s*=\s*(\d+)', content)
    build_match = re.search(r'build\s*=\s*(\d+)', content)
    
    if not all([major_match, minor_match, patch_match, build_match]):
        print("Error: Could not parse version from project.toml")
        return False
    
    major = int(major_match.group(1))
    minor = int(minor_match.group(1))
    patch = int(patch_match.group(1))
    build = int(build_match.group(1))
    
    # Increment version
    if increment_major:
        major += 1
        minor = 0
        patch = 0
        build = 0
    elif increment_minor:
        minor += 1
        patch = 0
        build = 0
    elif increment_patch:
        patch += 1
        build = 0
    else:
        build += 1
    
    print(f"Version: {major}.{minor}.{patch}.{build}")
    
    # Update project.toml
    new_content = re.sub(r'major\s*=\s*\d+', f'major = {major}', content)
    new_content = re.sub(r'minor\s*=\s*\d+', f'minor = {minor}', new_content)
    new_content = re.sub(r'patch\s*=\s*\d+', f'patch = {patch}', new_content)
    new_content = re.sub(r'build\s*=\s*\d+', f'build = {build}', new_content)
    
    with open(project_toml, 'w') as f:
        f.write(new_content)
    
    # Update script_version.hpp
    with open(script_version, 'r') as f:
        hpp_content = f.read()
    
    hpp_content = re.sub(r'#define VERSION_MAJOR \d+', f'#define VERSION_MAJOR {major}', hpp_content)
    hpp_content = re.sub(r'#define VERSION_MINOR \d+', f'#define VERSION_MINOR {minor}', hpp_content)
    hpp_content = re.sub(r'#define VERSION_PATCH \d+', f'#define VERSION_PATCH {patch}', hpp_content)
    hpp_content = re.sub(r'#define VERSION_BUILD \d+', f'#define VERSION_BUILD {build}', hpp_content)
    
    hpp_content = re.sub(r'#define VERSION_MAJOR_STR "\d+"', f'#define VERSION_MAJOR_STR "{major}"', hpp_content)
    hpp_content = re.sub(r'#define VERSION_MINOR_STR "\d+"', f'#define VERSION_MINOR_STR "{minor}"', hpp_content)
    hpp_content = re.sub(r'#define VERSION_PATCH_STR "\d+"', f'#define VERSION_PATCH_STR "{patch}"', hpp_content)
    hpp_content = re.sub(r'#define VERSION_BUILD_STR "\d+"', f'#define VERSION_BUILD_STR "{build}"', hpp_content)
    
    # Update combined version strings
    hpp_content = re.sub(r'#define VERSION_INT \d+', f'#define VERSION_INT {major * 10000 + minor * 100 + patch}', hpp_content)
    
    with open(script_version, 'w') as f:
        f.write(hpp_content)
    
    print(f"✓ Updated project.toml")
    print(f"✓ Updated script_version.hpp")
    return True

if __name__ == "__main__":
    increment_major = "--major" in sys.argv
    increment_minor = "--minor" in sys.argv
    increment_patch = "--patch" in sys.argv or (not increment_major and not increment_minor)
    
    if update_version(increment_patch=increment_patch, increment_minor=increment_minor, increment_major=increment_major):
        sys.exit(0)
    else:
        sys.exit(1)
