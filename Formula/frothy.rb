# typed: strict
# frozen_string_literal: true

class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/FrothyRewrite/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "a974525dc34e59c5be43118253d7122b56721da193dc7577681b6171985e10f5"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/FrothyRewrite/releases/download/v0.1.5/frothy-firmware-v0.1.5.tar.gz"
    sha256 "056babc0bb6e0f1833084e81eb23607b5842ed203b2eb8e0b39af22c7cb8e63a"
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
