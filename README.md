# claude-beep

Simple macOS beep commands for monitoring Claude CLI and playing notification sounds.

## Installation

Install using Homebrew:

```bash
brew install adianzavis/claude-beep/beep
```

This will install the following commands:
- `claude-beep` - Monitor Claude CLI and beep on prompts
- `claude-beep-simple` - Simple version 
- `beep-disturb` - Play disturbing/alert sounds
- `beep-success` - Play success sounds

## Usage

### Monitor Claude CLI
```bash
claude-beep chat
claude-beep code
```

The `claude-beep` command will monitor your Claude CLI session and play alert sounds when Claude asks "Do you want to proceed?" or shows file change prompts.

### Manual beeping
```bash
beep-disturb    # Play alert sound
beep-success    # Play success sound
```