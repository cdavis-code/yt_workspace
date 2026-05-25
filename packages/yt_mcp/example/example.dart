/// Example demonstrating how to run the yt_mcp server.
///
/// ## Prerequisites
///
/// 1. **For read-only access**: Set `YT_API_KEY` environment variable
/// 2. **For full access**: Set `YT_CLIENT_SECRETS_FILE` and `YT_ACCESS_TOKENS_FILE`
///
/// ## Running
///
/// ```sh
/// # From source
/// dart run bin/yt_mcp_server.dart
///
/// # Or use the globally activated command
/// yt-mcp
/// ```
///
/// ## Configuration
///
/// Create a `.env` file in your working directory or set environment variables:
///
/// ```bash
/// # API Key (read-only)
/// export YT_API_KEY="your-api-key"
///
/// # OR OAuth (full access)
/// export YT_CLIENT_SECRETS_FILE="/path/to/client_secrets.json"
/// export YT_ACCESS_TOKENS_FILE="/path/to/access_tokens.json"
/// ```
///
/// The server uses stdio transport for MCP communication with AI assistants.
library;

import 'dart:io';

void main(List<String> args) {
  print('yt_mcp Example');
  print('==============\n');
  print('This package is an MCP server for YouTube APIs.\n');
  print('To run the server:');
  print('  dart run bin/yt_mcp_server.dart\n');
  print('Or if globally activated:');
  print('  yt-mcp\n');
  print('Configuration:');
  print('  1. Create a .env file (see .env.example)');
  print('  2. Set YT_API_KEY for read-only access');
  print(
    '  3. OR set YT_CLIENT_SECRETS_FILE + YT_ACCESS_TOKENS_FILE for OAuth\n',
  );
  print('Connect with MCP-compatible AI assistants:');
  print('  - Qoder');
  print('  - Claude Desktop');
  print('  - VS Code with MCP extension\n');
  print('See README.md for full documentation.');

  // Exit with success
  exit(0);
}
