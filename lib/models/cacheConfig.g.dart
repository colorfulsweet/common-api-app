part of 'cacheConfig.dart';

CacheConfig _$CacheConfigFromJson(Map<String, dynamic> json) {
  return CacheConfig(
    enable: json['enable'] as bool,
    maxAge: json['maxAge'] as num,
    maxCount: json['maxCount'] as num,
  );
}

Map<String, dynamic> _$CacheConfigToJson(CacheConfig instance) => <String, dynamic>{
  'enable': instance.enable,
  'maxAge': instance.maxAge,
  'maxCount': instance.maxCount,
};
