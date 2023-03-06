class Axelard < Formula
  desc "Axelar Core - A decentralized interoperability network for cross-chain communication"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"
  
  version "0.32.2"
  url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}"
  sha256 "28b0fbfc838e5c49ca0451c2d2d40a0e0cfe4409f1a2d338e67fb0a92a0b69c7"
  
  # Generate all possible versions using bash script
  bash_script = <<~EOS
    versions=($(curl -s https://api.github.com/repos/axelarnetwork/axelar-core/releases/latest | grep "tag_name" | awk '{print $2}' | sed 's/"//g' | sed 's/,//g'))
    for version in "${versions[@]}"; do
      url="https://github.com/axelarnetwork/axelar-core/releases/download/${version}/axelard-darwin-amd64-${version}"
      sha256=$(curl -sL "${url}" | shasum -a 256 | awk '{print $1}')
      echo "  bottle do"
      echo "    root_url 'https://github.com/axelarnetwork/axelar-core/releases/download/${version}'"
      echo "    sha256 '${sha256}'"
      echo "    url '${url}'"
      echo "  end"
    done
  EOS
  
  # Parse the bash script output and append it to the formula
  bottle do
    root_url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}"
    sha256 "28b0fbfc838e5c49ca0451c2d2d40a0e0cfe4409f1a2d338e67fb0a92a0b69c7"
    url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}"
  end
  eval `#{bash_script}`
  
  def install
    bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
