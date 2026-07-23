# typed: strict
# frozen_string_literal: true

# Substitute only from real, reachable Frothy release archives.
class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/FrothyRewrite/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "0a9439f3b4f412281ef05945b30d252ac59923b8b5844a4e43373dbae0798a44"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/FrothyRewrite/releases/download/v0.1.10/frothy-firmware-v0.1.10.tar.gz"
    sha256 "a80a508365aedcdee26785817349cbda3d38fa96c054e1f72744309086f24e33"
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
