# typed: strict
# frozen_string_literal: true

class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/FrothyRewrite/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "cd5e84473e804e0e96f4bbffcc9fd23d2c383c29eae833412030700986a022c5"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/FrothyRewrite/releases/download/v0.1.4/frothy-firmware-v0.1.4.tar.gz"
    sha256 "19e7422862aaa7da09ac3ea45827bcb84258e0cdce75c3e200ef3029377c92b3"
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
