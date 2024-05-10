import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;

  String email;
  String password;

  String firstName;
  String secondName;

  User({
    required this.uid,
    required this.email,
    required this.password,
    required this.firstName,
    required this.secondName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
