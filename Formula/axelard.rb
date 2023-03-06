class Axelard < Formula
  desc "Axelar Core - A decentralized interoperability network for cross-chain communication"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  url "https://github.com/axelarnetwork/axelar-core/releases/latest/download/axelard-darwin-amd64-latest.tar.gz"
  version "latest"
  sha256 "d5f63616a21f1c767cc40b06a291b10d50b3c53e9a31a9c5e7863615b7e1f5d5"

  bottle :unneeded

  livecheck do
    url "https://github.com/axelarnetwork/axelar-core/releases/latest"
    regex(%r{href=.*?/axelard-darwin-amd64-v?(\d+(?:\.\d+)+)(?:-beta)?\.t}i)
  end

  def install
    bin.install "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
