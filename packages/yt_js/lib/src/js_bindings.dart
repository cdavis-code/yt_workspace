/// JS-interop bindings that expose a minimal `yt` surface to JavaScript.
///
/// The TypeScript wrapper layer (src/index.ts) consumes these to provide a
/// typed, Promise-based API for YouTube Data and Live Streaming operations.
library;

import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:loggy/loggy.dart';
import 'package:yt/yt.dart';

@JS('globalThis')
external JSObject get _globalThis;

/// Installs the interop namespace on `globalThis.YtJs`.
/// Called once from the dart2js `main()`.
void install() {
  final ns = JSObject();
  ns.setProperty('withApiKey'.toJS, _withApiKey.toJS);
  ns.setProperty('withOAuth'.toJS, _withOAuth.toJS);
  ns.setProperty('version'.toJS, '2.2.6'.toJS);
  _globalThis.setProperty('YtJs'.toJS, ns);
}

/// Creates a Yt instance with an API key and returns a JS handle.
///
/// JS signature:
///   `YtJs.withApiKey(apiKey, logLevel?)`
/// Returns: `Promise<YtJsHandle>`.
JSPromise<JSObject> _withApiKey(JSString apiKey, JSString? logLevel) {
  final future = () async {
    final logOpts = _parseLogLevel(logLevel?.toDart);
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: false),
      logOptions: logOpts,
    );

    final yt = Yt.withApiKey(apiKey.toDart);
    return _wrap(yt);
  }();

  return future.toJS;
}

/// Creates a Yt instance with OAuth and returns a JS handle.
///
/// JS signature:
///   `YtJs.withOAuth(logLevel?)`
/// Returns: `Promise<YtJsHandle>`.
JSPromise<JSObject> _withOAuth(JSString? logLevel) {
  final future = () async {
    final logOpts = _parseLogLevel(logLevel?.toDart);
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: false),
      logOptions: logOpts,
    );

    final yt = Yt.withOAuth(logOptions: logOpts);
    return _wrap(yt);
  }();

  return future.toJS;
}

LogOptions _parseLogLevel(String? level) {
  switch (level) {
    case 'all':
      return const LogOptions(LogLevel.all);
    case 'debug':
      return const LogOptions(LogLevel.debug);
    case 'info':
      return const LogOptions(LogLevel.info);
    case 'warning':
      return const LogOptions(LogLevel.warning);
    case 'error':
      return const LogOptions(LogLevel.error);
    default:
      return const LogOptions(LogLevel.error, stackTraceLevel: LogLevel.off);
  }
}

/// Wraps a [Yt] instance in an opaque JS object exposing only the methods
/// the TypeScript layer needs.
JSObject _wrap(Yt yt) {
  final handle = JSObject();

  // Channels
  handle.setProperty(
    'channelsList'.toJS,
    ((
          JSString? part,
          JSString? id,
          JSString? forUsername,
          JSNumber? maxResults,
        ) {
          final future = () async {
            final response = await yt.channels.list(
              part: part?.toDart ?? 'snippet',
              id: id?.toDart,
              forUsername: forUsername?.toDart,
              maxResults: maxResults?.toDartInt ?? 5,
            );
            return _dartToJs(response.toJson()) ?? JSObject();
          }();
          return future.toJS;
        })
        .toJS,
  );

  // Search
  handle.setProperty(
    'searchList'.toJS,
    ((JSString q, JSString? part, JSString? type, JSNumber? maxResults) {
      final future = () async {
        final response = await yt.search.list(
          q: q.toDart,
          part: part?.toDart ?? 'snippet',
          type: type?.toDart,
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // Videos
  handle.setProperty(
    'videosList'.toJS,
    ((JSString? id, JSString? chart, JSString? part, JSNumber? maxResults) {
      final future = () async {
        final response = await yt.videos.list(
          id: id?.toDart,
          chart: chart?.toDart,
          part: part?.toDart ?? 'snippet',
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // Playlists
  handle.setProperty(
    'playlistsList'.toJS,
    ((JSString? channelId, JSString? id, JSString? part, JSNumber? maxResults) {
      final future = () async {
        final response = await yt.playlists.list(
          channelId: channelId?.toDart,
          id: id?.toDart,
          part: part?.toDart ?? 'snippet',
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // Close
  handle.setProperty(
    'close'.toJS,
    (() {
      yt.close();
      return JSObject();
    }).toJS,
  );

  return handle;
}

// -------------------------------------------------------------------------
// JSON <-> JS value conversion (round-trip via JSON for fidelity)
// -------------------------------------------------------------------------

JSObject get _json => _globalThis.getProperty<JSObject>('JSON'.toJS);

/// Converts a plain Dart value (from `dart:convert` JSON) to a JS value.
JSAny? _dartToJs(Object? value) {
  if (value == null) return null;
  final encoded = jsonEncode(value);
  return _json.callMethod<JSAny?>('parse'.toJS, encoded.toJS);
}
