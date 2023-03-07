class Axelard < Formula
  desc "The Axelar Network Core binary"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  
  version "0.32.2"
  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    sha256 "ae0d01190b8f6c2d6b37a6a291f6aa8c5f2d5eb5c5e5e5f8ed5c5d85b95bb43a"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
  end

  # Install the binary
  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
