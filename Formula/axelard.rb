class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  
  # Allow the user to specify the version
  # Example usage: brew install axelard --version=0.32.2
  # Default version is 0.32.2
  version ENV.fetch("HOMEBREW_FORMULA_VERSION", "0.32.2")
  
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
    sha256 = curl_output(sha256_url).split.first
    raise "Failed to retrieve SHA256 checksum" if sha256.empty?

    # Verify the SHA256 checksum of the downloaded release
    file_name = Hardware::CPU.arm? ? "axelard-darwin-arm64-v#{version}" : "axelard-darwin-amd64-v#{version}"
    system "echo \"#{sha256}  #{file_name}.zip\" | shasum -a 256 --check"
  end

  test do
    system "#{bin}/axelard", "version"
  end

  private

  def curl_output(url)
    curl_args = ["-sSL", url]
    IO.popen(["curl", *curl_args], &:read)
  end
end
