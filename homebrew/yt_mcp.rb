# typed: false
# frozen_string_literal: true

# Homebrew formula for yt_mcp
# Install with: brew tap cdavis-code/yt && brew install yt-mcp
# Note: 'yt-mcp' is an alias that points to the 'yt_mcp' formula
class YtMcp < Formula
  desc "MCP server for YouTube Data and Live Streaming APIs"
  homepage "https://github.com/cdavis-code/yt_workspace"
  version "2.2.6"
  license "MIT"

  # Stable release: downloaded as a source tarball from a GitHub Release
  # Note: Update this URL and SHA256 when tagging a release
  url "https://github.com/cdavis-code/yt_workspace/archive/refs/heads/main.tar.gz"
  sha256 "86227898d419b674c17c2fd570d15a9cb027b01cd5a2ea5756b5dd3ec8f35a8a"

  # Development / HEAD install: brew install --head yt-mcp
  head "https://github.com/cdavis-code/yt_workspace.git", branch: "main"

  depends_on "dart-sdk" => :build

  def install
    cd "packages/yt_mcp" do
      # Remove workspace resolution to build standalone (avoids needing the full monorepo)
      inreplace "pubspec.yaml", "resolution: workspace\n", ""

      system "dart", "pub", "get"

      # Compile the MCP server entrypoint to a native binary
      system "dart", "compile", "exe",
             "bin/yt_mcp_server.dart",
             "-o", "yt_mcp"

      bin.install "yt_mcp"
    end
  end

  test do
    assert_match "yt_mcp", shell_output("#{bin}/yt_mcp --help")
  end
end
