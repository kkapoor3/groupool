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

    expect(find.text('Enter Details'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('emailKey')), 'emailFieldTest');

    await tester.enterText(find.byKey(new Key('nameKey')), 'nameFieldTest');

    await tester.enterText(find.byKey(new Key('sourceKey')), 'sourceFieldTest');

    await tester.enterText(
        find.byKey(new Key('destinationKey')), 'destinationFieldTest');

    await tester.enterText(find.byKey(new Key('inTimeKey')), 'inTimeFieldTest');

    await tester.enterText(
        find.byKey(new Key('outTimeKey')), 'outTimeFieldTest');

    expect(find.text('emailFieldTest'), findsOneWidget);

    expect(find.text('nameFieldTest'), findsOneWidget);

    expect(find.text('sourceFieldTest'), findsOneWidget);

    expect(find.text('destinationFieldTest'), findsOneWidget);

    expect(find.text('inTimeFieldTest'), findsOneWidget);
    expect(find.text('outTimeFieldTest'), findsOneWidget);

    await tester.tap(find.byKey(new Key('submitKey')));
  });
}
