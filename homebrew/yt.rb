# typed: false
# frozen_string_literal: true

# Homebrew formula for yt_cli
# Install with: brew tap cdavis-code/yt && brew install yt
class Yt < Formula
  desc "A CLI tool for the YouTube Data, Live Streaming, and Analytics APIs"
  homepage "https://github.com/cdavis-code/yt_workspace"
  version "2.2.6"
  license "MIT"

  # Stable release: downloaded as a source tarball from a GitHub Release
  url "https://github.com/cdavis-code/yt_workspace/archive/refs/tags/yt_cli-v2.2.6.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  # Development / HEAD install: brew install --head yt
  head "https://github.com/cdavis-code/yt_workspace.git", branch: "main"

  depends_on "dart-sdk" => :build

  def install
    cd "packages/yt_cli" do
      # Remove workspace resolution to build standalone (avoids needing the full monorepo)
      inreplace "pubspec.yaml", "resolution: workspace\n", ""

      system "dart", "pub", "get"

      # Compile the CLI entrypoint to a native binary
      system "dart", "compile", "exe",
             "bin/yt.dart",
             "-o", "yt"

      bin.install "yt"
    end
  end

  test do
    assert_match "yt", shell_output("#{bin}/yt --help")
  end
end
