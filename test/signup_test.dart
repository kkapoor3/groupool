import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/views/signup.dart';

class SignupTesting extends StatefulWidget {
  @override
  SignupTestingState createState() => SignupTestingState();
}

class SignupTestingState extends State<SignupTesting> {
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
    testWidgets('Signup Test', (WidgetTester tester) async {
      await tester
          .pumpWidget(createWidgetForTesting(child: new SignUp(toggleView)));

      await tester.enterText(
          find.byKey(new Key('usernameKey')), 'usernameFieldTest');

      expect(find.text('usernameFieldTest'), findsOneWidget);

      await tester.enterText(find.byKey(new Key('emailKey')), 'emailFieldTest');

      expect(find.text('emailFieldTest'), findsOneWidget);

      await tester.enterText(
          find.byKey(new Key('passwordKey')), 'passwordFieldTest');

      expect(find.text('passwordFieldTest'), findsOneWidget);

      expect(find.text('Register for GrouPool'), findsOneWidget);

      expect(find.text('Sign Up'), findsOneWidget);

      expect(find.text('Sign Up with Google'), findsOneWidget);

      expect(find.text('SignIn now'), findsOneWidget);

      await tester.tap(find.byKey(new Key('signupKey')), warnIfMissed: false);
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
  SignupTestingState().testMethod();
}
