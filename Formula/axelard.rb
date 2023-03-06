class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.32.2"

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end

    # Download the SHA256 checksum for the release
    sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.sha256"
    sha256 = `curl -sSL #{sha256_url} | cut -d " " -f 1`
    raise "Failed to retrieve SHA256 checksum" if sha256.empty?

    # Download the release archive
    system "curl -sSL #{url} -o axelard.zip"
    # Verify the SHA256 checksum of the downloaded release
    system "echo \"#{sha256}  axelard.zip\" | shasum -a 256 --check"
    # Extract the archive
    system "unzip -q axelard.zip"
    # Install the binary
    bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
