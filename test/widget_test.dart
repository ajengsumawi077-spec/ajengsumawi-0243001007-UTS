import 'package:flutter_test/flutter_test.dart';
import 'package:nyaah_lembur/main.dart';

void main() {
  testWidgets('Nyaah Lembur page is the application root', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(NyaahLemburPage), findsOneWidget);
  });
}
