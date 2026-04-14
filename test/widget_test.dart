import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Setup SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GpscApp());

    // Verify basic presence
    expect(find.text('GPSC Prep'), findsOneWidget);
  });
}
