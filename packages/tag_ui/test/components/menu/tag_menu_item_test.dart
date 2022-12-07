import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tag_ui/src/components/components.dart';

import 'package:tag_ui/src/strings/file_paths.dart';

import '../../helpers/methods/prepare_widget.dart';
import '../../helpers/mock/dumb.dart';

void main() {
  group("When TagMenuItem", () {
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets("render", (WidgetTester tester) async {
      const path = TagPath("titulo", "");
      final tagMenuItem = TagMenuItem(
        props: TagMenuItemProps(path: path),
        onTap: (rota) {},
      );

      await tester.pumpWidget(
        wrapWithBaseApp(tagMenuItem),
      );
      final Finder resultSearch = find.byType(TagMenuItem);
      expect(resultSearch, findsOneWidget);
    });
    testWidgets("render with text", (WidgetTester tester) async {
      const path = TagPath("titulo", "");
      final tagMenuItem = TagMenuItem(
        props: TagMenuItemProps(path: path),
        onTap: (rota) {},
      );
      await tester.pumpWidget(
        wrapWithBaseApp(tagMenuItem),
      );
      final Finder resultSearch = find.text("titulo");
      expect(resultSearch, findsOneWidget);
    });
    testWidgets("render with icon", (WidgetTester tester) async {
      const path = TagPath("titulo", "");
      final tagMenuItem = TagMenuItem(
        props: TagMenuItemProps(
          path: path,
          icon: TagIcon(
              defaultVersionPath: FilePaths.LOGO_LIGHT_PATH_SVG,
              disabledVersionPath: FilePaths.LOGO_GREY_PATH_SVG),
        ),
        onTap: (rota) {},
      );
      await tester.pumpWidget(
        wrapWithBaseAppAndBundle(tagMenuItem),
      );
      final Finder resultSearch = find.byType(SvgPicture);
      expect(resultSearch, findsOneWidget);
    });
    testWidgets("is tapped", (WidgetTester tester) async {
      final dumb = MockDumb();
      when(() => dumb.callWithParam1(
            any(),
          )).thenAnswer((invocation) {});
      const path = TagPath("titulo", "/rota");
      final tagMenuItem = TagMenuItem(
        props: TagMenuItemProps(path: path),
        onTap: (rota) {
          dumb.callWithParam1(rota);
        },
      );

      await tester.pumpWidget(
        wrapWithBaseApp(tagMenuItem),
      );
      final Finder resultSearch = find.byType(TagMenuItem);

      await tester.tap(resultSearch);
      await tester.pumpAndSettle();
      verify(
        () => dumb.callWithParam1("/rota"),
      ).called(1);
    });
  });
}
