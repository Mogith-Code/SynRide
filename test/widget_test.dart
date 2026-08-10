import 'package:flutter_test/flutter_test.dart';
import 'package:syncride/app.dart';

void main() {
  testWidgets('SyncRideApp main render test', (WidgetTester tester) async {
    // Build SyncRide app and trigger a frame.
    await tester.pumpWidget(const SyncRideApp());

    // Verify app renders correctly without crashing
    expect(find.byType(SyncRideApp), findsOneWidget);
  });
}
