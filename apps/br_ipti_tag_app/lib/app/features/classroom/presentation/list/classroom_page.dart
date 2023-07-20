import 'package:br_ipti_tag_app/app/core/util/enums/status_fetch.dart';
import 'package:br_ipti_tag_app/app/core/util/routes/routes.dart';
import 'package:br_ipti_tag_app/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:br_ipti_tag_app/app/core/widgets/menu/vertical_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_sdk/tag_sdk.dart';
import 'package:tag_ui/tag_ui.dart';

import 'bloc/classroom_list_bloc.dart';
import 'bloc/classroom_list_states.dart';

class ClassroomPage extends StatefulWidget {
  const ClassroomPage({super.key, this.title = 'Turmas'});

  final String title;

  @override
  ClassroomPageState createState() => ClassroomPageState();
}

class ClassroomPageState extends State<ClassroomPage> {
  final controller = Modular.get<ClassroomListBloc>();

  @override
  void initState() {
    controller.fetchListClassroomsEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TagScaffold(
      menu: const TagVerticalMenu(),
      appBar: const CustomAppBar(),
      title: widget.title,
      description: "",
      path: [AppRoutes.home, TagPath("", widget.title)],
      onTapBreadcrumb: (route) => Modular.to.pushNamed(route, forRoot: true),
      actionsHeader: _SliverHeaderActionDelegate(
        actionsHeader: const _Actions(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Flexible(
            child: BlocBuilder<ClassroomListBloc, ClassroomListState>(
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
                        arguments: state.classrooms[index],
                      ),
                      columns: const [
                        DataColumn(
                          label: Text("Nome"),
                        ),
                        DataColumn(
                          label: Text("Etapa"),
                        ),
                        DataColumn(
                          label: Text("Horário "),
                        ),
                      ],
                      source: ClassroomDatatable(
                        data: state.classrooms,
                      ),
                    );
                  default:
                    return TagEmpty(
                      onPressedRetry: () =>
                          controller.fetchListClassroomsEvent(),
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

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: TagButton(
            text: "Criar turma",
            onPressed: () => Modular.to.pushNamed("create"),
          ),
        ),
      ],
    );
  }
}

class ClassroomDatatable extends DataTableSource {
  ClassroomDatatable({
    required this.data,
  });

  final List<ClassroomEntity> data;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        data[index].name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(
        Text(data[index].turn ?? "Não definido",style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      DataCell(
        Text('${data[index].createDate}',style: const TextStyle(fontWeight: FontWeight.w500)),
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

class _SliverHeaderActionDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderActionDelegate({
    required this.actionsHeader,
  });

  final Widget actionsHeader;

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      color: TagColors.colorBaseWhiteNormal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: actionsHeader,
    );
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(_SliverHeaderActionDelegate oldDelegate) {
    return false;
  }
}
