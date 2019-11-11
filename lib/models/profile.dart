import 'package:json_annotation/json_annotation.dart';
import "user.dart";

part 'profile.g.dart';

@JsonSerializable()
class Profile {
    Profile({this.user, this.token, this.theme, this.lastLogin, this.locale});

    User user;
    String token;
    num theme;
    String lastLogin;
    String locale;

    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);

}
