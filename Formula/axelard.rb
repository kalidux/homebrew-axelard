


class Axelard < Formula
            desc "axelard binary for darwin"
            homepage "https://axelar.network"
            url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2.zip"
            version "0.32.2"
            sha256 "2303ed69ee0486814e09554449292b0b3e50f61e57248143c0d24f349df33f1d"
            
            resource binary do
              url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2"
              sha256 "cac744649ea01b223a04d8916b6413f3fb504cc45585cade4f511e35fcc10f40"
            end

            def install
              resource(binary).stage { bin.install axelard }
              chmod 0755, #{bin}/axelard
            end
end
