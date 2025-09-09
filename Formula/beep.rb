class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.54.tar.gz"
  sha256 "cff38aaef191b739a9955098c8bad8142d7d9776ad1812b74b676659c4183078"
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

  test do
    system "#{bin}/claude-beep", "1"
  end
end
