
import 'package:json_annotation/json_annotation.dart';

part 'request_entity.g.dart';

@JsonSerializable()
class Request {
  @JsonKey()
  String? id;
  @JsonKey()
  String? title;
  @JsonKey()
  String? content;
  @JsonKey()
  DateTime? time;

  Request({this.id, this.title, this.content, this.time});

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}