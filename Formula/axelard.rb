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

  # Set the sha256 checksum for the downloaded release
  if Hardware::CPU.arm?
    sha256 "ca1ab7ce0d3e0f7d1cb2b33e7b3f9d9b7cbf5e06f5a47ee1f16504af7b0d0f43"
  else
    sha256 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end

    # Verify the SHA256 checksum of the downloaded release
    system "shasum -a 256 -c <<<\"#{sha256}  #{bin}/axelard\""
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
