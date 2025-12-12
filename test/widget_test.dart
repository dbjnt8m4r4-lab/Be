// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:to_be/main.dart';

void main() {
  testWidgets('App builds and shows splash title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(MyApp(sharedPreferences: prefs));
    // let any async delegates initialize
    await tester.pump();

    // Verify that the splash screen title is shown.
    expect(find.text('To Be'), findsOneWidget);
  });
}
