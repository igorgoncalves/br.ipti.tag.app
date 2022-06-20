import 'package:br_ipti_tag_app/app/features/school/presentation/cubit/school_cubit.dart';
import 'package:br_ipti_tag_app/app/features/school/presentation/cubit/school_state.dart';
import 'package:br_ipti_tag_app/app/shared/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_ui/tag_ui.dart';

class SchoolBasicDataForm extends StatefulWidget {
  const SchoolBasicDataForm({Key? key}) : super(key: key);

  @override
  State<SchoolBasicDataForm> createState() => _SchoolBasicDataFormState();
}

class _SchoolBasicDataFormState extends State<SchoolBasicDataForm> {
  final controller = Modular.get<SchoolCubit>();

  @override
  Widget build(BuildContext context) {
    const heading = Heading(text: "Dados básicos", type: HeadingType.Title2);
    const padding = EdgeInsets.all(8.0);

    Widget withPadding(Widget widget) =>
        Padding(padding: padding, child: widget);

    Widget inputSchoolName(String schoolName) => TagTextField(
          label: "Nome da escola",
          hint: "Digite o nome da escola",
          value: schoolName,
          validator: requiredValidator,
        );
    Widget inputInepCode(String inepCode) => TagTextField(
          label: "Código do INEP",
          hint: "Digite o código do INEP",
          value: inepCode,
          validator: requiredValidator,
        );
    Widget inputAdminDep() => TagDropdownField(
          onChanged: () => {},
          label: "Dependência administrativa",
          validator: requiredValidator,
          items: {},
        );
    Widget inputStatus() => TagDropdownField(
          onChanged: () => {},
          label: "Situação",
          validator: requiredValidator,
          items: {},
        );
    Widget inputRegionalAdmin() => TagDropdownField(
          onChanged: () => {},
          label: "Órgão regional de administração",
          hint: "Selecione",
          validator: requiredValidator,
          items: {},
        );
    Widget inputStartDate(String inepCode) => TagTextField(
          label: "Data de início da escola",
          hint: "Somente números",
          value: inepCode,
          validator: requiredValidator,
        );

    Widget inputRecognitionAct(String inepCode) => TagTextField(
          label: "Ato de reconhecimento",
          hint: "Digite o código do INEP",
          value: inepCode,
          validator: requiredValidator,
        );
    Widget inputEndDate(String schoolName) => TagTextField(
          label: "Data do fechamento da escola",
          hint: "Digite o nome da escola",
          value: schoolName,
          validator: requiredValidator,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        withPadding(heading),
        BlocBuilder<SchoolCubit, SchoolState>(
          bloc: controller,
          builder: (context, state) {
            return RowToColumn(children: [
              Flexible(
                child: withPadding(
                    inputSchoolName('state.currentSchoolData!.name')),
              ),
              Flexible(
                child: withPadding(inputInepCode("PlaceHolder")),
              ),
            ]);
          },
        ),
        RowToColumn(children: [
          Flexible(
            child: withPadding(inputSchoolName("PlaceHolder")),
          ),
          Flexible(
            child: withPadding(inputInepCode("PlaceHolder")),
          ),
        ]),
        RowToColumn(children: [
          Flexible(
            child: withPadding(inputAdminDep()),
          ),
          Flexible(
            child: withPadding(inputStatus()),
          ),
        ]),
        RowToColumn(children: [
          Flexible(
            child: withPadding(inputRegionalAdmin()),
          ),
          Flexible(
            child: withPadding(inputStartDate("PlaceHolder")),
          ),
        ]),
        RowToColumn(children: [
          Flexible(
            child: withPadding(inputRecognitionAct("PlaceHolder")),
          ),
          Flexible(
            child: withPadding(inputEndDate("PlaceHolder")),
          ),
        ]),
      ],
    );
  }
}
