import 'package:adaptive_design_widgets/src/consts/design_system.dart';
import 'package:adaptive_design_widgets/src/design_ancestor.dart';
import 'package:flutter/material.dart' show ButtonBar, Icons, TextButton;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Test DesignAncestor behaviour',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        testWidgetGenerator(initialDesignSystem: DesignSystem.material),
      );

      await widgetTester.pumpAndSettle();

      // Verify initial state matches what is expected by setting DesignAncestor.initialDesignSystem
      expect(
        find.text(
          'Direct Access: Design system is ${DesignSystem.material.name}',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Design System is ${DesignSystem.material.name}'),
        findsOneWidget,
      );

      final refreshButtonFinder = find.byKey(const ValueKey('Refresh'));

      String previousDirectAccessMessage =
          'Direct Access: Design system is ${DesignSystem.material.name}';

      // Iteratively press all buttons and verify that the behaviour is consistent.
      for (DesignSystem designSystem in DesignSystem.values) {
        final buttonFinder = find.byKey(ValueKey(designSystem));
        await widgetTester.tap(buttonFinder);
        await widgetTester.pumpAndSettle();

        expect(
          find.text(
            previousDirectAccessMessage,
          ),
          findsOneWidget,
        );
        expect(
          find.text('Design System is ${designSystem.name}'),
          findsOneWidget,
        );

        await widgetTester.tap(refreshButtonFinder);
        await widgetTester.pumpAndSettle();

        expect(
          find.text(
            'Direct Access: Design system is ${designSystem.name}',
          ),
          findsOneWidget,
        );
        expect(
          find.text('Design System is ${designSystem.name}'),
          findsOneWidget,
        );

        previousDirectAccessMessage =
            'Direct Access: Design system is ${designSystem.name}';
      }
    },
  );
}

Widget testWidgetGenerator({
  required DesignSystem initialDesignSystem,
}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: DesignAncestor(
      initialDesignSystem: initialDesignSystem,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              StatefulBuilder(builder: (context, setState) {
                DesignSystem system = DesignSystem.of(context);
                return Row(
                  children: [
                    GestureDetector(
                      key: const ValueKey('Refresh'),
                      onTap: () {
                        setState(() {});
                      },
                      child: const Icon(Icons.refresh),
                    ),
                    Text(
                      'Direct Access: Design system is ${system.name}',
                    ),
                  ],
                );
              }),
              ValueListenableBuilder(
                valueListenable: DesignAncestor.designSystemNotifierOf(context),
                builder: (
                  context,
                  value,
                  child,
                ) {
                  return Text('Design System is ${value.name}');
                },
              ),
              ButtonBar(
                children: List<TextButton>.generate(
                  DesignSystem.values.length,
                  (index) => TextButton(
                    key: ValueKey<DesignSystem>(DesignSystem.values[index]),
                    onPressed: () {
                      DesignAncestor.setDesignSystemOf(
                          context, DesignSystem.values[index]);
                    },
                    child: Text(DesignSystem.values[index].name),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
