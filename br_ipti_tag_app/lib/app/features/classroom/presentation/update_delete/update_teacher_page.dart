import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/edcenso_disciplines_entity.dart';
import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/instructors_entity.dart';
import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/instructors_teaching_data_entity.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/update_delete/bloc/update_teacher/update_teacher_bloc.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/update_delete/bloc/update_teacher/update_teacher_states.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/widgets/add_teacher_dialog.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/widgets/tag_button_icon.dart';
import 'package:br_ipti_tag_app/app/shared/strings/file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_ui/tag_ui.dart';

class ClassroomTeacherPage extends StatefulWidget {
  const ClassroomTeacherPage({Key? key, required this.classroomId})
      : super(key: key);
  final String classroomId;

  @override
  State<ClassroomTeacherPage> createState() => _ClassroomTeacherPageState();
}

class _ClassroomTeacherPageState extends State<ClassroomTeacherPage> {
  final controller = Modular.get<UpdateTeacherBloc>();
  @override
  void initState() {
    controller.setClassroomId(widget.classroomId);
    controller.fetchListClassroomsEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          BlocBuilder<UpdateTeacherBloc, UpdateTeacherState>(
              bloc: controller,
              builder: (context, state) {
                if (state is UpdateTeacherStateLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is UpdateTeacherStateSuccess) {
                  return TagDataTable(
                    columns: const [
                      DataColumn(label: Text("Nome")),
                      DataColumn(label: Text("Etapa")),
                      DataColumn(label: Text("")),
                    ],
                    source: InstructorDatatable(
                        data: state.instructors,
                        disciplines: state.disciplinesOfInstructor,
                        classroomId: widget.classroomId,
                        context: context),
                  );
                }
                return Container();
              }),
          TagButtonIcon(
            buttonStyle: ElevatedButton.styleFrom(
              elevation: 0,
              primary: TagColors.colorBaseProductNormal,
              padding: TagSpancing.paddingButtonNormal,
              minimumSize: const Size(40, TagSizes.heightButtonNormal),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    TagBorderRadiusValues.borderRadiusNormal,
                  ),
                ),
              ),
            ),
            label: 'Adicionar professor por disciplina',
            onPressed: () async => showDialog(
                context: context,
                builder: (context) {
                  return AddTeacherDialog(
                    classroomId: widget.classroomId,
                  );
                }),
            icon: FilePaths.INFO_ICON_SVG,
            textStyle: const TextStyle(color: TagColors.colorBaseWhiteNormal),
          ),
        ],
      ),
    );
  }
}

class InstructorDatatable extends DataTableSource {
  InstructorDatatable(
      {required this.data,
      required this.disciplines,
      required this.classroomId,
      required this.context});

  final List<InstructorEntity> data;
  final List<List<EdcensoDisciplinesEntity>> disciplines;
  final String classroomId;
  final BuildContext context;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].name.toUpperCase())),
      DataCell(Text(disciplines[index].map((e) => e.name).join(','))),
      DataCell(
        GestureDetector(
          onTap: () async => showDialog(
              context: context,
              builder: (context) {
                return AddTeacherDialog(
                  classroomId: classroomId,
                  disciplineIdFk: disciplines[index].first.id,
                  instructorEntity: data[index],
                );
              }),
          child: const Icon(
            Icons.edit,
          ),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
