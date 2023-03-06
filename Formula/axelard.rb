class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  
  # User can specify the version
  option "with-version=", "Specify the version of axelard to install"

  # Set the default version to the latest release
  latest_release = `curl --silent "https://api.github.com/repos/axelarnetwork/axelar-core/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'`
  version "#{latest_release}"
  
  # Override the version if the user specified one
  if build.with? "version"
    version "#{build.with("version")}"
  end

  if Hardware::CPU.arm?
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
  else
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
  end
  
  # Use the 'get_sha256_checksum' function to retrieve the SHA256 checksum
  sha256 get_sha256_checksum(url)

  def install
    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end
    
    # Verify the SHA256 checksum of the downloaded release
    file_name = Hardware::CPU.arm? ? "axelard-darwin-arm64-v#{version}" : "axelard-darwin-amd64-v#{version}"
    system "echo \"#{sha256}  #{file_name}.zip\" | shasum -a 256 --check"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
