


class Axelard < Formula
            desc "axelard binary for darwin"
            homepage "https://axelar.network"
            url "https://github.com/axelarnetwork/axelar-core/releases/download/v0.32.2/axelard-darwin-amd64-v0.32.2"
            version "0.32.2"
            sha256 "cac744649ea01b223a04d8916b6413f3fb504cc45585cade4f511e35fcc10f40"    
         
  def install
    bin.install "axelard-darwin-amd64-v0.32.2"
    chmod 0755, "#{bin}/axelard"
  end

  test do
    system "#{bin}/axelard", "--version"
  end
            
            
end
