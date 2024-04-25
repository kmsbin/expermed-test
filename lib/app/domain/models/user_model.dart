import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String pass;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.pass,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) => _$UserModelFromJson(jsonData);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      pass: entity.pass,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      pass: pass,
    );
  }
}