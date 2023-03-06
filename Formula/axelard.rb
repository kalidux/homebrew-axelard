class Axelard < Formula
  desc "Axelar Core - A decentralized interoperability network for cross-chain communication"
  homepage "https://github.com/axelarnetwork/axelar-core"
  url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2"
  sha256 "28b0fbfc838e5c49ca0451c2d2d40a0e0cfe4409f1a2d338e67fb0a92a0b69c7"
  license "Apache-2.0"

  def install
    bin.install "axelard-darwin-amd64-v0.32.2" => "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
