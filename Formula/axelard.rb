class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  version "0.32.2"

  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-#{Hardware::CPU.arch}-v#{version}.zip"
  sha256 case Hardware::CPU.arch
         when :arm64
           "1a58c2d2b38ca3309e7f33bda75d91394c416835437a1d2327cfedd59a2c56e8"
         when :x86_64
           "3d70df1b6566ca2e7d4753276ce14d6b0c6f9ee6e81dc21b71d0c0eb33470a53"
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
