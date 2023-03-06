


class Axelard < Formula
            desc "axelard binary for darwin"
            homepage "https://axelar.network"
            url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2.zip"
            version "0.32.2"
            sha256 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
            def install
              bin.install "axelard"
            end
          end
