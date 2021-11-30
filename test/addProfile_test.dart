import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/addProfile.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('add profile test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new AddProfile()));

    expect(find.text("Enter Details"), findsOneWidget);

    await tester.enterText(find.byKey(new Key('emailKey')), 'emailFieldTest');

    expect(find.text('emailFieldTest'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('nameKey')), 'nameFieldTest');

    expect(find.text('nameFieldTest'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('sourceKey')), 'sourceFieldTest');

    expect(find.text('sourceFieldTest'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('destKey')), 'destFieldTest');

    expect(find.text('destFieldTest'), findsOneWidget);

    await tester.tap(find.byKey(new Key('addProfileKey')));

  });
}
