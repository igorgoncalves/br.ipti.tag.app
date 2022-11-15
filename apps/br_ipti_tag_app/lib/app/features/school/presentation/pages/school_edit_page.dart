import 'package:br_ipti_tag_app/app/core/widgets/menu/vertical_menu.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/cubit/school_cubit.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/cubit/school_state.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/widgets/tabs/school_adress_tab.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/widgets/tabs/school_educational_data_tab.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/widgets/tabs/school_equipments_tab.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/widgets/tabs/school_id_tab.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/widgets/tabs/school_structure_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_ui/tag_ui.dart';

class SchoolEditPage extends StatefulWidget {
  const SchoolEditPage({super.key, this.title = "Escola"});

  final String title;
  @override
  SchoolEditPageState createState() => SchoolEditPageState();
}

class SchoolEditPageState extends State<SchoolEditPage>
    with SingleTickerProviderStateMixin {
  final controller = Modular.get<SchoolCubit>();
  late TabController _tabController;
  static const List<Tab> _tabs = [
    Tab(
      child: Text("Identificação"),
    ),
    Tab(
      child: Text("Endereço e contato"),
    ),
    Tab(
      child: Text("Estrutura"),
    ),
    Tab(
      child: Text("Equipamentos"),
    ),
    Tab(
      child: Text("Dados educacionais"),
    ),
  ];
  static const _padding = EdgeInsets.all(8.0);

  Widget withPadding(Widget widget) =>
      Padding(padding: _padding, child: widget);

  @override
  void initState() {
    controller.fetchCurrentSchoolData();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttonSubmit = TagButton(
      text: "Salvar informações",
      onPressed: () => controller.updateCurrentSchoolData(),
    );

    return DefaultTabController(
      length: _tabs.length,
      child: TagScaffold(
        menu: const TagVerticalMenu(),
        aside: Container(),
        title: widget.title,
        description: 'Edite as informações da sua escola',
        path: const [],
        onTapBreadcrumb: (route) => Modular.to.pushNamed(route, forRoot: true),
        tabBar: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: TagColors.colorBaseInkLight,
          unselectedLabelColor: TagColors.colorBaseInkLight,
          indicatorColor: TagColors.colorBaseProductDark,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          tabs: _tabs,
        ),
        body: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 200,
                maxWidth: 800,
              ),
              child: BlocConsumer<SchoolCubit, SchoolState>(
                listener: (context, state) {
                  if (state is SchoolFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: TagColors.colorRedDark,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is SchoolLoadingState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: TagColors.colorBaseBlueNormal,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is SchoolSendingState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: TagColors.colorBaseBlueNormal,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is SchoolSentState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: TagColors.colorBaseBlueNormal,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is SchoolSentFailState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: TagColors.colorRedDark,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                bloc: controller,
                builder: (context, state) {
                  if (state is SchoolLoadedState ||
                      state.currentSchoolData != null) {
                    return _buildWithData();
                  }

                  return _buildWithoutData();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: TagColors.colorBaseWhiteNormal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RowToColumn(children: [
                      Flexible(
                        child: withPadding(buttonSubmit),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBarView _buildWithData() {
    return TabBarView(
      controller: _tabController,
      children: const [
        SchoolIdTab(),
        SchoolAddressTab(),
        SchoolStructureTab(),
        ShcoolEquipmentsTab(),
        SchoolEducationalDataTab(),
      ],
    );
  }

  TabBarView _buildWithoutData() {
    return TabBarView(
      controller: _tabController,
      children: const [
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
