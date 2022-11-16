import 'package:br_ipti_tag_app/app/core/util/routes/routes.dart';
import 'package:br_ipti_tag_app/app/core/util/util.dart';
import 'package:br_ipti_tag_app/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:br_ipti_tag_app/app/core/widgets/menu/vertical_menu.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/widgets/left_list_checkbox_classroom_widget.dart';
import 'package:br_ipti_tag_app/app/features/classroom/presentation/widgets/right_list_checkbox_classroom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tag_sdk/tag_sdk.dart';
import 'package:tag_ui/tag_ui.dart';

import 'bloc/classroom_create_bloc.dart';
import 'bloc/classroom_create_events.dart';
import 'bloc/classroom_states.dart';

class ClassroomCreatePage extends StatefulWidget {
  const ClassroomCreatePage({super.key, this.title = 'Adicionar Turma'});

  final String title;

  @override
  ClassroomCreatePageState createState() => ClassroomCreatePageState();
}

class ClassroomCreatePageState extends State<ClassroomCreatePage> {
  final controller = Modular.get<ClassroomCreateBloc>();

  @override
  void initState() {
    controller.add(
      StartEditing(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TagScaffold(
        menu: const TagVerticalMenu(),
        appBar: const CustomAppBar(),
        title: widget.title,
        description: "",
        path: [AppRoutes.turmas, TagPath("", widget.title)],
        onTapBreadcrumb: (route) => Modular.to.pushNamed(route, forRoot: true),
        tabBar: const TabBar(
          isScrollable: true,
          labelColor: TagColors.colorBaseProductDark,
          indicatorColor: TagColors.colorBaseProductDark,
          labelPadding: EdgeInsets.symmetric(horizontal: 8),
          tabs: [
            Tab(
              child: Text("Dados da Turma"),
            ),
          ],
        ),
        body: const ClassroomBasicDataForm(),
      ),
    );
  }
}

class ClassroomBasicDataForm extends StatefulWidget {
  const ClassroomBasicDataForm({super.key});

  @override
  _ClassroomBasicDataFormState createState() => _ClassroomBasicDataFormState();
}

class _ClassroomBasicDataFormState extends State<ClassroomBasicDataForm> {
  final controller = Modular.get<ClassroomCreateBloc>();
  final _session = Modular.get<SessionBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _session.fetchCurrentSchool();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(8.0);
    final mediacaoMap = Map.fromEntries(
      Mediacao.values.map(
        (e) => MapEntry(e.id, e.name),
      ),
    );
    final etapaEnsinoMap = Map.fromEntries(
      EtapaEnsino.values.map(
        (e) => MapEntry(e.id, e.name),
      ),
    );
    final modalidadesMap = Map.fromEntries(
      Modalidades.values.map(
        (e) => MapEntry(e.id, e.name),
      ),
    );
    Widget withPadding(Widget widget) =>
        Padding(padding: padding, child: widget);

    const heading = Heading(text: "Dados Básicos", type: HeadingType.Title3);

    Widget inputName(String name) => TagTextField(
          label: "Nome",
          hint: "Nome Completo",
          onChanged: controller.setName,
          value: name,
          validator: requiredValidator,
        );

    Widget inputStartTime(DateTime startTime) => TagTextField(
          label: "Horário Inicial",
          hint: "Somente números",
          formatters: [TagMasks.maskTime],
          onChanged: (String value) {
            controller.setStartTime(DateTime.parse(value));
          },
          value: DateFormat('EEEE', 'pt_BR').format(startTime),
          validator: requiredTimeValidator,
        );

    Widget inputEndTime(DateTime endTime) => TagTextField(
          label: "Horário Final",
          hint: "Somente números",
          formatters: [TagMasks.maskTime],
          onChanged: (String value) {
            controller.setEndTime(DateTime.parse(value));
          },
          value: DateFormat('EEEE', 'pt_BR').format(endTime),
          validator: requiredTimeValidator,
        );
    Widget selectModality(int modality) => TagDropdownField<int>(
          label: 'Modalidade de ensino',
          hint: "Selecione",
          items: modalidadesMap,
          onChanged: controller.setModality,
          value: modality,
          validator: requiredDropdownValidator<int?>(),
        );
    Widget selectStage(int edcensoStage) => TagDropdownField(
          label: 'Etapa de Ensino',
          hint: "Selecione",
          items: etapaEnsinoMap,
          onChanged: controller.setStage,
          value: edcensoStage,
          validator: requiredDropdownValidator<int?>(),
        );

    Widget selectMediacaoDidaticaPedagogica(int mediacao) => TagDropdownField(
          label: 'Tipo de Mediação Didático-Pedagógica',
          hint: "Selecione",
          items: mediacaoMap,
          onChanged: controller.setMediacao,
          value: mediacao,
          validator: requiredDropdownValidator<int?>(),
        );

    return Form(
      key: _formKey,
      child: BlocBuilder<ClassroomCreateBloc, ClassroomCreateState>(
        bloc: controller,
        builder: (context, state) {
          if (state is ClassroomCreateFormState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    withPadding(heading),
                    RowToColumn(
                      children: [
                        Flexible(
                          child: withPadding(
                            inputName(state.name),
                          ),
                        ),
                        Flexible(
                          child: withPadding(
                            inputStartTime(state.startTime),
                          ),
                        ),
                      ],
                    ),
                    RowToColumn(
                      children: [
                        Flexible(
                          child: withPadding(
                            selectModality(state.modalityId),
                          ),
                        ),
                        Flexible(
                          child: withPadding(
                            inputEndTime(state.endTime),
                          ),
                        ),
                      ],
                    ),
                    RowToColumn(children: [
                      Flexible(
                        child: withPadding(
                          selectStage(state.stageId),
                        ),
                      ),
                    ]),
                    RowToColumn(children: [
                      Flexible(
                        child: withPadding(
                          selectMediacaoDidaticaPedagogica(
                            state.typePedagogicMediationId,
                          ),
                        ),
                      ),
                    ]),
                    RowToColumn(children: [
                      Flexible(
                        child: withPadding(
                          LeftListClassroomWidget(
                            onChangedSchooling: (value) => controller.schooling(
                              value: value!,
                            ),
                            onChangedAee: (value) => controller.aee(
                              value: value!,
                            ),
                            onChangedComplementaryActivity: (value) =>
                                controller.complementaryActivity(
                              value: value!,
                            ),
                            onChangedMoreEducatorParticipator: (value) =>
                                controller.moreEducationParticipator(
                              value: value!,
                            ),
                            state: state,
                          ),
                        ),
                      ),
                      Flexible(
                        child: withPadding(
                          RightListClasroomWidget(
                            onChangedAeeBraille: (value) =>
                                controller.aeeBraille(
                              value: value!,
                            ),
                            onChangedAeeOpticalNonOptical: (value) =>
                                controller.aeeOpticalNonOptical(
                              value: value!,
                            ),
                            state: state,
                            onChangedAeeCognitiveFunctions: (value) =>
                                controller.aeeCognitiveFunctions(
                              value: value!,
                            ),
                            onChangedAeeMobilityTechniques: (value) =>
                                controller.aeeMobilityTechniques(
                              value: value!,
                            ),
                            onChangedAeeLibras: (value) => controller.aeeLibras(
                              value: value!,
                            ),
                            onChangedAeeCaa: (value) => controller.aeeCaa(
                              value: value!,
                            ),
                            onChangedAeeCurriculumEnrichment: (value) =>
                                controller.aeeCurriculumEnrichment(
                              value: value!,
                            ),
                            onChangedAeeAccessibleTeaching: (value) =>
                                controller.aeeAccessibleTeaching(
                              value: value!,
                            ),
                            onChangedAeePortuguese: (value) =>
                                controller.aeePortuguese(
                              value: value!,
                            ),
                            onChangedAeeSoroban: (value) =>
                                controller.aeeSoroban(
                              value: value!,
                            ),
                            onChangedAeeAutonomousLife: (value) =>
                                controller.aeeAutonomousLife(
                              value: value!,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TagButton(
                      text: "Criar turma",
                      onPressed: () => controller.add(
                        SubmitClassroom(
                          id: _session.state.currentSchool!.inepId!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
