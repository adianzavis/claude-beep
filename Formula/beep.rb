class Beep < Formula
  desc "Simple macOS beep command"
  homepage "https://github.com/YOURNAME/beep"
  url "https://github.com/YOURNAME/beep/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "PUT_THE_SHA256_OF_TARBALL_HERE"
  license "MIT"

  def install
    bin.install "bin/beep"
  end

  test do
    system "#{bin}/beep", "1"
  end
end
