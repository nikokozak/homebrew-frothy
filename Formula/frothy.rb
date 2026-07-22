# typed: strict
# frozen_string_literal: true

class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/FrothyRewrite/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "40337a8df2515068529f2c27b2e66ab621a64bf8a1535fd6355d73177c998622"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/FrothyRewrite/releases/download/v0.1.8/frothy-firmware-v0.1.8.tar.gz"
    sha256 "47851a91a681cfe9f71884e7860cdfa366de2f3e8cf3c855f0844ec4678deaa0"
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
