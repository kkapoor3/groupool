import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/team.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('team test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new Team()));

    expect(find.text('Pool'), findsOneWidget);

    await tester.tap(find.byKey(new Key('addMessageKey')));
  });
}
