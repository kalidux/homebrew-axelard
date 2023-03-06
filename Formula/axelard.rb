class Axelard < Formula
  desc "Axelar Network Client"
  homepage "https://github.com/axelarnetwork/axelar-core"
  url "https://github.com/axelarnetwork/axelar-core/releases/download/#{version}/axelard-darwin-#{arch}-#{version}.zip"
  version "0.31.2"
  sha256 "abc123..."

  option "with-version=", "Specify the version of axelard to install (e.g. --with-version=0.31.2)"

  def install
    bin.install "axelard"
  end

  def version
    if build.with? "version"
      build.with?("version")
    else
      "v0.31.2"
    end
  end

  def arch
    Hardware::CPU.arm? ? "arm64" : "amd64"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
