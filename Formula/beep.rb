class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/YOURNAME/beep/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  def install
    bin.install "bin/beep"
  end

  test do
    system "#{bin}/beep", "1"
  end
end
