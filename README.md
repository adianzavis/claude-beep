# 🔊 claude-beep

Simple macOS beep commands for Claude Code notifications and manual sound alerts.

## 📦 Installation

Install using Homebrew:
```bash
# Add the tap and install the package
brew tap adianzavis/claude-beep https://github.com/adianzavis/claude-beep
brew install adianzavis/claude-beep/beep
```

This will automatically:
✅ **Install beep commands** - `beep-disturb`, `beep-success`, `claude-beep-init`  
✅ **Install sound files** - Various notification sounds to choose from  
✅ **Create config directory** - `~/.config/claude-beep/` for user settings  

## 🚀 Usage

### 🤖 Claude Code Integration
Set up beep notifications for Claude Code:
```bash
claude-beep-init    # Add beep hooks to Claude Code settings
```

This configures Claude Code to automatically play:
- **Success beep** when tasks complete (Stop events)
- **Disturb beep** for notifications

Additional options:
```bash
claude-beep-init --force    # Overwrite existing hooks
claude-beep-init --remove   # Remove beep hooks
claude-beep-init --help     # Show help
```

### 🔔 Manual Beeping
```bash
beep-disturb        # Play alert sound
beep-success        # Play success sound
beep-disturb --select    # 🎵 Select alert sound interactively
beep-success --select    # 🎵 Select success sound interactively
```

## ⚙️ Configuration

### 🎵 Sound Selection
Use interactive sound selection:
```bash
beep-disturb --select    # Choose from available disturb sounds
beep-success --select    # Choose from available success sounds
```
Press [space] to play the sound in selection
Press [enter] to select sound

### 🔧 Manual Configuration
Sounds are configured using config files in `~/.config/claude-beep/`:

```bash
# Set disturb sound manually
echo "scratch.aac" > ~/.config/claude-beep/.beep_disturb_config

# Set success sound manually  
echo "basic.aac" > ~/.config/claude-beep/.beep_success_config
```

Available sounds are in:
- **Disturb sounds**: `/opt/homebrew/Cellar/beep/*/bin/disturb-sounds/`
- **Success sounds**: `/opt/homebrew/Cellar/beep/*/bin/success-sounds/`

**Defaults**: On first install, defaults are automatically set:
- Disturb: `scratch.aac`
- Success: `basic.aac`

## 🗑️ Uninstallation

```bash
# Uninstall the package
brew uninstall adianzavis/claude-beep/beep

# Remove tap (optional)
brew untap adianzavis/claude-beep

# Remove config files (optional)  
rm -rf ~/.config/claude-beep/
```

## 🔄 Upgrading from v1.1.x

If you were using the previous version with automatic Claude wrapper:
1. **The wrapper has been removed** - `claude` command returns to normal behavior
2. **Use `claude-beep-init`** - Set up Claude Code hooks for notifications
3. **All sounds still work** - `beep-disturb` and `beep-success` unchanged

```bash
# After upgrading, set up Claude Code integration
claude-beep-init
```
