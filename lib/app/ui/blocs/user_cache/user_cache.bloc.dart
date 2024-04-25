import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/domain/repositories/cache_repository.dart';
import 'package:expermed_test/injector.dart';
import 'package:injectable/injectable.dart';

import 'user_cache.events.dart';

@Injectable()
class UserCacheBloc extends Bloc<UserCacheEvent, UserCacheState> {
  final _cacheRepository = getIt.get<CacheRepository>();

  UserCacheBloc() : super(const EmptyUserCacheState()){
    on(_fetchUser);
    add(const GetUserCacheEvent());
  }

  Future<void> _fetchUser(UserCacheEvent event, Emitter<UserCacheState> emit) async {
    try {
      emit(const LoadingUserCacheState());
      final user = await _cacheRepository.getUserEntity();
      if (user == null) {
        emit(const EmptyUserCacheState());
        return;
      }

      emit(FilledUserCacheState(user));
    } catch (e) {
      emit(const FailedUserCacheState('Algo inesperado aconteceu ao buscar o usuário'));
    }
  }
}