import 'dart:developer';

import 'package:br_ipti_tag_biometry_app/core/bio_event.dart';
import 'package:br_ipti_tag_biometry_app/screens/biometrics/presentation/identification/controller.dart';
import 'package:br_ipti_tag_biometry_app/screens/biometrics/presentation/sign/sign_state.dart';
import 'package:br_ipti_tag_biometry_app/widgets/finger_mensage.dart';
import 'package:br_ipti_tag_biometry_app/widgets/school_panel.dart';
import 'package:br_ipti_tag_biometry_app/widgets/student_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tag_sdk/tag_sdk.dart';
import 'package:tag_ui/tag_ui.dart';

class SchoolEntrance extends StatefulWidget {
  const SchoolEntrance({super.key});

  @override
  State<SchoolEntrance> createState() => _SchoolEntrancePageState();
}

class _SchoolEntrancePageState extends State<SchoolEntrance> {
  final biometricsController = Modular.get<ControllerIdentification>();
  @override
  void initState() {
    // final sharedPreferences = SharedPreferences.getInstance().then((value) => value.clear());
    // biometricsController.deleteAllFinger();

    super.initState();
  }

  @override
  void dispose() {
    biometricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const SchoolPanel(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TagButton(
                      text: 'Recarregar',
                      onPressed: (() => {
                            biometricsController.startIdentification(),
                            biometricsController.dateBiometrics(),
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TagButton(
                    text: 'Cadastrar Biometria',
                    onPressed: () {
                      Modular.to.pushReplacementNamed("/biometrics/students/");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TagButton(
                    text: 'Sair',
                    onPressed: () {
                      final usecase = Modular.get<LogoutUsecase>();
                      usecase.call(EmptyParams());
                      Modular.to.pushNamed("/");
                    },
                  ),
                ),
              ],
            ),
            StreamBuilder<SignState?>(
              stream: biometricsController.stateSignStream.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    if (snapshot.data == null)
                      Center(
                          heightFactor: 10.0,
                          child: TagButton(
                              text: 'Identificar Aluno',
                              onPressed: (() => {
                                    biometricsController.startIdentification(),
                                    biometricsController.dateBiometrics(),
                                  }))),
                    if (snapshot.data?.event == BioEvents.waiting)
                      FingerMensage(
                          text: snapshot.data!.event.info,
                          code: snapshot.data?.event.code),
                    if (snapshot.data?.event.code == BioEvents.modeling.code)
                      FingerMensage(
                          text: snapshot.data!.event.info,
                          code: snapshot.data?.event.code),
                    if (snapshot.data?.event.code == BioEvents.searching.code)
                      FingerMensage(
                          text: snapshot.data!.event.info,
                          code: snapshot.data?.event.code),
                    if (snapshot.data?.event.code ==
                        BioEvents.fingerDected.code)
                      StudentInfo(student: snapshot.data!.student),
                    if (snapshot.data?.event.code ==
                        BioEvents.fingerNotFound.code)
                      FingerMensage(
                          text: snapshot.data!.event.info,
                          code: snapshot.data?.event.code),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
