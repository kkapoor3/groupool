import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/makeATrip.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('make a trip test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new makeATrip()));

    expect(find.text("Select the dates "), findsOneWidget);

    await tester.enterText(
        find.byKey(new Key('tripNameKey')), 'tripNameFieldTest');

    expect(find.text('tripNameFieldTest'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('sourceKey')), 'sourceFieldTest');

    expect(find.text('sourceFieldTest'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('destKey')), 'destFieldTest');

    expect(find.text('destFieldTest'), findsOneWidget);

    await tester.tap(find.byKey(new Key('addTripKey')));
  });
}
