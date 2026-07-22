# typed: strict
# frozen_string_literal: true

class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/FrothyRewrite/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "423a6fff4f12443f68efd540e5cea67fe57c2148d341675d4d51f66eb1206a81"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/FrothyRewrite/releases/download/v0.1.9/frothy-firmware-v0.1.9.tar.gz"
    sha256 "bca0e90c328d183e9721bdfb59998589e890fab969c9270696db22f482ce36cf"
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
