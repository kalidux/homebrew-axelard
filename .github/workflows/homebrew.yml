class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.32.2"

  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-#{Hardware::CPU.arch}-v#{version}.zip"
  sha256 case Hardware::CPU.arch
         when :arm64
           "a943d7c4373df3b1c3f1d9b08f2b319cba722e44bbbe39d6e798c6d8a15011da"
         when :x86_64
           "8c6f728974def69b48ba065d0d13b53cc0eb183cc17c44b9d62c0f514ca61f2c"
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
