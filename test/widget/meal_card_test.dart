import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/domain/entities/meal.dart';
import 'package:projetofinalflutter/presentation/widgets/meal_card.dart';

void main() {
  const meal = Meal(
    id: '52772',
    name: 'Beef and Mustard Pie',
    thumbnail: '',
  );

  Widget buildSubject({required VoidCallback onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 200,
          height: 200,
          child: MealCard(meal: meal, onTap: onTap),
        ),
      ),
    );
  }

  testWidgets('exibe o nome da refeição', (tester) async {
    await tester.pumpWidget(buildSubject(onTap: () {}));
    expect(find.text('Beef and Mustard Pie'), findsOneWidget);
  });

  testWidgets('chama onTap ao ser tocado', (tester) async {
    var tapped = false;
    await tester.pumpWidget(buildSubject(onTap: () => tapped = true));
    await tester.tap(find.byType(GestureDetector).first);
    expect(tapped, isTrue);
  });

  testWidgets('exibe ícone de fallback quando thumbnail é vazio', (tester) async {
    await tester.pumpWidget(buildSubject(onTap: () {}));
    // thumbnail vazio → Center com Icon(Icons.fastfood)
    expect(find.byIcon(Icons.fastfood), findsOneWidget);
  });
}
