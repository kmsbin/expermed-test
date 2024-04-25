
import 'package:expermed_test/app/domain/entities/user_entity.dart';

sealed class UserCacheEvent {
  const UserCacheEvent();
}

final class GetUserCacheEvent extends UserCacheEvent {
  const GetUserCacheEvent();
}

sealed class UserCacheState {
  const UserCacheState();
}

final class EmptyUserCacheState extends UserCacheState {
  const EmptyUserCacheState();
}

final class LoadingUserCacheState extends UserCacheState {
  const LoadingUserCacheState();
}

final class FilledUserCacheState extends UserCacheState {
  final UserEntity userEntity;
  const FilledUserCacheState(this.userEntity);
}

final class FailedUserCacheState extends UserCacheState {
  final String message;
  const FailedUserCacheState(this.message);
}
