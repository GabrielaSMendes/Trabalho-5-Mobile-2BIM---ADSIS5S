import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/domain/entities/category.dart';
import 'package:projetofinalflutter/presentation/widgets/category_card.dart';

void main() {
  const category = Category(
    id: '1',
    name: 'Vegetarian',
    thumbnail: '',
    description: 'Receitas vegetarianas',
  );

  Widget buildSubject({required VoidCallback onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 200,
          height: 200,
          child: CategoryCard(category: category, onTap: onTap),
        ),
      ),
    );
  }

  testWidgets('exibe o nome da categoria', (tester) async {
    await tester.pumpWidget(buildSubject(onTap: () {}));
    expect(find.text('Vegetarian'), findsOneWidget);
  });

  testWidgets('chama onTap ao ser tocado', (tester) async {
    var tapped = false;
    await tester.pumpWidget(buildSubject(onTap: () => tapped = true));
    await tester.tap(find.byType(GestureDetector).first);
    expect(tapped, isTrue);
  });

  testWidgets('renderiza um Card como container visual', (tester) async {
    await tester.pumpWidget(buildSubject(onTap: () {}));
    expect(find.byType(Card), findsOneWidget);
  });
}
