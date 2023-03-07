class Axelard < Formula
  desc "The Axelar Network Core binary"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  
  version "0.32.2"
  if Hardware::CPU.arm?
    puts "ARM architecture detected"
    puts "CPU architecture: #{Hardware::CPU.arch}"
    puts "Is 64-bit: #{Hardware::CPU.is_64_bit?}"
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    sha256 "a2abc8da15710bae0e77571dece93a8d367b1e416da193477211ed9330cdbdf4"
  else
    puts "Intel architecture detected"
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
