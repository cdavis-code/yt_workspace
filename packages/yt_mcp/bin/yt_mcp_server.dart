/// Entry point for the YouTube MCP stdio server.
///
/// Delegates to the generated dispatcher in
/// `package:yt_mcp/src/yt_mcp_server.mcp.dart`, first calling
/// [YtMcpServer.bootstrapFromEnv] so YouTube credentials from the environment
/// are loaded before the server starts.
///
/// Usage:
///   dart run bin/yt_mcp_server.dart
///
/// Regenerate the MCP dispatcher with:
///   dart run build_runner build
library;

import 'dart:io' as io;

import 'package:dart_mcp/stdio.dart';
import 'package:yt_mcp/src/yt_mcp_server.dart';
import 'package:yt_mcp/src/yt_mcp_server.mcp.dart';

Future<void> main(List<String> args) async {
  await YtMcpServer.bootstrapFromEnv();
  final server = MCPServerWithTools(
    stdioChannel(input: io.stdin, output: io.stdout),
  );
  await server.done;
}
