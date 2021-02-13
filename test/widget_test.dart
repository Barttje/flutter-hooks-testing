import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hooks_testing/main.dart';

void main() {
  testWidgets('Testing the UseState Example', (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseStateExample());
    }));
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    // The widget is now marked for rebuild, but the rebuilt has not yet been triggered
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // We do now trigger the rebuilt
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Testing the Use Value Changed Example',
      (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseValueChangedExample());
    }));
    expect(find.text('0'), findsOneWidget);
    expect(find.text('2'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Testing the useEffect on first build',
      (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseEffectOnceExample());
    }));
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Testing useEffect with watch on value',
      (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseEffectValueChangedExample());
    }));
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('3'), findsOneWidget);

    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Testing useEffect on each built', (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseEffectEachBuildExample());
    }));
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Test the useAnimation Hook', (WidgetTester tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      return MaterialApp(home: UseAnimationExample());
    }));
    expect(find.text('0.0'), findsOneWidget);

    await tester.pump(Duration(milliseconds: 500));

    expect(find.text('0.5'), findsOneWidget);

    await tester.pump(Duration(milliseconds: 500));
    expect(find.text('1.0'), findsOneWidget);
  });
}
