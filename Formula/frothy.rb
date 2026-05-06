class Frothy < Formula
  desc "Legacy tap entry for Froth"
  homepage "https://frothlang.org"
  url "https://github.com/nikokozak/froth/archive/fb618da89a5f7f65f3d5b45b671f9629b86dbd80.tar.gz"
  version "0.1.0"
  sha256 "53955689edff65f401b5efff9be20b3d43589ec9f0949a72b5abf385f9adef84"
  license "MIT"
  disable! date: "2026-05-06", because: "renamed to Froth; install nikokozak/froth/froth"

  def install
    odie "Frothy has been renamed to Froth. Run: brew install nikokozak/froth/froth"
  end
end
