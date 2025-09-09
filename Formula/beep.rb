class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.58.tar.gz"
  sha256 "b43c37f19655381da0abbb4055432678ffec5dc9f7c0b84a079640bac061bc7d"
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
        system "cp", claude_path, original_claude
      end
      
      # Create wrapper script that calls claude-beep
      claude_wrapper = <<~SCRIPT
        #!/bin/bash
        exec "#{bin}/claude-beep" "$@"
      SCRIPT
      
      File.write(claude_path, claude_wrapper)
      system "chmod", "+x", claude_path
      
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
      system "cp", original_claude, claude_path
      system "rm", "-f", original_claude
      puts "✅ Original claude command restored"
    end
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
