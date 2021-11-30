import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/projectRooms.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('project rooms test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new ProjectRooms()));

    expect(find.text("Chat Rooms"), findsOneWidget);

    await tester.tap(find.byKey(new Key('search2Key')), warnIfMissed: false);
  });
}
