class Frothy < Formula
  desc "Live lexical language for programmable devices"
  homepage "https://github.com/nikokozak/frothy"
  version "0.1.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.1-darwin-arm64.tar.gz"
    sha256 "f38e8360d4e4c74b8611f17ca24ad3b1b14365649a25c1b9cdec9fc96d1778ee"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.1-darwin-amd64.tar.gz"
    sha256 "e221fcdde5d551ee97d9c4332361f70edca90bcd1885763cbb2cf8da3cc02980"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/nikokozak/frothy/releases/download/v#{version}/frothy-v0.1.1-linux-amd64.tar.gz"
    sha256 "2dcc23a035565a2ee5dba05d7a7fbf4fdbcec1959cd6e58ada56fca83d1d92"
  end

  head do
    url "https://github.com/nikokozak/frothy.git", branch: "main"
    depends_on "go" => :build
  end

  def install
    if build.head?
      cd "tools/cli" do
        system "go", "run", "./internal/sdk/cmd/generate",
               "-repo", buildpath.to_s,
               "-out", "internal/sdk/generated"
        system "go", "build", "-o", bin/"frothy", "."
      end
    else
      bin.install "frothy"
    end
  end

  test do
    output = shell_output("#{bin}/frothy --version")
    assert_match "frothy ", output
  end
end
