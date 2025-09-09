# Claude.md - Development Notes

## Update Version Tutorial

Use these generic steps to cut a new release. Replace placeholders like `vX.Y.Z` with your target version.

1) Prep changes
- Verify working tree is clean and tests pass
- Capture notable changes for the release notes (optional)

2) Update Homebrew formula
- Edit `Formula/beep.rb`
  - Set `url` to `https://github.com/adianzavis/claude-beep/archive/refs/tags/vX.Y.Z.tar.gz`
  - Temporarily set `sha256` to a placeholder (any 64 hex chars) or leave old value

3) Commit changes
```bash
git add .
git commit -m "Release vX.Y.Z"
```

4) Tag and push
```bash
git tag vX.Y.Z
git push origin main
git push origin vX.Y.Z
```

5) Calculate SHA256 for the tag tarball
```bash
curl -L https://github.com/adianzavis/claude-beep/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
# Copy the 64‑char hash
```

6) Update formula with real hash and finalize
```bash
# Edit Formula/beep.rb -> set sha256 "<PASTE_HASH>"
git add Formula/beep.rb
git commit -m "Update sha256 for vX.Y.Z"
git push origin main
```

7) Verify locally (optional)
```bash
brew update
brew upgrade adianzavis/claude-beep/beep
```

Notes
- Follow semver for version bumps
- Ensure the tag exists before computing SHA
- If a tag already exists, delete and recreate it before publishing
- Keep defaults and install messages current in `Formula/beep.rb`

---

## How to Release a New Version (Step by Step Process)

### Overview
This document outlines the complete process for releasing a new version of the claude-beep Homebrew package when new sounds or features are added.

### Step-by-Step Release Process for v1.0.70

#### 1. Examine Current Project Structure and Version
- Checked the current version in `Formula/beep.rb`
- Used `git log --oneline -10` to see recent commits

#### 2. Identify New Changes
- **New sound added**: `git status`

#### 3. Update Version in Homebrew Formula
- Updated `Formula/beep.rb`:
  - Changed URL eg. from `v1.0.67.tar.gz` to `v1.0.70.tar.gz`  
  - Set SHA256 to placeholder initially: `"PLACEHOLDER_SHA256_HASH"`

#### 4. Create Git Commit and Tag
```bash
# Stage all changes
git add .

# Commit changes with descriptive message
git commit -m "Update commit message example

- Added basic.aac to success-sounds directory
- Moved scratch.aac from success-sounds to disturb-sounds  
- Updated Homebrew formula version to v1.0.70 //correct version here

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <adrian@anstudio.sk>"

# Update version number in formula
git add Formula/beep.rb
git commit -m "Update version to v1.0.70" //correct version here

# Push changes to main branch
git push origin main

# Create and push git tag
git tag v1.0.70
git push origin v1.0.70
```

#### 5. Calculate and Update SHA256 Hash
```bash
# Download tarball and calculate SHA256 hash
curl -L https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.70.tar.gz | shasum -a 256
```
Result: `d37cecc70b7abe8821f16284cdbee6b6651cd30e3bdd3057a541a6b8127be74e`

- Updated `Formula/beep.rb` with actual SHA256 hash
- Committed and pushed the final changes:

```bash
git add Formula/beep.rb
git commit -m "Update SHA256 hash for v1.0.70"
git push origin main
```

#### 6. Final State
- **Version**: v1.0.70
- **New sound**: `basic.aac` available in success-sounds
- **Homebrew formula**: Updated with correct URL and SHA256
- **Repository**: All changes committed and tagged

### Commands Users Need to Run
After the release is complete, users can update to the new version with:

```bash
brew update
brew upgrade adianzavis/claude-beep/beep
```

### Key Files Modified
1. `Formula/beep.rb` - Updated version URL and SHA256 hash
2. `bin/success-sounds/basic.aac` - New sound file added
3. `bin/success-sounds/scratch.aac` - Removed (moved to disturb-sounds)
4. `bin/disturb-sounds/scratch.aac` - Added (moved from success-sounds)

### Important Notes
- Always test the SHA256 hash calculation before finalizing
- Version numbers should follow semantic versioning
- Git tags are essential for Homebrew to download the correct version
- The SHA256 must match exactly what GitHub generates for the tarball

### Troubleshooting
If the git tag already exists:
```bash
git tag -d v1.0.70                    # Delete local tag
git push origin --delete v1.0.70      # Delete remote tag
git tag v1.0.70                       # Recreate tag
git push origin v1.0.70               # Push new tag
```
