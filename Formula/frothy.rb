# typed: strict
# frozen_string_literal: true

# Substitute only from real, reachable Frothy release archives.
class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/frothy/archive/refs/tags/v0.1.16.tar.gz"
  sha256 "61fc7c584a04b4634e13eda183fc9d8a0461100ebaded27ec9c4eda8685c9faa"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"
  depends_on "picotool"

  resource "firmware" do
    url "https://github.com/nikokozak/frothy/releases/download/v0.1.16/frothy-firmware-v0.1.16.tar.gz"
    sha256 "865a667a41d31019f6c0241ad15085c98a442f63079642482644a0f41b570f22"
  end

  def install
    system "make", "install-host", "PREFIX=#{prefix}", "GO_CACHE=#{buildpath}/.gocache"
    resource("firmware").stage do
      (pkgshare/"firmware").install Dir["*"]
    end
  end

  test do
    assert_match "usage: frothy <verb>", shell_output("#{bin}/frothy --help")
    assert_path_exists pkgshare/"firmware/manifest.json"
    assert_match "unknown board", shell_output("#{bin}/frothy flash not-a-board 2>&1", 2)
  end
end
