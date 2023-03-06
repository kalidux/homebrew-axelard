class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.32.2"

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    sha256 "7dd04a47a73a4b16f4fa4c578155e89e26ad2f197d1cf9b83c5ef862f63a4a4b"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256 "c8eb1535be5d2e5e5f6df9618baf5cf6b5f6eb1d01908c8a0a8a77a0b63f20e7"
  end

  def install
    bin.install "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
