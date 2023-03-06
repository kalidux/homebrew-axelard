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

  def install
    # Extract the downloaded archive
    system "unzip", "#{cached_download}", "-d", "#{buildpath}"

    # Get the sha256 value from the sha256 file
    sha256_file = if Hardware::CPU.arm?
                    "axelard-darwin-arm64-v#{version}.zip.sha256"
                  else
                    "axelard-darwin-amd64-v#{version}.zip.sha256"
                  end
    sha256 = File.read("#{buildpath}/#{sha256_file}").strip.split(" ").first

    # Verify the sha256 checksum of the downloaded release
    system "shasum", "-a", "256", "-c", "#{sha256_file}"

    # Install the binary
    if Hardware::CPU.arm?
      bin.install "#{buildpath}/axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "#{buildpath}/axelard-darwin-amd64-v#{version}" => "axelard"
    end
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
