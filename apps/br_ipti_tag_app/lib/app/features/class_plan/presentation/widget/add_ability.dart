import 'package:flutter/material.dart';
import 'package:tag_ui/tag_ui.dart';

class AddAbility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adicionar Habilidades",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 1,
                    color: TagColors.colorBaseCloudLightHover,
                  ),
                ),
                TagDropdownField(
                  onChanged: (e) => {},
                  label: "Campos de atuação",
                  items: Map.fromEntries(
                    ["d", "e", "s", "p", "a", "c", "i", "t", "o"].map(
                      (e) => MapEntry(e, e),
                    ),
                  ),
                ),
                TagDropdownField(
                  onChanged: (e) => {},
                  label: "Práticas de linguagens",
                  items: Map.fromEntries(
                    ["d", "e", "s", "p", "a", "c", "i", "t", "o"].map(
                      (e) => MapEntry(e, e),
                    ),
                  ),
                ),
                TagDropdownField(
                  onChanged: (e) => {},
                  label: "Objetos de conhecimento",
                  items: Map.fromEntries(
                    ["d", "e", "s", "p", "a", "c", "i", "t", "o"].map(
                      (e) => MapEntry(e, e),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 1,
                        color: TagColors.colorBaseCloudLightHover,
                      ),
                    ),
                    const Text('Habilidades'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 1,
                        color: TagColors.colorBaseCloudLightHover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        color: TagColors.colorBaseCloudNormal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: TagColors.colorGreenLight,
                                child: Icon(Icons.add,
                                    color: TagColors.colorBaseProductLighter,),
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "(EF01LP01) Reconhecer que textos são lidos e escritos da esquerda para a direita e de cima para baixo da página.",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 1,
                        color: TagColors.colorBaseCloudLightHover,
                      ),
                    ),
                    const Text('Selecionadas'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 1,
                        color: TagColors.colorBaseCloudLightHover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        color: TagColors.colorBaseCloudNormal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: TagColors.colorRedDark,
                                width: 25,
                                height: 25,
                                child: Icon(
                                  Icons.remove,
                                  color: TagColors.colorBaseProductLighter,
                                ),
                              ),
                            ),
                            const Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "(EF01LP01) Reconhecer que textos são lidos e escritos da esquerda para a direita e de cima para baixo da página.",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
