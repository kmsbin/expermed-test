import 'package:dio/dio.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/models/user_model.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/infra/constants/api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
final class AuthRepositoryApi implements AuthRepository {
  static const _defaultTimeout = Duration(seconds: 30);

  final _dio = Dio(
    BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: _defaultTimeout,
      sendTimeout: _defaultTimeout,
    ),
  );

  @override
  Future<UserEntity> sendSignInRequest(String email, String password) async {
    try {
      final result = await _dio.get<List>('/user', queryParameters: {
        'email': email,
        'pass': password,
      });
      final userInfoMap = result.data?.firstOrNull as Map?;
      if (userInfoMap == null) {
        throw const FormatException('Resposta do servidor não esperada');
      }

      return UserModel
        .fromJson(userInfoMap.cast())
        .toEntity();
    } on FormatException {
      throw const FailedSignInException('Usuário e senha inválidos');
    } on DioException catch (e) {
      if (e.response?.data == 'Not found') {
        throw const FailedSignInException('Usuário e senha inválidos');
      }
      rethrow;
    } catch(e) {
      rethrow;
    }
  }

  @override
  Future<void> sendSignUpRequest(String email, String password, String name) {
    // TODO: implement sendSignUpRequest
    throw UnimplementedError();
  }


}