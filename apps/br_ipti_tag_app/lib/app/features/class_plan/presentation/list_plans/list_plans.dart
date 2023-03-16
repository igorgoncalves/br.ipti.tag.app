import 'package:br_ipti_tag_app/app/features/class_plan/presentation/list_plans/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_ui/tag_ui.dart';

import '../../../../core/util/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/menu/vertical_menu.dart';

class ListPlans extends StatefulWidget {
  const ListPlans({super.key, this.title = "Plano de aula"});
  final String title;

  @override
  State<ListPlans> createState() => _ListPlansState();
}

class _ListPlansState extends State<ListPlans> {
   //final planClass = Modular.get<ControllerPlanClass>();

  @override
  Widget build(BuildContext context) {
    const styleResult = TextStyle(
        color: TagColors.colorBaseBlueNormal,
        fontWeight: FontWeight.bold,
        fontSize: 16);

   //  print(planClass.planClass.toString());

    return TagScaffold(
      menu: const TagVerticalMenu(),
      appBar: const CustomAppBar(),
      title: widget.title,
      path: [TagPath("", "Inicio"), AppRoutes.classPlan],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TagButton(text: "Criar plano", onPressed: () => {}),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TagBox(
                background: Color.fromARGB(255, 216, 219, 249),
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  dense: true,
                  title: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Exibindo 1-2 de 2 resultados.",
                      style: styleResult,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return TagButton(
                    text: 'text',
                    onPressed: () => Modular.to.pushNamed(
                          "create",
                        ),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
