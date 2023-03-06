class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.31.2"

  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-#{Hardware::CPU.arch}-v#{version}.zip"
  sha256 case Hardware::CPU.arch
         when :arm64
           "45f0b4df4f4a4d8a502b75f9b91f3ab3a0e8f0afca74e5d15f50fa7d746292dd"
         when :x86_64
           "279b61fbb6ec20130b96efc6f3d3b131e96caac9b145be98d02547e6d20496e8"
         else
           # This should never happen, but just in case.
           raise "Unsupported architecture"
         end

  def install
    bin.install "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
