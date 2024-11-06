import 'package:beanstock/core/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ListCard displays title and subtitle',
      (WidgetTester tester) async {
    const String testTitle = 'title';
    const String testSubtitle = 'subtitle';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ListCard(title: testTitle, subtitle: testSubtitle),
        ),
      ),
    );

    expect(find.text(testTitle), findsOneWidget);

    expect(find.text(testSubtitle), findsOneWidget);

    expect(find.byType(Card), findsOneWidget);
  });
}
