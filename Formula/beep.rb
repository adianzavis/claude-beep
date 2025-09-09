class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.51.tar.gz"
  sha256 "b59b7aacbbbb7b1901092ccc0f4fa131e83d4017468dfb76351736efe6949572"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep-disturb"
    bin.install "bin/beep-success"
    bin.install "bin/claude-beep"
    bin.install "bin/claude-beep-simple"
    
    # Install sound directories and configs to bin directory
    (bin/"disturb-sounds").install Dir["bin/disturb-sounds/*"]
    (bin/"success-sounds").install Dir["bin/success-sounds/*"]
    bin.install "bin/.beep_disturb_config"
    bin.install "bin/.beep_success_config"
  end

  test do
    system "#{bin}/claude-beep", "1"
  end
end
