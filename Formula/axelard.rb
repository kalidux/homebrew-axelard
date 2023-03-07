class Axelard < Formula
  desc "The Axelar Network Core binary"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  versions = ["0.32.0", "0.32.2"]

  versions.each do |version|
    if Hardware::CPU.arm?
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
      sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip.sha256"
    else
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
      sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip.sha256"
    end

    version version

    if Hardware::CPU.arm?
      puts "ARM architecture detected"
      puts "CPU architecture: #{Hardware::CPU.arch}"
      puts "Is 64-bit: #{Hardware::CPU.is_64_bit?}"
    else
      puts "Intel architecture detected"
    end

    sha256 = ""

    begin
      sha256 = open(sha256_url).read.split(" ").first
    rescue
      odie "Error retrieving SHA256 hash for Axelard version #{version}"
    end

    puts "SHA256: #{sha256}"

    # Install the binary
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end

    # Verify the installation
    test do
      system "#{bin}/axelard", "version"
    end
  end
end
