class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  # Allow user to input version
  option "with-version=", "Specify the version to install"

  # Set default version
  default_version = "0.32.2"

  version (ARGV.value("with-version") || default_version)

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
  end

  def install
    # Download the SHA256 checksum for the release
    sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.sha256"
    sha256 = curl_output(sha256_url).split(" ").first
    raise "Failed to retrieve SHA256 checksum" if sha256.empty?

    # Verify the SHA256 checksum of the downloaded release
    file_name = Hardware::CPU.arm? ? "axelard-darwin-arm64-v#{version}" : "axelard-darwin-amd64-v#{version}"
    system "echo \"#{sha256}  #{file_name}.zip\" | shasum -a 256 --check"

    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end
  end

  def curl_output(url)
    output = `curl -sSL #{url}`
    raise "Failed to fetch #{url}" if $?.exitstatus != 0
    output
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
