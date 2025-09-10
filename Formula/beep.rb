class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "45be4925558f9529ee7d11cf216fc9d49550c0b80909226e1dd7688fbe214bb9"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep-disturb"
    bin.install "bin/beep-success"
    bin.install "bin/claude-beep-init"
    bin.install "bin/claude-beep-remove"

    # Install sound directories to bin directory
    bin.install "bin/disturb-sounds"
    bin.install "bin/success-sounds"

    # Config files are now created dynamically in ~/.config/claude-beep/
  end

  def post_install
    # Initialize default sound config if not set by user
    begin
      config_dir = File.join(Dir.home, ".config", "claude-beep")
      disturb_cfg = File.join(config_dir, ".beep_disturb_config")
      success_cfg = File.join(config_dir, ".beep_success_config")
      default_disturb_name = "scratch.aac"
      default_success_name = "basic.aac"
      default_disturb_path = File.join(bin, "disturb-sounds", default_disturb_name)
      default_success_path = File.join(bin, "success-sounds", default_success_name)

      Dir.mkdir(config_dir) unless Dir.exist?(config_dir)

      if File.exist?(default_disturb_path) && (!File.exist?(disturb_cfg) || File.zero?(disturb_cfg))
        File.write(disturb_cfg, default_disturb_name)
      end

      if File.exist?(default_success_path) && (!File.exist?(success_cfg) || File.zero?(success_cfg))
        File.write(success_cfg, default_success_name)
      end
    rescue => e
      opoo "Could not initialize default beep configs: #{e.message}"
    end

    puts <<~EOS
      ✅ Beep commands installed successfully!

      Available commands:
        beep-disturb         # Play disturb sound
        beep-success         # Play success sound
        claude-beep-init     # Initialize Claude Code hooks
        claude-beep-remove   # Remove Claude Code hooks

      Defaults configured (if none existed):
        Disturb: #{default_disturb_name} (in #{bin}/disturb-sounds)
        Success: #{default_success_name} (in #{bin}/success-sounds)

      Setup Claude Code integration:
        claude-beep-init     # Add beep hooks to Claude settings
        claude-beep-remove   # Remove beep hooks from settings

      Change sounds anytime with:
        beep-disturb --select    # Choose disturb sound
        beep-success --select    # Choose success sound
    EOS
  end

  def post_uninstall
    puts <<~EOS
      🧹 Uninstall complete!

      Optional cleanup:
        rm -rf ~/.config/claude-beep/    # Remove config files
    EOS
  end

  test do
    system "#{bin}/beep-success"
  end
end
