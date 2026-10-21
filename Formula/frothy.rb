# typed: strict
# frozen_string_literal: true

# Substitute only from real, reachable Frothy release archives.
class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/frothy/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "ad4bc163efa0c8efc0bf349f4d69e78f9d44e8d105efdd8ef1c00989a11f950f"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"
  depends_on "picotool"

  resource "firmware" do
    url "https://github.com/nikokozak/frothy/releases/download/v0.1.23/frothy-firmware-v0.1.23.tar.gz"
    sha256 "bd40e8da784fc829a3f88656414ae3973bf56447604feee075d18ca7b2ed3a5d"
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
