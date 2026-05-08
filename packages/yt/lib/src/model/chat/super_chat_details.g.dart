// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_chat_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperChatDetails _$SuperChatDetailsFromJson(Map<String, dynamic> json) =>
    SuperChatDetails(
      amountMicros: (json['amountMicros'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      amountDisplayString: json['amountDisplayString'] as String?,
      userComment: json['userComment'] as String?,
      tier: (json['tier'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SuperChatDetailsToJson(SuperChatDetails instance) =>
    <String, dynamic>{
      'amountMicros': instance.amountMicros,
      'currency': instance.currency,
      'amountDisplayString': instance.amountDisplayString,
      'userComment': instance.userComment,
      'tier': instance.tier,
    };
