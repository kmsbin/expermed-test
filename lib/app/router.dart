import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/ui/views/auth/sign_in/sign_in.view.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/update/update_medical_examination.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'domain/entities/medical_examination.dart';
import 'ui/views/auth/sign_up/sign_up.view.dart';
import 'ui/views/medical_examinations/agenda/medical_examination.view.dart';
import 'ui/views/medical_examinations/create/create_medical_examination.view.dart';
import 'ui/views/medical_examinations/info/info_medical_examination.view.dart';

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
    ),
    GoRoute(
      path: '/update-medical-examination',
      builder: (_, args) => UpdateMedicalExamination(args.extra as MedicalExaminationEntity),
    ),
    GoRoute(
      path: '/create-medical-examination',
      builder: (_, args) {
        final data = args.extra as (UserEntity, DateTime);
        return CreateMedicalExamination(data.$1, data.$2);
      }
    )
  ],
);