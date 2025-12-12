import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_be/main.dart';

void main() {
  testWidgets('Dump Text widgets', (WidgetTester tester) async {
    // Use in-memory shared preferences for tests
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(MyApp(sharedPreferences: prefs));
    await tester.pump();

    final textWidgets = find.byType(Text);
    final count = textWidgets.evaluate().length;

    // ignore: avoid_print
    print('Found Text widgets: $count');
    for (final el in textWidgets.evaluate()) {
      final Text t = el.widget as Text;
      // ignore: avoid_print
      print('Text: "${t.data}"');
    }
  });
}
