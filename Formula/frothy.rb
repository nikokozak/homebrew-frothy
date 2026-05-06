class Frothy < Formula
  desc "Legacy tap entry for Froth"
  homepage "https://frothlang.org"
  url "https://github.com/nikokozak/frothy/archive/7533c8167ad591f01a7e1bcddda827536efdb9f7.tar.gz"
  version "0.1.0"
  sha256 "8bc62fb60435029a84d1dd94eec613acbad3161b60fd827a3c111f2541c28079"
  license "MIT"
  disable! date: "2026-05-06", because: "renamed to Froth; install nikokozak/froth/froth"

  def install
    odie "Frothy has been renamed to Froth. Run: brew install nikokozak/froth/froth"
  end
end
