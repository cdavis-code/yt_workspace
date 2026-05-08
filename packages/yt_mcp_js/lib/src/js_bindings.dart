/// Core JS bindings that wire up Node.js stdin/stdout as an MCP
/// [StreamChannel<String>] and launch the MCP server.
library;

import 'dart:async';
import 'dart:js_interop';

import 'package:stream_channel/stream_channel.dart';

import 'node_interop.dart';
import 'yt_mcp_server_js.dart';

// ---------------------------------------------------------------------------
// Debug logging helpers
// ---------------------------------------------------------------------------

bool get _debugEnabled {
  final val = getEnvVar('YT_MCP_DEBUG');
  return val == '1';
}

void _debugLog(String message) {
  if (_debugEnabled) {
    logError('[yt-mcp-js] $message');
  }
}

/// Entry point called from `lib/yt_mcp_js.dart`.
///
/// Sets up the MCP stdio transport over Node.js stdin/stdout,
/// then bootstraps the YouTube connection from environment variables.
Future<void> startServer() async {
  _debugLog('startServer() called');

  final channel = _createStdioChannel();
  _debugLog('stdio channel created');

  // Bootstrap YouTube connection in the background.
  unawaited(
    YtMcpServer.bootstrapFromEnv().catchError((Object e) {
      _debugLog('ERROR: YouTube bootstrap failed: $e');
    }),
  );

  // Keep the process alive until stdin closes.
  await channel.stream.drain<void>();
  _debugLog('stdin closed, exiting');
}

/// Creates a [StreamChannel<String>] that communicates over Node.js
/// stdin/stdout using newline-delimited JSON.
StreamChannel<String> _createStdioChannel() {
  final inputController = StreamController<String>();
  final outputController = StreamController<String>();

  _setupStdinReader(inputController);

  outputController.stream.listen((String message) {
    _debugLog('Writing to stdout: ${message.length} chars');
    process.stdout.write('$message\n'.toJS);
  });

  return StreamChannel<String>(inputController.stream, outputController.sink);
}

/// Sets up a listener on Node.js stdin that splits input on newlines
/// and adds each non-empty line as a complete JSON message.
void _setupStdinReader(StreamController<String> controller) {
  var buffer = '';

  _debugLog('Attaching stdin data listener');

  process.stdin.on(
    'data',
    ((JSAny chunk) {
      String data;
      if (chunk.isA<JSString>()) {
        data = (chunk as JSString).toDart;
      } else {
        final buf = chunk as JSObject;
        final toStr = buf.getProperty('toString'.toJS) as JSFunction;
        final result = toStr.callAsFunction(buf, 'utf8'.toJS) as JSString;
        data = result.toDart;
      }

      buffer += data;

      while (true) {
        final nlIndex = buffer.indexOf('\n');
        if (nlIndex == -1) break;

        var line = buffer.substring(0, nlIndex);
        if (line.endsWith('\r')) {
          line = line.substring(0, line.length - 1);
        }
        buffer = buffer.substring(nlIndex + 1);

        if (line.isEmpty) continue;

        _debugLog('Complete MCP message received (${line.length} chars)');
        controller.add(line);
      }
    }).toJS,
  );

  process.stdin.on(
    'end',
    (() {
      _debugLog('stdin ended');
      if (buffer.isNotEmpty) {
        final line = buffer.endsWith('\r')
            ? buffer.substring(0, buffer.length - 1)
            : buffer;
        if (line.isNotEmpty) {
          controller.add(line);
        }
      }
      controller.close();
    }).toJS,
  );
}
