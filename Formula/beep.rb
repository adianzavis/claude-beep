class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/adianzavis/claude-beep"
  url "https://github.com/adianzavis/claude-beep/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "98e653180b18f07176b59b4e960dbef4c855d0c89206e5e85db9ff1a8aa61f7c"
  license "MIT"

  head "https://github.com/adianzavis/claude-beep.git", branch: "main"

  def install
    bin.install "bin/beep"
  end

  test do
    system "#{bin}/beep", "1"
  end
end
