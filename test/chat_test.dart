import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/chat.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('chat test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new Chat()));

    await tester.enterText(
        find.byKey(new Key('inputMessageKey')), 'inputMessageFieldTest');

    expect(find.text('inputMessageFieldTest'), findsOneWidget);

    await tester.tap(find.byKey(new Key('addMessageKey')), warnIfMissed: false);
  });
}
