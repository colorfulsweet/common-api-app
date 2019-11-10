part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'username': instance.username,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
