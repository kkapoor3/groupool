import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/search.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('search test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new Search()));

    expect(find.text('Connect'), findsOneWidget);

    await tester.enterText(find.byKey(new Key('searchKey')), 'searchFieldTest');

    expect(find.text('searchFieldTest'), findsOneWidget);

    await tester.tap(find.byKey(new Key('initSearchKey')), warnIfMissed: false);
  });
}
