part of 'profile.dart';


Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    user: User.fromJson(json['user'] as Map<String,dynamic>),
    token: json['token'] as String,
    theme: json['updatedAt'] as num,
    lastLogin: json['lastLogin'] as String,
    locale: json['locale'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'user': instance.user != null ? instance.user.toJson() : null,
  'token': instance.token,
  'theme': instance.theme,
  'lastLogin': instance.lastLogin,
  'locale': instance.locale,
};