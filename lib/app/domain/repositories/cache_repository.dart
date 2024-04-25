import 'package:expermed_test/app/domain/entities/user_entity.dart';

abstract interface class CacheRepository {
  Future<void> saveUserEntity(UserEntity userEntity);
  Future<void> deleteUserEntity();
  Future<UserEntity?> getUserEntity();
}