import 'package:args/command_runner.dart';
import 'package:yt_cli/meta.dart';

/// Display the yt_cli package name and version information.
///
/// This command is useful for verifying the installed version
/// and troubleshooting compatibility issues.
class YoutubeVersionCommand extends Command<void> {
  @override
  String get description => 'Display the package name and version';

  @override
  String get name => 'version';

  @override
  void run() async {
    print('${pubSpec['name']} v${pubSpec['version']}');
  }
}
