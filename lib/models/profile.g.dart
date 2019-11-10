part of 'profile.dart';


Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    user: User.fromJson(json['user'] as Map<String,dynamic>),
    token: json['token'] as String,
    theme: json['updatedAt'] as num,
    cache: CacheConfig.fromJson(json['cache'] as Map<String,dynamic>),
    lastLogin: json['lastLogin'] as String,
    locale: json['locale'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'user': instance.user.toJson(),
  'token': instance.token,
  'theme': instance.theme,
  'cache': instance.cache.toJson(),
  'lastLogin': instance.lastLogin,
  'locale': instance.locale,
};