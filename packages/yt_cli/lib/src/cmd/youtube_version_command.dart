import 'package:args/command_runner.dart';
import 'package:yt/meta.dart';

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
