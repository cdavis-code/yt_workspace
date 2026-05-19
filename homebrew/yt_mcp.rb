# typed: false
# frozen_string_literal: true

# Homebrew formula for yt_mcp
# Install with: brew tap cdavis-code/yt && brew install yt-mcp
class YtMcp < Formula
  desc "MCP server for YouTube Data and Live Streaming APIs"
  homepage "https://github.com/cdavis-code/yt_workspace"
  version "2.2.6"
  license "MIT"

  # Stable release: downloaded as a source tarball from a GitHub Release
  url "https://github.com/cdavis-code/yt_workspace/archive/refs/tags/yt_mcp-v2.2.6.tar.gz"
  sha256 "PLACEHOLDER_SHA256"

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
