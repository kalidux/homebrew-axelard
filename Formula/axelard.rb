class Axelard < Formula
  desc "The Axelar Network Core Daemon"
  homepage "https://github.com/axelarnetwork/axelar-core"
  license "Apache-2.0"

  option "without-version", "Install the latest version"

  if build.without?("version")
    url "https://github.com/axelarnetwork/axelar-core/releases/latest/download/axelard-darwin-amd64-latest.zip"
    version "latest"
  else
    version "0.32.2"
    if Hardware::CPU.arm?
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-arm64-v#{version}.zip"
    else
      url "https://github.com/axelarnetwork/axelar-core/releases/download/v#{version}/axelard-darwin-amd64-v#{version}.zip"
    end
  end

  def install
    if build.without?("version")
      release_page = "https://github.com/axelarnetwork/axelar-core/releases/latest"
      release_info = `curl -sSL #{release_page}`
      url = release_info.match(%r{href="(https://github.com/axelarnetwork/axelar-core/releases/download/[^"]+/axelard-darwin-amd64-[^"]+.zip)"})[1]
      version = release_info.match(%r{href="https://github.com/axelarnetwork/axelar-core/releases/tag/([^"]+)"})[1]

      if Hardware::CPU.arm?
        url.sub!(/darwin-amd64/, "darwin-arm64")
      end

      odie "Failed to extract download URL" if url.nil?
      odie "Failed to extract version" if version.nil?

      sha256_url = url + ".sha256"
      sha256 = `curl -sSL #{sha256_url} | cut -d " " -f 1`
      raise "Failed to retrieve SHA256 checksum" if sha256.empty?
    else
      sha256_url = "#{url}.sha256"
      sha256 = `curl -sSL #{sha256_url} | cut -d " " -f 1`
      raise "Failed to retrieve SHA256 checksum" if sha256.empty?

      file_name = url.split("/")[-1]
      system "curl -sSL #{url} -o #{file_name}"
      system "shasum -a 256 -c <<<\"#{sha256}  #{file_name}\""
    end

    if Hardware::CPU.arm?
      bin.install "axelard-darwin-arm64-v#{version}" => "axelard"
    else
      bin.install "axelard-darwin-amd64-v#{version}" => "axelard"
    end
  end

  test do
    system "#{bin}/axelard", "version"
  end
end
