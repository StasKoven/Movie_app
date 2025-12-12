import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_discovery/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('Complete user flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Movie Discovery'), findsWidgets);
      
    });
  });
}
