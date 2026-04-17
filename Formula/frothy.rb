class Frothy < Formula
  desc "Live lexical language for programmable devices"
  homepage "https://github.com/nikokozak/frothy"
  url "https://github.com/nikokozak/frothy/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e1ecd6143cb3eaf73e2a653942fe4754e2b503b43e09f77822a7e87456f2a907"
  license "MIT"

  head "https://github.com/nikokozak/frothy.git", branch: "main"

  depends_on "go" => :build

  def install
    cd "tools/cli" do
      system "go", "run", "./internal/sdk/cmd/generate",
             "-repo", buildpath.to_s,
             "-out", "internal/sdk/generated"
      system "go", "build", "-o", bin/"frothy", "."
    end
  end

  test do
    output = shell_output("#{bin}/frothy --version")
    assert_match "frothy ", output
  end
end
