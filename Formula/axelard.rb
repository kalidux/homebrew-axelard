class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  # Define sha256_url as an instance variable
  sha256_url = ""

  # Allow the user to specify a version
  option "with-version=", "Specify the version of axelard to install"

  # Default to the latest version if none is specified
  if build.with? "version"
    version "#{build.with("version")}"
  else
    version "0.32.2"
  end

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip.sha256"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip.sha256"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end

    # Verify the SHA256 checksum of the downloaded release
    sha256_output = `curl -sSL #{sha256_url} | awk '{print $1}'`
    sha256 = sha256_output.chomp

    # Verify the SHA256 checksum of the downloaded release
    system "shasum -a 256 -c <<<\"#{sha256}  #{bin}/axelard\""
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
