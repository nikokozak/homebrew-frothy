class Frothy < Formula
  desc "A live lexical language for programmable devices"
  homepage "https://github.com/nikokozak/frothy"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.0-darwin-arm64.tar.gz"
      sha256 "59a94335479141c19b939985f867c46b4551361a32f1aedb012863f37d45d9e6"
    end
    on_intel do
      url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.0-darwin-amd64.tar.gz"
      sha256 "fdaace413b5d798129eaa7bbbfc069bd56ecf96bae99c015d2128e7e80b887ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.0-linux-amd64.tar.gz"
      sha256 "e144b6a1d0146f2432c5b328748181b883cf836067e1289b566db57b5ae98210"
    end
  end

  def install
    bin.install "frothy"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/frothy --version")
  end
end
