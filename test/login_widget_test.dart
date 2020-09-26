import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';

void main() {
  testWidgets("Test startup", (WidgetTester tester) async {
    Widget widgetUnderTest = MediaQuery(
        data: new MediaQueryData(), child: MaterialApp(home: AuthPage()));

    await tester.pumpWidget(widgetUnderTest);

    expect(find.text(Strings.userPageDescription), findsOneWidget);
  });

  testWidgets("Test Input field", (WidgetTester tester) async {
    Widget widgetUnderTest = MediaQuery(
        data: new MediaQueryData(), child: MaterialApp(home: AuthPage()));

    await tester.pumpWidget(widgetUnderTest);

    await tester.enterText(find.byType(TextField), "g.ahmadi");

    await tester.tap(find.byType(FlatButton));

    await tester.pumpAndSettle();

    expect(find.text(Strings.passPageDescription), findsOneWidget);
  });

  testWidgets("Test Return button", (WidgetTester tester) async {
    Widget widgetUnderTest = MediaQuery(
        data: new MediaQueryData(), child: MaterialApp(home: AuthPage()));

    await tester.pumpWidget(widgetUnderTest);

    await tester.enterText(find.byType(TextField), "g.ahmadi");

    await tester.tap(find.byType(FlatButton));

    await tester.pumpAndSettle();

    expect(find.text(Strings.returnToUsername), findsOneWidget);

    await tester.tap(find.widgetWithText(FlatButton, Strings.returnToUsername));

    await tester.pumpAndSettle();

    expect(find.text(Strings.userPageDescription), findsOneWidget);
  });
}
