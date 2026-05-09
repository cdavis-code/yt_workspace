import 'package:json_annotation/json_annotation.dart';

part 'level_details.g.dart';

@JsonSerializable()
class LevelDetails {
  @JsonKey(name: 'displayName')
  final String displayName;

  LevelDetails({required this.displayName});

  factory LevelDetails.fromJson(Map<String, dynamic> json) =>
      _$LevelDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDetailsToJson(this);
}
