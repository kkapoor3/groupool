import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/Commutes.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('commutes test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new Commutes()));
  });
}
