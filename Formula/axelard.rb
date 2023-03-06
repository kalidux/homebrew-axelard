class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.32.2"

  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-#{Hardware::CPU.arch}-v#{version}.zip"
  sha256 case Hardware::CPU.arch
         when :arm64
           "f94d1d0a37e745a0f6c8a416d3c3dd3be0f3a2af1a0e423e2d1e872f7787fbb8"
         when :x86_64
           "74de0c905a3525d719d156f5c67f5e13c5f529d7db9cbf6dd2067c8e4f4b3c4d"
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
