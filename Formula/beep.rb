class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "ce99acd7ebcc5e7f067bc62fc31df8f837b6c46caa79bf0d6b619e8a5a451b1c"
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
