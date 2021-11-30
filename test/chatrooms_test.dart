import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/chatrooms.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('chat room test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new ChatRoom()));

    expect(find.text('Chats'), findsOneWidget);

    await tester.tap(find.byKey(new Key('showProfileKey')),
        warnIfMissed: false);

    await tester.tap(find.byKey(new Key('projectRoomsKey')),
        warnIfMissed: false);

    await tester.tap(find.byKey(new Key('authenticateKey')),
        warnIfMissed: false);

  });
}
