import 'dart:developer';

import 'package:br_ipti_tag_biometry_app/controller/controller.dart';
import 'package:br_ipti_tag_biometry_app/services/socket_io.dart';
import 'package:br_ipti_tag_biometry_app/widgets/finger_mensage.dart';
import 'package:br_ipti_tag_biometry_app/widgets/school_panel.dart';
import 'package:br_ipti_tag_biometry_app/widgets/student_info.dart';
import 'package:br_ipti_tag_biometry_app/widgets/waiting_biometrics.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class SchoolEntrance extends StatefulWidget {
  const SchoolEntrance({super.key});

  @override
  State<SchoolEntrance> createState() => _SchoolEntrancePageState();
}

class _SchoolEntrancePageState extends State<SchoolEntrance> {
  final biometricsService = BiometricsService();
  final biometricsController = ControllerBiometrics();

  String mensage = '';
  var identification;
  @override
  void initState() {
    super.initState();
    biometricsController.dateBiometrics();

    log(biometricsController.getResponseEvents.hashCode.toString());
    biometricsService.connectAndListen();
    biometricsController.getResponseEvents.listen((data) {
      log(data.code.toString());
    });
    biometricsService.emit("message", "SearchSendMessage");
  }

  final mapBioStudent = {50: 2};
  final user = [
    {'name': 'jonny', 'turma': '3A', 'id': '1'},
    {'name': 'Igor', 'turma': '3B', 'id': '50'},
  ];

  @override
  Widget build(BuildContext context) {
    mapBioStudent[50];
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const SchoolPanel(),
            StreamBuilder<BioEvents?>(
              stream: biometricsController.getResponseEvents,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    if (snapshot.data?.code == 101) const WaitingBiometrics(),
                    if (snapshot.data?.code == 102)
                      FingerMensage(text: snapshot.data!.info),
                    if (snapshot.data?.code == 104)
                      FingerMensage(text: snapshot.data!.info),
                    if (snapshot.data?.code == 202) const StudentInfo(),
                    if (snapshot.data?.code == 502)
                      FingerMensage(text: snapshot.data!.info),
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
