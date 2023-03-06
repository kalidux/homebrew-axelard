class Axelard < Formula
  desc Axelard binary for darwin
  homepage https://axelar.network
  url https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2.zip
  version 0.32.2
  sha256 2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d

  resource axelard do
    url https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2
    sha256 cac744649ea01b223a04d8916b6413f3fb504cc45585cade4f511e35fcc10f40
  end

  def install
    resource(axelard).stage do
      bin.install axelard
    end
end
