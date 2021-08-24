import 'package:br_ipti_tag_app/app/features/classroom/classroom_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/enrollment/enrollment_module.dart';
import 'features/food/submodules/stock/stock_module.dart';
import 'features/login/login_module.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [Bind.singleton((i) => Dio())];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      "/auth",
      module: LoginModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/merenda/estoque",
      module: StockModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/alunos",
      module: EnrollmentModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/turmas",
      module: ClassroomModule(),
      transition: TransitionType.noTransition,
    )
  ];
}
