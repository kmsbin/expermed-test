import 'package:bloc/bloc.dart';

import 'update_medical_examination.events.dart';

class UpdateMedicalExaminationBloc extends Bloc<UpdateExaminationEvent, UpdateExaminationState> {
  UpdateMedicalExaminationBloc() : super(EmptyUpdateExaminationState());
}