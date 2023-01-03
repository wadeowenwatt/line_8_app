import 'package:json_annotation/json_annotation.dart';

part 'new_user_entity.g.dart';

@JsonSerializable()
class User {
  @JsonKey()
  String? id;
  @JsonKey()
  String? title;
  @JsonKey()
  String? firstName;
  @JsonKey()
  String? lastName;
  @JsonKey()
  String? url;

  User({this.id, this.title, this.firstName, this.lastName, this.url});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
