import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';
import 'package:yt/src/util/emoji_formatter.dart';

import 'keyword.dart';

part 'dialog.g.dart';

class DialogLoader {
  static List<Dialog> fromYamlFile(String path) {
    final jsonString = json.encode(loadYaml(File(path).readAsStringSync()));

    final jsonList = json.decode(jsonString) as List;

    return jsonList
        .map((element) => Dialog.fromJson(element.cast<String, dynamic>()))
        .toList();
  }
}

@JsonSerializable(explicitToJson: true)
class Dialog {
  final String name;
  final List<String> answers;
  final Keyword keyword;

  Dialog({required this.name, required this.answers, required this.keyword});

  String get answer => EmojiFormatter.format((answers..shuffle()).first);

  factory Dialog.fromJson(Map<String, dynamic> json) => _$DialogFromJson(json);

  Map<String, dynamic> toJson() => _$DialogToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
