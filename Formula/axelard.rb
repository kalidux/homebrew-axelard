class Axelard < Formula
  desc "The Axelar Network Core binary"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  versions = ["0.32.2", "0.32.0"]
  sha256s = {
    "0.32.2-amd" => "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d",
    "0.32.2-arm" => "a2abc8da15710bae0e77571dece93a8d367b1e416da193477211ed9330cdbdf4",
    "0.32.0-amd" => "4993e2ba3937d372fd518ed6419ef8d9d5c12bd0375a10d5ac4b0a7750647a90",
    "0.32.0-arm" => "e152f8d87d097f9c790a07fa4e9dcc4359b0b71925146edf62ffd7d7ea857159",
  }

  versions.each do |version|
    if Hardware::CPU.arm?
      puts "ARM architecture detected"
      puts "CPU architecture: #{Hardware::CPU.arch}"
      puts "Is 64-bit: #{Hardware::CPU.is_64_bit?}"
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
      sha256 sha256s["#{version}-arm"]
    else
      puts "Intel architecture detected"
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
      sha256 sha256s["#{version}-amd"]
    end

    version version

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
end
