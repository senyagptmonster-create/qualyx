import 'package:flutter_test/flutter_test.dart';
import 'package:qualyx/qualyx_app.dart';

void main() {
  testWidgets('QualyxApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QualyxApp());
    expect(find.byType(QualyxApp), findsOneWidget);
  });
}