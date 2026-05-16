// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_content_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityContentDetails _$ActivityContentDetailsFromJson(
  Map<String, dynamic> json,
) => ActivityContentDetails(
  upload: json['upload'] == null
      ? null
      : ActivityContentUpload.fromJson(json['upload'] as Map<String, dynamic>),
  like: json['like'] == null
      ? null
      : ActivityContentResource.fromJson(json['like'] as Map<String, dynamic>),
  favorite: json['favorite'] == null
      ? null
      : ActivityContentResource.fromJson(
          json['favorite'] as Map<String, dynamic>,
        ),
  comment: json['comment'] == null
      ? null
      : ActivityContentResource.fromJson(
          json['comment'] as Map<String, dynamic>,
        ),
  subscription: json['subscription'] == null
      ? null
      : ActivityContentResource.fromJson(
          json['subscription'] as Map<String, dynamic>,
        ),
  playlistItem: json['playlistItem'] == null
      ? null
      : ActivityContentPlaylistItem.fromJson(
          json['playlistItem'] as Map<String, dynamic>,
        ),
  recommendation: json['recommendation'] == null
      ? null
      : ActivityContentRecommendation.fromJson(
          json['recommendation'] as Map<String, dynamic>,
        ),
  social: json['social'] == null
      ? null
      : ActivityContentSocial.fromJson(json['social'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActivityContentDetailsToJson(
  ActivityContentDetails instance,
) => <String, dynamic>{
  'upload': instance.upload?.toJson(),
  'like': instance.like?.toJson(),
  'favorite': instance.favorite?.toJson(),
  'comment': instance.comment?.toJson(),
  'subscription': instance.subscription?.toJson(),
  'playlistItem': instance.playlistItem?.toJson(),
  'recommendation': instance.recommendation?.toJson(),
  'social': instance.social?.toJson(),
};

ActivityContentUpload _$ActivityContentUploadFromJson(
  Map<String, dynamic> json,
) => ActivityContentUpload(videoId: json['videoId'] as String?);

Map<String, dynamic> _$ActivityContentUploadToJson(
  ActivityContentUpload instance,
) => <String, dynamic>{'videoId': instance.videoId};

ActivityContentResource _$ActivityContentResourceFromJson(
  Map<String, dynamic> json,
) => ActivityContentResource(
  resourceId: json['resourceId'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ActivityContentResourceToJson(
  ActivityContentResource instance,
) => <String, dynamic>{'resourceId': instance.resourceId};

ActivityContentPlaylistItem _$ActivityContentPlaylistItemFromJson(
  Map<String, dynamic> json,
) => ActivityContentPlaylistItem(
  resourceId: json['resourceId'] as Map<String, dynamic>?,
  playlistId: json['playlistId'] as String?,
  playlistItemId: json['playlistItemId'] as String?,
);

Map<String, dynamic> _$ActivityContentPlaylistItemToJson(
  ActivityContentPlaylistItem instance,
) => <String, dynamic>{
  'resourceId': instance.resourceId,
  'playlistId': instance.playlistId,
  'playlistItemId': instance.playlistItemId,
};

ActivityContentRecommendation _$ActivityContentRecommendationFromJson(
  Map<String, dynamic> json,
) => ActivityContentRecommendation(
  resourceId: json['resourceId'] as Map<String, dynamic>?,
  reason: json['reason'] as String?,
  seedResourceId: json['seedResourceId'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ActivityContentRecommendationToJson(
  ActivityContentRecommendation instance,
) => <String, dynamic>{
  'resourceId': instance.resourceId,
  'reason': instance.reason,
  'seedResourceId': instance.seedResourceId,
};

ActivityContentSocial _$ActivityContentSocialFromJson(
  Map<String, dynamic> json,
) => ActivityContentSocial(
  type: json['type'] as String?,
  resourceId: json['resourceId'] as Map<String, dynamic>?,
  author: json['author'] as String?,
  referenceUrl: json['referenceUrl'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ActivityContentSocialToJson(
  ActivityContentSocial instance,
) => <String, dynamic>{
  'type': instance.type,
  'resourceId': instance.resourceId,
  'author': instance.author,
  'referenceUrl': instance.referenceUrl,
  'imageUrl': instance.imageUrl,
};
