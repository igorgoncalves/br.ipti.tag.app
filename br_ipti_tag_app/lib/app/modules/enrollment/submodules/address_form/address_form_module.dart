import 'package:flutter_modular/flutter_modular.dart';
import 'address_form_page.dart';

class AddressFormModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => AddressFormPage()),
  ];
}
