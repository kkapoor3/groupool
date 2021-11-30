import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/addPeople.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('add people test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: new AddPeople(projectId: "abc", people: ['a', 'b', 'c'])));

    expect(find.text("Add People"), findsOneWidget);

    await tester.tap(find.byKey(new Key('addUser')), warnIfMissed: false);

  });
}
