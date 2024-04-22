import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInfoView extends StatelessWidget {
  final timeFormatter = DateFormat('HH:mm').format;
  final MedicalExaminationEntity serviceData;

  UserInfoView(this.serviceData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f2733),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${timeFormatter(serviceData.dateTime)} - ${serviceData.user.name}'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff2b3c4f),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets
              .all(kPadding * 2)
              .copyWith(top: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Cidade: ${serviceData.address.city}'),
                Text('Estado: ${serviceData.address.state}'),
                Text('Rua: ${serviceData.address.street}'),
                Text('Número: ${serviceData.id}'),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
