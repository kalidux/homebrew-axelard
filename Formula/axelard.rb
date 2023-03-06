class Axelard < Formula
  desc "Axelar Core - A decentralized interoperability network for cross-chain communication"
  homepage "https://github.com/axelarnetwork/axelar-core"
  url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2"
  sha256 "cac744649ea01b223a04d8916b6413f3fb504cc45585cade4f511e35fcc10f40"
  license "Apache-2.0"

  def install
    bin.install "axelard-darwin-amd64-v0.32.2" => "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
