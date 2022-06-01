import 'package:br_ipti_tag_app/app/shared/util/enums/edit_mode.dart';
import 'package:br_ipti_tag_app/app/shared/widgets/menu/vertical_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_ui/tag_ui.dart';

import '../bloc/create_instructor_bloc.dart';
import '../bloc/instructor_states.dart';
import 'address/address_social_form_partial_page.dart';

import 'address/bloc/instructor_address_bloc.dart';
import 'personal/bloc/instructor_personal_bloc.dart';
import 'personal/personal_form_partial_page.dart';

class InstructorFormPage extends StatefulWidget {
  const InstructorFormPage({
    Key? key,
    this.title = 'Professor',
    this.editMode = EditMode.Create,
  }) : super(key: key);

  final String title;
  final EditMode editMode;

  @override
  InstructorFormPageState createState() => InstructorFormPageState();
}

class InstructorFormPageState
    extends ModularState<InstructorFormPage, CreateInstructorBloc>
    with SingleTickerProviderStateMixin {
  static const List<Tab> _tabs = [
    Tab(
      child: Text("Dados do pessoais"),
    ),
    Tab(
      child: Text("Endereço e Social"),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    // _tabController.addListener(onTap);

    controller.stream.listen((state) {
      final nextIndex = _tabController.index + 1;
      final isLastTab = nextIndex == _tabs.length;
      if (state is InstructorNextTabState && !isLastTab) {
        _tabController.animateTo(nextIndex);
        controller.tabIndex = nextIndex;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: TagDefaultPage(
        menu: const TagVerticalMenu(),
        title: widget.title,
        description: "",
        path: ["Alunos", widget.title],
        body: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: TagColors.colorBaseProductDark,
            indicatorColor: TagColors.colorBaseProductDark,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            onTap: (value) => controller.setTabIndex(value),
            tabs: _tabs,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: 800,
            ),
            child: BlocConsumer<CreateInstructorBloc, InstructorFormState>(
              listener: (context, state) {
                if (state is CreateInstructorErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: TagColors.colorRedDark,
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is CreateInstructorSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: TagColors.colorBaseProductNormal,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              bloc: controller,
              builder: (context, state) {
                if (state is InstructorLoadedState) {
                  return _buildWithData(state);
                }
                return _buildWithoutData();
              },
            ),
          ),
        ],
      ),
    );
  }

  TabBarView _buildWithData(InstructorLoadedState state) {
    return TabBarView(
      controller: _tabController,
      children: [
        PersonalDataFormPage(
          editMode: widget.editMode,
        ),
        AddressFormPage(
          editMode: widget.editMode,
        ),
      ],
    );
  }

  TabBarView _buildWithoutData() {
    return TabBarView(
      controller: _tabController,
      children: [
        PersonalDataFormPage(
          editMode: widget.editMode,
        ),
        AddressFormPage(
          editMode: widget.editMode,
        ),
      ],
    );
  }

  @override
  void dispose() {
    Modular.dispose<InstructorPersonalBloc>();
    Modular.dispose<InstructorAddressBloc>();
    super.dispose();
  }
}
