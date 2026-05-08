// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_sticker_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperStickerDetails _$SuperStickerDetailsFromJson(Map<String, dynamic> json) =>
    SuperStickerDetails(
      superStickerMetadata: json['superStickerMetadata'] == null
          ? null
          : SuperStickerMetadata.fromJson(
              json['superStickerMetadata'] as Map<String, dynamic>,
            ),
      amountMicros: (json['amountMicros'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      amountDisplayString: json['amountDisplayString'] as String?,
      tier: (json['tier'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SuperStickerDetailsToJson(
  SuperStickerDetails instance,
) => <String, dynamic>{
  'superStickerMetadata': instance.superStickerMetadata?.toJson(),
  'amountMicros': instance.amountMicros,
  'currency': instance.currency,
  'amountDisplayString': instance.amountDisplayString,
  'tier': instance.tier,
};
