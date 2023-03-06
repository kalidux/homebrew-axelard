class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

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
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
  end

  if Hardware::CPU.arm?
    sha256_arm64 = "7c9cf071172c5838d4012b1c052f23247d3c242fc8fb1fc97c9b15abdaa931e5"
    sha256 "#{sha256_arm64}--axelard-darwin-arm64-v#{version}.zip"
  else
    sha256_amd64 = "26c37d149a2142d2d68fcef583723c15cd05dcd49dd7dd98a15f70807f0b7a89"
    sha256 "#{sha256_amd64}--axelard-darwin-amd64-v#{version}.zip"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end

    # Download the SHA256 checksum for the release
    sha256_url = "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.sha256"
    sha256_output = `curl -sSL #{sha256_url}`

    # Extract the SHA256 checksum from the output
    sha256 = sha256_output[/(\h{64})/, 1]
    raise "Failed to retrieve SHA256 checksum" if sha256.nil?

    # Verify the SHA256 checksum of the downloaded release
    if Hardware::CPU.arm?
      system "shasum -a 256 -c <<<\"#{sha256}  #{bin}/axelard\""
    else
      system "echo \"#{sha256}  #{bin}/axelard\" | shasum -a 256 -c"
    end
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
