
I apologize for the confusion. Here's the updated formula with the ability to specify a version:

ruby
Copy code
class Axelard < Formula
  desc "The Axelar Network Core binary"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  # Define the available versions and platforms
  VERSIONS = {
    "0.32.0" => {
      amd64: "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d",
      arm64: "ebc8e3f9c9a0c4d4f4b41c038dc690ebf6af30e6df1de6e3fb6f3d8c8b6f0bc6",
    },
    "0.32.2" => {
      amd64: "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d",
      arm64: "a2abc8da15710bae0e77571dece93a8d367b1e416da193477211ed9330cdbdf4",
    },
  }

  # Determine the platform and URL based on the system architecture
  if Hardware::CPU.arm?
    platform = :arm64
    puts "ARM architecture detected"
    puts "CPU architecture: #{Hardware::CPU.arch}"
    puts "Is 64-bit: #{Hardware::CPU.is_64_bit?}"
  else
    platform = :amd64
    puts "Intel architecture detected"
  end

  # Select the latest version if none is specified
  latest_version = VERSIONS.keys.last
  version = ARGV.value("version") || latest_version
  puts "Selected version: #{version}"

  # Retrieve the SHA256 hash for the selected version and platform
  sha256 = VERSIONS[version][platform]
  ohai "Warning: No SHA256 hash found for Axelard version #{version} and platform #{platform}" unless sha256

  # Define the URL based on the selected version and platform
  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-#{platform}-v#{version}.zip"
  sha256 sha256

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
