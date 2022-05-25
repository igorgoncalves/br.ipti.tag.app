import 'package:br_ipti_tag_app/app/shared/util/enums/edit_mode.dart';
import 'package:br_ipti_tag_app/app/shared/validators/validators.dart';
import 'package:br_ipti_tag_app/app/shared/widgets/submit_buttons_row/submit_buttons_row.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tag_ui/tag_ui.dart';

import 'bloc/enrollment_personal_bloc.dart';
import 'bloc/enrollment_personal_states.dart';

class PersonalDataFormPage extends StatefulWidget {
  const PersonalDataFormPage({
    Key? key,
    this.editMode = EditMode.Create,
  }) : super(key: key);

  final EditMode editMode;

  @override
  _PersonalDataFormPageState createState() => _PersonalDataFormPageState();
}

class _PersonalDataFormPageState extends State<PersonalDataFormPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Modular.get<InstructorPersonalBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const heading1 = Heading(
      text: "Dados básicos",
      type: HeadingType.Title3,
    );

    const heading2 = Heading(
      text: "Saúde e recursos",
      type: HeadingType.Title3,
    );

    return Form(
      key: _formKey,
      child: BlocBuilder<InstructorPersonalBloc, InstructorPersonalState>(
          bloc: controller,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 36, bottom: 16),
                      child: heading1,
                    ),
                    RowToColumn(
                      children: [
                        Flexible(
                          child: _NameField(
                            name: state.name,
                            controller: controller,
                          ),
                        ),
                        Flexible(
                            child: _BirthdayField(
                          birthday: state.birthdayDate,
                          controller: controller,
                        )),
                      ],
                    ),
                    RowToColumn(children: [
                      Flexible(
                          child: _ColorRaceField(
                        colorRace: state.colorRace,
                        controller: controller,
                      )),
                      Flexible(
                          child: _SexField(
                        sex: state.sex,
                        controller: controller,
                      )),
                    ]),
                    RowToColumn(children: [
                      Flexible(
                        child: _NationalityField(
                          nationality: state.nationality,
                          controller: controller,
                        ),
                      ),
                      Flexible(
                          child: _FiliationField(
                        filiation: 1,
                        controller: controller,
                      )),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(top: 36, bottom: 16),
                      child: heading2,
                    ),
                    RowToColumn(children: [
                      Flexible(
                        child: _FormDeficiency(
                          controller: controller,
                          state: state,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: SubmitButtonsRow(
                        onSubmitAndGo: () {
                          if (_formKey.currentState!.validate()) {
                            controller.submitPersonalForm(widget.editMode);
                          }
                        },
                        onSubmitAndStay: () {
                          if (_formKey.currentState!.validate()) {
                            controller.submitPersonalForm(widget.editMode);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _SexField extends StatelessWidget {
  const _SexField({
    Key? key,
    required this.controller,
    this.sex,
  }) : super(key: key);
  final int? sex;
  final InstructorPersonalBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<int>(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_SEX'),
      label: 'Sexo',
      hint: "Selecione o sexo",
      items: controller.sexItems,
      onChanged: controller.setSex,
      value: sex,
      validator: requiredValidator,
    );
  }
}

class _ColorRaceField extends StatelessWidget {
  const _ColorRaceField({
    Key? key,
    required this.controller,
    this.colorRace,
  }) : super(key: key);

  final InstructorPersonalBloc controller;
  final int? colorRace;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<int>(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_COLOR_RACE'),
      label: 'Cor/Raça',
      hint: "Selecione a cor/raça",
      items: controller.colorRaceItems,
      onChanged: controller.setColorRace,
      value: colorRace,
      validator: requiredValidator,
    );
  }
}

class _FiliationField extends StatelessWidget {
  const _FiliationField({
    Key? key,
    required this.controller,
    this.filiation,
  }) : super(key: key);

  final int? filiation;
  final InstructorPersonalBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<int>(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_FILIATION'),
      label: 'Filiação',
      hint: "Selecione a filiação",
      items: controller.filiationItems,
      onChanged: controller.setFiliation,
      value: filiation,
      validator: requiredValidator,
    );
  }
}

class _NationalityField extends StatelessWidget {
  const _NationalityField({
    Key? key,
    required this.controller,
    this.nationality,
  }) : super(key: key);
  final int? nationality;
  final InstructorPersonalBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<int>(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_NATIONALITY'),
      label: 'Nacionalidade',
      hint: "Selecione a nacionalidade",
      items: controller.nationalityItems,
      onChanged: controller.setNationality,
      value: nationality,
      validator: requiredValidator,
    );
  }
}

class _BirthdayField extends StatelessWidget {
  const _BirthdayField({
    Key? key,
    this.birthday,
    required this.controller,
  }) : super(key: key);

  final String? birthday;
  final InstructorPersonalBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDatePickerField(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_BIRTHDAY'),
      label: "Data  de nascimento",
      hint: "__/__/____",
      onChanged: controller.setBirthday,
      value: birthday,
      inputType: TextInputType.number,
      validator: MultiValidator([
        requiredValidator,
        dateValidator,
      ]),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    Key? key,
    this.name,
    required this.controller,
  }) : super(key: key);

  final InstructorPersonalBloc controller;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key('STUDENT_INSTRUCTOR_PERSONAL_NAME'),
      label: "Nome",
      hint: "Digite o nome do aluno",
      onChanged: controller.setName,
      value: name,
      inputType: TextInputType.name,
      validator: MultiValidator([
        requiredValidator,
        minLengthValidator(10),
        onlyLettersValidator,
      ]),
    );
  }
}

class _FormDeficiency extends StatelessWidget {
  const _FormDeficiency({
    Key? key,
    required this.controller,
    required this.state,
  }) : super(key: key);

  final InstructorPersonalBloc controller;
  final InstructorPersonalState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TagCheckbox(
          label: "Deficiência",
          value: state.deficiency,
          onChange: controller.setDeficiency,
        ),
        const Divider(
          color: TagColors.colorBaseProductNormal,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Cegueira",
          value: state.deficiencyTypeBlindness,
          onChange: controller.setDeficiencyTypeBlindness,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Baixa visão",
          value: state.deficiencyTypeLowVision,
          onChange: controller.setDeficiencyTypeLowVision,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Surdez",
          value: state.deficiencyTypeDeafness,
          onChange: controller.setDeficiencyTypeDeafness,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Deficiência auditiva",
          value: state.deficiencyTypeDisabilityHearing,
          onChange: controller.setDeficiencyTypeDisabilityHearing,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Surdocegueira",
          value: state.deficiencyTypeDeafblindness,
          onChange: controller.setDeficiencyTypeDeafblindness,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Deficiência Física",
          value: state.deficiencyTypePhisicalDisability,
          onChange: controller.setDeficiencyTypePhisicalDisability,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Deficiência Intelectual",
          value: state.deficiencyTypeIntelectualDisability,
          onChange: controller.setDeficiencyTypeIntelectualDisability,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Deficiência Múltipla",
          value: state.deficiencyTypeMultipleDisabilities,
          onChange: controller.setDeficiencyTypeMultipleDisabilities,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Transtorno do Espectro Autista",
          value: state.deficiencyTypeAutism,
          onChange: controller.setDeficiencyTypeAutism,
        ),
        _TagCheckbox(
          disabled: !state.deficiency,
          label: "Altas Habilidades / Super Dotação",
          value: state.deficiencyTypeGifted,
          onChange: controller.setDeficiencyTypeGifted,
        ),
      ],
    );
  }
}

class _TagCheckbox extends StatelessWidget {
  const _TagCheckbox({
    Key? key,
    required this.onChange,
    this.value = false,
    this.disabled = false,
    required this.label,
  }) : super(key: key);

  final void Function(bool?) onChange;
  final bool? value;
  final bool disabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value ?? false,
          onChanged: disabled ? null : onChange,
        ),
        TagLabel(label),
      ],
    );
  }
}
