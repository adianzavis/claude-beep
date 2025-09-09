class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.53.tar.gz"
  sha256 "6d96a1640cce9bfb4f77a40622b84183dc6b58154be702f19bc6fd603135db43"
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
