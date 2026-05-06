class Frothy < Formula
  desc "Legacy tap entry for Froth"
  homepage "https://frothlang.org"
  url "https://github.com/nikokozak/froth/archive/7533c8167ad591f01a7e1bcddda827536efdb9f7.tar.gz"
  version "0.1.0"
  sha256 "2a915503548a6423e6ee813e6f993f9a219bacc6e7535a3544508cf46eb57b8e"
  license "MIT"
  disable! date: "2026-05-06", because: "renamed to Froth; install nikokozak/froth/froth"

  def install
    odie "Frothy has been renamed to Froth. Run: brew install nikokozak/froth/froth"
  end
end
