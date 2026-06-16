/// Tradução estática das categorias da TheMealDB (API não oferece PT nativamente).
abstract class CategoryTranslation {
  static const _map = {
    'Beef': 'Carne Bovina',
    'Chicken': 'Frango',
    'Dessert': 'Sobremesa',
    'Lamb': 'Cordeiro',
    'Miscellaneous': 'Variados',
    'Pasta': 'Massas',
    'Pork': 'Suíno',
    'Seafood': 'Frutos do Mar',
    'Side': 'Acompanhamentos',
    'Starter': 'Entradas',
    'Vegan': 'Vegano',
    'Vegetarian': 'Vegetariano',
    'Breakfast': 'Café da Manhã',
    'Goat': 'Cabra',
  };

  static String translate(String englishName) =>
      _map[englishName] ?? englishName;
}
