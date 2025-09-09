class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.63.tar.gz"
  sha256 "PLACEHOLDER_SHA"
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
      begin
        # Check if it's our wrapper by looking for claude-beep in the content
        content = File.read(claude_wrapper_path)
        if content.include?("claude-beep")
          File.delete(claude_wrapper_path)
          puts "✅ Claude wrapper removed from #{claude_wrapper_path}"
        else
          puts "ℹ️  Claude wrapper exists but wasn't created by beep package - leaving it unchanged"
        end
      rescue => e
        puts "⚠️  Could not read claude wrapper: #{e.message}"
        # Try to remove it anyway if it looks like our wrapper
        if File.executable?(claude_wrapper_path) && File.size(claude_wrapper_path) < 200
          File.delete(claude_wrapper_path)
          puts "✅ Claude wrapper removed (forced)"
        end
      end
    else
      puts "ℹ️  No claude wrapper found at #{claude_wrapper_path}"
    end
  end

  def post_uninstall
    # Additional cleanup after uninstall
    claude_wrapper_path = "#{HOMEBREW_PREFIX}/bin/claude"
    config_dir = "#{Dir.home}/.config/claude-beep"
    
    # Remove claude wrapper if it still exists and points to our beep
    if File.exist?(claude_wrapper_path)
      begin
        content = File.read(claude_wrapper_path)
        if content.include?("claude-beep")
          File.delete(claude_wrapper_path)
          puts "✅ Claude wrapper cleaned up in post_uninstall"
        end
      rescue
        # Silently try to clean up
      end
    end
    
    puts <<~EOS
      🧹 Uninstall complete!
      
      Optional cleanup:
        rm -rf ~/.config/claude-beep/    # Remove config files
        
      If claude command still doesn't work, you may need to:
        which claude                      # Find where claude is located
        hash -r                          # Clear command hash cache
    EOS
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
