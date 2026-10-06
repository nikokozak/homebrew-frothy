# typed: strict
# frozen_string_literal: true

# Substitute only from real, reachable Frothy release archives.
class Frothy < Formula
  desc "Live language kernel CLI for programmable devices"
  homepage "https://frothy.dev"
  url "https://github.com/nikokozak/frothy/archive/refs/tags/v0.1.22.tar.gz"
  sha256 "fabcbe6191b8cc488516bb31002162934f2e99e40aa89bd064308a69371d9180"
  license "MIT"

  depends_on "go" => :build
  depends_on "esptool"
  depends_on "picotool"

  resource "firmware" do
    url "https://github.com/nikokozak/frothy/releases/download/v0.1.22/frothy-firmware-v0.1.22.tar.gz"
    sha256 "a0f42e695cf6a3d1ac977fb63f63acfac4b78a4abf13c9bba2dedbf48b66b567"
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
