class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.56.tar.gz"
  sha256 "400adc3c4d1b77071f5ede404d8205a2202106f3347ad2dd910e837fb9681b3c"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep-disturb"
    bin.install "bin/beep-success"
    bin.install "bin/claude-beep"
    bin.install "bin/claude-beep-simple"
    
    # Install sound directories and configs to bin directory
    bin.install "bin/disturb-sounds"
    bin.install "bin/success-sounds"
    bin.install "bin/.beep_disturb_config"
    bin.install "bin/.beep_success_config"
  end

  def post_install
    # Check if claude command exists
    claude_path = `which claude 2>/dev/null`.strip
    
    if !claude_path.empty?
      # Backup original claude if not already done
      original_claude = "#{claude_path}-original"
      if !File.exist?(original_claude)
        system "sudo", "mv", claude_path, original_claude
      end
      
      # Create symlink to claude-beep
      system "sudo", "ln", "-sf", "#{bin}/claude-beep", claude_path
      
      puts <<~EOS
        ✅ Claude wrapper installed successfully!
        
        The 'claude' command now automatically includes beep notifications.
        - Original claude command backed up as: #{original_claude}
        - Use 'claude-beep' directly if needed
        - Use '#{original_claude}' to bypass beep notifications
        
        Configure sounds with:
          beep-disturb --select    # Choose disturb sound
          beep-success --select    # Choose success sound
      EOS
    else
      puts <<~EOS
        ⚠️  Claude command not found in PATH.
        
        Beep commands installed:
          claude-beep   # Wrapper for claude with beep notifications
          beep-disturb  # Disturb beep sound
          beep-success  # Success beep sound
          
        To set up claude wrapper manually:
          alias claude='claude-beep'
      EOS
    end
  end

  def pre_uninstall
    # Restore original claude command if it exists
    claude_path = `which claude 2>/dev/null`.strip
    original_claude = "#{claude_path}-original"
    
    if !claude_path.empty? && File.exist?(original_claude)
      system "sudo", "rm", "-f", claude_path
      system "sudo", "mv", original_claude, claude_path
      puts "✅ Original claude command restored"
    end
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
