import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/create/create_medical_examination.events.dart';

class CreateMedicalExaminationBloc extends Bloc<CreateExaminationEvent, CreateExaminationState> {
  CreateMedicalExaminationBloc() : super(EmptyExaminationState());
}