class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.62.tar.gz"
  sha256 "PLACEHOLDER_HASH"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep-disturb"
    bin.install "bin/beep-success"
    bin.install "bin/claude-beep"
    bin.install "bin/claude-beep-simple"
    
    # Install sound directories to bin directory
    bin.install "bin/disturb-sounds"
    bin.install "bin/success-sounds"
    
    # Config files are now created dynamically in ~/.config/claude-beep/
  end

  def post_install
    # Create claude wrapper in homebrew bin (which comes first in PATH)
    claude_wrapper_path = "#{HOMEBREW_PREFIX}/bin/claude"
    
    # Only create if it doesn't already exist
    if !File.exist?(claude_wrapper_path)
      claude_wrapper = <<~SCRIPT
        #!/bin/bash
        exec "#{bin}/claude-beep" "$@"
      SCRIPT
      
      File.write(claude_wrapper_path, claude_wrapper)
      system "chmod", "+x", claude_wrapper_path
      
      puts <<~EOS
        ✅ Claude wrapper installed successfully!
        
        The 'claude' command now automatically includes beep notifications.
        - Wrapper created at: #{claude_wrapper_path}
        - Original claude preserved at its original location
        - Use 'claude-beep' directly if needed
        
        Configure sounds with:
          beep-disturb --select    # Choose disturb sound
          beep-success --select    # Choose success sound
      EOS
    else
      puts <<~EOS
        ℹ️  Claude wrapper already exists at #{claude_wrapper_path}
        
        Your claude command already has beep notifications enabled.
        Use 'claude-beep' directly if needed.
      EOS
    end
  end

  def pre_uninstall
    # Remove claude wrapper if it exists and was created by us
    claude_wrapper_path = "#{HOMEBREW_PREFIX}/bin/claude"
    
    if File.exist?(claude_wrapper_path)
      # Check if it's our wrapper by looking for claude-beep in the content
      content = File.read(claude_wrapper_path) rescue ""
      if content.include?("claude-beep")
        File.delete(claude_wrapper_path)
        puts "✅ Claude wrapper removed"
      end
    end
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
