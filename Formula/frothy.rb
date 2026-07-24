# typed: strict
# frozen_string_literal: true

# Substitute only from real, reachable Frothy release archives.
class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/frothy/archive/refs/tags/v0.1.12.tar.gz"
  sha256 "cb4c1d3173b5d9907de728818a2c75384568101505eea7e3351f52f30989aae5"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"

  resource "firmware" do
    url "https://github.com/nikokozak/frothy/releases/download/v0.1.12/frothy-firmware-v0.1.12.tar.gz"
    sha256 "1e8c64ec180c7951b97374ed37f3552d81f2254dd9009404503fec80da369e48"
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
