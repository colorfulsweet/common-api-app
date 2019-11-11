part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['_id'] as String,
    username: json['username'] as String,
    realname: json['realname'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  '_id': instance._id,
  'username': instance.username,
  'realname': instance.realname,
};
