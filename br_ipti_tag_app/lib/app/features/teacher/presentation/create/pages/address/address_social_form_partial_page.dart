import 'package:br_ipti_tag_app/app/features/student/presentation/fast_enrollment/pages/_classes_form_partial_page.dart';
import 'package:br_ipti_tag_app/app/shared/util/enums/edit_mode.dart';
import 'package:br_ipti_tag_app/app/shared/validators/validators.dart';
import 'package:br_ipti_tag_app/app/shared/widgets/submit_buttons_row/submit_buttons_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tag_ui/tag_ui.dart';

import 'bloc/instructor_address_bloc.dart';
import 'bloc/instructor_address_states.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({
    Key? key,
    this.editMode = EditMode.Create,
  }) : super(key: key);

  final EditMode editMode;

  @override
  AddressFormPageState createState() => AddressFormPageState();
}

const padding = EdgeInsets.symmetric(vertical: 8);

class AddressFormPageState extends State<AddressFormPage> {
  @override
  void initState() {
    controller.fetchUFs();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final controller = Modular.get<InstructorAddressBloc>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<InstructorAddressBloc, InstructorAddressState>(
          bloc: controller,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: padding,
                      child: Heading(
                        text: "Endereço",
                        type: HeadingType.Title3,
                      ),
                    ),
                    // First Row
                    RowToColumn(
                      children: [
                        Flexible(
                          flex: 3,
                          child: _CEPField(
                            cep: state.cep,
                            controller: controller,
                          ),
                        ),
                        Flexible(
                          child: _UFField(
                            edcensoUfFk: state.edcensoUfFk,
                            controller: controller,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: _CityField(
                            edcensoCityFk: state.edcensoCityFk,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    // Second Row
                    RowToColumn(
                      children: [
                        Flexible(
                          flex: 4,
                          child: _AddressField(
                            address: state.address,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    // Third Row
                    RowToColumn(
                      children: [
                        Flexible(
                          flex: 4,
                          child: _AddressNumberField(
                            number: state.number,
                            controller: controller,
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: _NeighborhoodField(
                            neighborhood: state.neighborhood,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    // Fourth Row
                    RowToColumn(
                      children: [
                        Flexible(
                          flex: 4,
                          child: _ComplementField(
                            complement: state.complement,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    RowToColumn(
                      children: [
                        Flexible(
                          flex: 4,
                          child: _ZoneField(
                            residenceZone: state.residenceZone,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                    SubmitButtonsRow(
                      onSubmitAndGo: () {
                        if (_formKey.currentState!.validate()) {
                          controller.submitAddressForm(widget.editMode);
                        }
                      },
                      onSubmitAndStay: () {
                        if (_formKey.currentState!.validate()) {
                          controller.submitAddressForm(widget.editMode);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _CEPField extends StatelessWidget {
  const _CEPField({
    Key? key,
    required this.cep,
    required this.controller,
  }) : super(key: key);

  final String cep;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key("INSTRUCTOR_ADDRESS_CEP"),
      label: "CEP",
      hint: "Digite o CEP",
      onChanged: controller.setCEP,
      formatters: [TagMasks.maskCEP],
      value: TagMasks.maskCEP.maskText(cep),
      validator: MultiValidator([
        postalValidator,
      ]),
    );
  }
}

class _UFField extends StatelessWidget {
  const _UFField({
    Key? key,
    required this.edcensoUfFk,
    required this.controller,
  }) : super(key: key);

  final String edcensoUfFk;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<String>(
      key: const Key("INSTRUCTOR_ADDRESS_UF"),
      label: "UF",
      hint: "Selecione a UF",
      items: controller.state.ufs,
      onChanged: controller.setUf,
      value: edcensoUfFk,
    );
  }
}

class _CityField extends StatelessWidget {
  const _CityField({
    Key? key,
    required this.edcensoCityFk,
    required this.controller,
  }) : super(key: key);

  final String? edcensoCityFk;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagDropdownField<String>(
      key: const Key("INSTRUCTOR_ADDRESS_CITY"),
      label: 'Cidade',
      hint: "Selecione a cidade",
      items: controller.state.cities,
      onChanged: controller.setCity,
      value: edcensoCityFk,
    );
  }
}

class _AddressField extends StatelessWidget {
  const _AddressField({
    Key? key,
    required this.address,
    required this.controller,
  }) : super(key: key);

  final String address;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key("INSTRUCTOR_ADDRESS_ADDRESS"),
      label: "Endereço",
      hint: "Digite o endereço",
      onChanged: controller.setAddress,
      value: address,
    );
  }
}

class _AddressNumberField extends StatelessWidget {
  const _AddressNumberField({
    Key? key,
    required this.number,
    required this.controller,
  }) : super(key: key);

  final String number;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key("INSTRUCTOR_ADDRESS_NUMBER"),
      label: "Número",
      hint: "Digite o número",
      onChanged: controller.setNumber,
      value: number,
    );
  }
}

class _NeighborhoodField extends StatelessWidget {
  const _NeighborhoodField({
    Key? key,
    required this.neighborhood,
    required this.controller,
  }) : super(key: key);

  final String neighborhood;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key("INSTRUCTOR_ADDRESS_NEIGHBORHOOD"),
      label: "Bairro",
      hint: "Digite o bairro",
      onChanged: controller.setNeighborhood,
      value: neighborhood,
    );
  }
}

class _ComplementField extends StatelessWidget {
  const _ComplementField({
    Key? key,
    required this.complement,
    required this.controller,
  }) : super(key: key);

  final String complement;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagTextField(
      key: const Key("INSTRUCTOR_ADDRESS_COMPLEMENT"),
      label: "Complemento",
      hint: "Digite o complemento",
      onChanged: controller.setComplement,
      value: complement,
    );
  }
}

class _ZoneField extends StatelessWidget {
  const _ZoneField({
    Key? key,
    required this.residenceZone,
    required this.controller,
  }) : super(key: key);

  final int residenceZone;
  final InstructorAddressBloc controller;

  @override
  Widget build(BuildContext context) {
    return TagCheckbox(
      key: const Key("INSTRUCTOR_ADDRESS_ZONE"),
      label: "A residência fica em uma Zona Urbana",
      value: residenceZone == 2,
      onChanged: (value) => controller.setZone(value! ? 2 : 1),
    );
  }
}
