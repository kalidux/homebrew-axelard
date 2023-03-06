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

  # Define the SHA256 checksum of the release archive
  sha256_arm64 = "51d0965b71c8b40878a64dfc1d7195482f83cd8a0de585b41d262b3c3c4658c6"
  sha256_amd64 = "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
      sha256 = sha256_arm64
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
      sha256 = sha256_amd64
    end

    # Verify the SHA256 checksum of the downloaded release
    system "echo '#{sha256}  #{bin}/axelard.zip' | shasum -a 256 -c"

    # Remove the .zip extension from the binary file
    mv "#{bin}/axelard-darwin-*", "#{bin}/axelard"

    # Make the binary executable
    chmod "+x", "#{bin}/axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
