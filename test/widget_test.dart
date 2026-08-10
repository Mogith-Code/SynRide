import 'package:flutter_test/flutter_test.dart';
import 'package:syncride/app.dart';

void main() {
  testWidgets('SyncRideApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SyncRideApp());

    // Verify that WelcomeSplashScreen contains SyncRide app title
    expect(find.text('SyncRide'), findsWidgets);
    expect(find.text('Get Started'), findsOneWidget);
  });
}

