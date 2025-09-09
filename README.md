# 🔊 claude-beep

Simple macOS beep commands for monitoring Claude CLI and playing notification sounds.


## 📦 Installation

Install using Homebrew:
```bash
# Add the tap and install the package
brew tap adianzavis/claude-beep https://github.com/adianzavis/claude-beep
brew install adianzavis/claude-beep/beep
```

This will automatically:
✅ **Install beep commands** - `beep-disturb`, `beep-success`, `claude-beep`  
✅ **Replace `claude` command** - Your `claude` command now includes beep notifications  
✅ **Install sound files** - Various notification sounds to choose from  
✅ **Create config directory** - `~/.config/claude-beep/` for user settings  

## 🚀 Usage

### 🤖 Automatic Claude Integration
After installation, just use Claude normally:
```bash
claude          # Interactive Claude with beep notifications
claude chat     # Also works with beep notifications  
claude code     # Also works with beep notifications
```

The beep notifications will trigger when Claude shows:
- "Do you want to proceed?"
- "Opened changes in"  
- " ❯ 1. Yes  "

### 🎯 Direct Wrapper Usage
```bash
claude-beep chat    # Direct wrapper usage
claude-beep code    # Also available
```

### 🔔 Manual beeping
```bash
beep-disturb        # Play alert sound
beep-success        # Play success sound
beep-disturb -s     # 🎵 Select alert sound interactively
beep-success -s     # 🎵 Select success sound interactively
```

## ⚙️ Configuration

Sounds are configured using config files in `~/.config/claude-beep/`:

```bash
# Set disturb sound manually
echo "/opt/homebrew/Cellar/beep/1.0.64/bin/disturb-sounds/bmw.aac" > ~/.config/claude-beep/.beep_disturb_config

# Set success sound manually  
echo "/opt/homebrew/Cellar/beep/1.0.64/bin/success-sounds/laugh.aac" > ~/.config/claude-beep/.beep_success_config
```

Available sounds are in:
- Disturb sounds: `/opt/homebrew/Cellar/beep/*/bin/disturb-sounds/`
- Success sounds: `/opt/homebrew/Cellar/beep/*/bin/success-sounds/`

Defaults
- On first install, defaults are set if none exist:
  - Disturb: `scratch.aac`
  - Success: `basic.aac`
  Update anytime with `beep-disturb --select` or `beep-success --select`.

## 🗑️ Uninstallation

```bash
# Uninstall the package (this automatically removes the claude wrapper)
brew uninstall adianzavis/claude-beep/beep
rm /opt/homebrew/bin/claude

# Remove tap (optional)
brew untap adianzavis/claude-beep

# Remove config files (optional)
rm -rf ~/.config/claude-beep/

# If claude command still doesn't work after uninstall:
which claude                # Check where claude is located
hash -r                    # Clear command hash cache
```

The uninstall process automatically removes the `claude` wrapper that was created during installation. If you encounter issues with the `claude` command after uninstalling, use the troubleshooting commands above.
