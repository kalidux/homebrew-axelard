class Axelard < Formula
  desc "Official Axelar Network command-line interface (CLI)"
  homepage "https://axelar.network"
  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
  sha256 ""
  version "0.32.2"

  if build.with? "version"
    version = build.with?("version") ? build.with("version") : version
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    shasum_output = `curl -sSL https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip.sha256`
    sha256 shasum_output.split(" ").first
  else
    sha256 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
  end

  bottle :unneeded

  def install
    bin.install "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
