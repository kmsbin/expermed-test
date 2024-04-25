// Mocks generated by Mockito 5.4.4 from annotations
// in expermed_test/test/app/domain/usecases/auth_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:expermed_test/app/domain/entities/user_entity.dart' as _i2;
import 'package:expermed_test/app/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserEntity_0 extends _i1.SmartFake implements _i2.UserEntity {
  _FakeUserEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserEntity> sendSignInRequest(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendSignInRequest,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.UserEntity>.value(_FakeUserEntity_0(
          this,
          Invocation.method(
            #sendSignInRequest,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.UserEntity>);

  @override
  _i4.Future<void> sendSignUpRequest(
    String? email,
    String? password,
    String? name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendSignUpRequest,
          [
            email,
            password,
            name,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
