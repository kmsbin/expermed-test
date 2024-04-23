import 'package:expermed_test/app/ui/views/auth/sign_in/sign_in.view.dart';
import 'package:expermed_test/app/ui/views/user_info/user_info.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'domain/entities/medical_examination.dart';
import 'ui/views/auth/sign_up/sign_up.view.dart';
import 'ui/views/medical_examinations/medical_examination.view.dart';

final goRouter = createGoRouter();

@visibleForTesting
GoRouter createGoRouter({String initialLocation = '/sign-in'}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (_, __) => const SignInView(key: Key('sign_in'),),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (_, __) => const SignUpView(key: Key('sign_up'),),
    ),
    GoRoute(
      path: '/medical-examinations',
      builder: (_, __) => const MedicalExaminationsView(key: Key('home'),),
    ),
    GoRoute(
      path: '/user-info',
      builder: (_, args) {
        final data = args.extra as MedicalExaminationEntity;
        return UserInfoView(data, key: Key('user_info_${data.id}'),);
      },
    )
  ],
);