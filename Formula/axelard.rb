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
    sha256_arm64 "49d9f9c8c99aa61dce81a47db3fc5f7fc32ed634e1bebd5d5f06cb7aa5b98cf5"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256_amd64 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
      expected_sha256 = sha256_arm64
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
      expected_sha256 = sha256_amd64
    end

    # Verify the SHA256 checksum of the downloaded release
    output = shell_output("shasum -a 256 #{bin}/axelard")
    actual_sha256 = output.split.first
    raise "SHA256 mismatch: expected #{expected_sha256} but got #{actual_sha256}" if expected_sha256 != actual_sha256
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
