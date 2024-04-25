import 'dart:convert';

import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/models/user_model.dart';
import 'package:expermed_test/app/domain/repositories/cache_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _userEntityCacheKey = 'user_entity';

@Injectable(as: CacheRepository)
final class SharedPreferencesCacheRepository implements CacheRepository {
  @override
  Future<void> deleteUserEntity() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userEntityCacheKey);
  }

  @override
  Future<UserEntity?> getUserEntity() async {
    final prefs = await SharedPreferences.getInstance();

    final userModelMap = prefs.getString(_userEntityCacheKey);
    if (userModelMap == null) return null;

    return UserModel
      .fromJson(jsonDecode(userModelMap))
      .toEntity();
  }

  @override
  Future<void> saveUserEntity(UserEntity userEntity) async {
    final model = UserModel.fromEntity(userEntity);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userEntityCacheKey, jsonEncode(model.toJson()));
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}