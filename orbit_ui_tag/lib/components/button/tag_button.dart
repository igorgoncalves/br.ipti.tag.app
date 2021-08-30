import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orbit_ui_tag/design_tokens/tokens.dart';

class TagButton extends StatelessWidget {
  const TagButton({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final elevatedButtonTheme = ElevatedButton.styleFrom(
      elevation: 0,
      padding: TagSpancing.paddingButtonNormal,
      minimumSize: const Size(double.infinity, TagSizes.heightButtonNormal),
      primary: TagColors.colorBaseProductNormal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            TagBorderRadiusValues.borderRadiusNormal,
          ),
        ),
      ),
    );

    return Container(
      child: ElevatedButton(
        child: Text(text),
        onPressed: onPressed,
        style: elevatedButtonTheme,
      ),
    );
  }
}
