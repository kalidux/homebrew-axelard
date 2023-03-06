class Axelard < Formula
  desc "Axelar Network full node"
  homepage "https://axelar.network/"
  version "0.31.2"

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    sha256 "f60a9c1b8b3bb2c3d3e2a2c96e80b10d1129001a41b1df9b7a77a731f3697c46"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256 "f60a9c1b8b3bb2c3d3e2a2c96e80b10d1129001a41b1df9b7a77a731f3697c46"
  end

  def install
    bin.install "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
