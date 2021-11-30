import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/search2.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('search2 test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new Search2()));

    expect(find.text('Create Pool'), findsOneWidget);

    await tester.tap(find.byKey(new Key('createProjectKey')));

    await tester.tap(find.byKey(new Key('initSearchKey')));

  });
}
