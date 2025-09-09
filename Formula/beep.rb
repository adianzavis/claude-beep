class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.52.tar.gz"
  sha256 "4de89fc409cc705b7ca06791de979e288ac6bcd1c6efd5565f504a675ca043d4"
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
