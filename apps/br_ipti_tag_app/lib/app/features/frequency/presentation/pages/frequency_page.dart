import 'package:br_ipti_tag_app/app/core/util/routes/routes.dart';
import 'package:br_ipti_tag_app/app/core/util/util.dart';
import 'package:br_ipti_tag_app/app/core/widgets/menu/vertical_menu.dart';
import 'package:br_ipti_tag_app/app/features/frequency/presentation/cubit/frequency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_sdk/tag_sdk.dart';
import 'package:tag_ui/tag_ui.dart';

import '../cubit/frequency_cubit.dart';

class FrequencyPage extends StatefulWidget {
  const FrequencyPage({
    super.key,
    this.title = "Frequência",
    required this.classroom,
    required this.discipline,
  });

  final String title;
  final ClassroomEntity classroom;
  final EdcensoDiscipline discipline;

  @override
  State<FrequencyPage> createState() => _FrequencyPageState();
}

class _FrequencyPageState extends State<FrequencyPage> {
  final controller = Modular.get<FrequencyCubit>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.fetchListStudentEvent();
  }

  @override
  Widget build(BuildContext context) {
    return TagScaffold(
      title: "Frequencia",
      path: [
        AppRoutes.frequencia,
        TagPath(AppRoutes.frequencia.path, widget.classroom.name),
        TagPath(AppRoutes.frequencia.path, widget.discipline.name),
      ],
      onTapBreadcrumb: (route) => Modular.to.pushNamed(route, forRoot: true),
      description: "",
      menu: const TagVerticalMenu(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Flexible(
            child: BlocBuilder<FrequencyCubit, FrequencyState>(
              bloc: controller,
              builder: (context, state) {
                switch (state.status) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.success:
                    return TagDataTable(
                      onTapRow: (index) => Modular.to.pushNamed(
                        "updatePage",
                        arguments: state.students[index],
                      ),
                      columns: const [
                        DataColumn(
                          label: Text("Nome"),
                        ),
                      ],
                      source: StudentsDatatable(
                        data: state.students,
                      ),
                    );
                  default:
                    return TagEmpty(
                      onPressedRetry: () => controller.fetchListStudentEvent(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StudentsDatatable extends DataTableSource {
  StudentsDatatable({
    required this.data,
  });

  final List<Student> data;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        data[index].name!,
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
