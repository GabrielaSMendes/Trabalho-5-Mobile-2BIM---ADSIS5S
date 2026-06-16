import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projetofinalflutter/data/datasources/local/favorites_local_datasource.dart';
import 'package:projetofinalflutter/data/datasources/remote/meal_remote_datasource.dart';
import 'package:projetofinalflutter/data/models/meal_model.dart';
import 'package:projetofinalflutter/data/repositories/meal_repository_impl.dart';
import 'package:projetofinalflutter/domain/entities/meal.dart';

class MockRemoteDataSource extends Mock implements MealRemoteDataSource {}
class MockLocalDataSource extends Mock implements FavoritesLocalDataSource {}

void main() {
  late MealRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;

  setUpAll(() {
    // mocktail exige fallback value para tipos usados com any()
    registerFallbackValue(
        const MealModel(id: '', name: '', thumbnail: ''));
  });

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    repository = MealRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  group('toggleFavorite', () {
    const meal = Meal(id: '1', name: 'Chicken Tikka', thumbnail: 'url');

    test('insere favorito quando a refeição ainda não é favorita', () async {
      when(() => mockLocal.isFavorite('1')).thenAnswer((_) async => false);
      when(() => mockLocal.insertFavorite(any())).thenAnswer((_) async {});

      await repository.toggleFavorite(meal);

      verify(() => mockLocal.insertFavorite(any())).called(1);
      verifyNever(() => mockLocal.deleteFavorite(any()));
    });

    test('remove favorito quando a refeição já é favorita', () async {
      when(() => mockLocal.isFavorite('1')).thenAnswer((_) async => true);
      when(() => mockLocal.deleteFavorite('1')).thenAnswer((_) async {});

      await repository.toggleFavorite(meal);

      verify(() => mockLocal.deleteFavorite('1')).called(1);
      verifyNever(() => mockLocal.insertFavorite(any()));
    });
  });

  group('getFavorites', () {
    test('retorna lista de Meal convertendo os modelos', () async {
      final models = [
        const MealModel(id: '10', name: 'Pizza', thumbnail: 'http://p.jpg'),
        const MealModel(id: '11', name: 'Sushi', thumbnail: 'http://s.jpg'),
      ];
      when(() => mockLocal.getFavorites()).thenAnswer((_) async => models);

      final result = await repository.getFavorites();

      expect(result.length, 2);
      expect(result[0].id, '10');
      expect(result[1].name, 'Sushi');
    });

    test('retorna lista vazia quando não há favoritos', () async {
      when(() => mockLocal.getFavorites()).thenAnswer((_) async => []);

      final result = await repository.getFavorites();

      expect(result, isEmpty);
    });
  });
}
