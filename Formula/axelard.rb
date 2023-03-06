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
    sha256_output = `curl -sSL #{url} | shasum -a 256`
    sha256 = sha256_output.split.first
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    sha256_output = `curl -sSL #{url} | shasum -a 256`
    sha256 = sha256_output.split.first
  end

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
