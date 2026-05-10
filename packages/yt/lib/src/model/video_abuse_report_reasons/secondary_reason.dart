import 'package:json_annotation/json_annotation.dart';

part 'secondary_reason.g.dart';

@JsonSerializable()
class SecondaryReason {
  final String id;
  final String label;

  SecondaryReason({
    required this.id,
    required this.label,
  });

  factory SecondaryReason.fromJson(Map<String, dynamic> json) =>
      _$SecondaryReasonFromJson(json);

  Map<String, dynamic> toJson() => _$SecondaryReasonToJson(this);
}