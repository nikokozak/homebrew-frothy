class Frothy < Formula
  desc "Legacy tap entry for Froth"
  homepage "https://frothlang.org"
  disable! date: "2026-05-06", because: "renamed to Froth; install nikokozak/froth/froth"

  def install
    odie "Frothy has been renamed to Froth. Run: brew install nikokozak/froth/froth"
  end
end
