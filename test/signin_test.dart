import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/signin.dart';

class SigninTesting extends StatefulWidget {
  @override
  SigninTestingState createState() => SigninTestingState();
}

class SigninTestingState extends State<SigninTesting> {
  bool showSignIn;

  void toggleView() {
    setState(() {
      showSignIn = false;
    });
  }

  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testMethod() {
    testWidgets('Signin Test', (WidgetTester tester) async {
      await tester
          .pumpWidget(createWidgetForTesting(child: new SignIn(toggleView)));

      await tester.enterText(find.byKey(new Key('emailKey')), 'emailFieldTest');

      expect(find.text('emailFieldTest'), findsOneWidget);

      await tester.enterText(
          find.byKey(new Key('passwordKey')), 'passwordFieldTest');

      expect(find.text('passwordFieldTest'), findsOneWidget);

      await tester.tap(find.byKey(new Key('forgotPasswordKey')),
          warnIfMissed: false);

      await tester.tap(find.byKey(new Key('signinKey')), warnIfMissed: false);

      await tester.tap(find.byKey(new Key('signupKey')), warnIfMissed: false);

      expect(find.text('GrouPool'), findsOneWidget);

      expect(find.text('Sign In'), findsOneWidget);

      expect(find.text('Forgot Password?'), findsOneWidget);

      expect(find.text('Sign In with Google'), findsOneWidget);

      expect(find.text('Register now'), findsOneWidget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold());
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  SigninTestingState().testMethod();
}

//asd