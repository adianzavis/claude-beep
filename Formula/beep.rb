class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "1ba2ced8f777384749329c3a55a8abbdbc75dfb3b63e311375cd94ebceafb93c"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep-disturb"
    bin.install "bin/beep-success"
    bin.install "bin/claude-beep"
    bin.install "bin/claude-beep-simple"
    
    # Install sound directories and configs
    prefix.install "bin/disturb-sounds"
    prefix.install "bin/success-sounds"
    prefix.install "bin/.beep_disturb_config"
    prefix.install "bin/.beep_success_config"
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
