import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbit_ui_tag/strings/file_paths.dart';

class LogoTag extends StatelessWidget {
  const LogoTag({
    Key key,
    this.color,
    this.width,
    this.height,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      FilePaths.LOGO_PATH_SVG,
      semanticsLabel: 'TAG Logo',
      alignment: alignment,
      height: height,
      width: width,
      color: color,
    );
  }
}
