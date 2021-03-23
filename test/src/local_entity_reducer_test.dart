import 'package:redux_entity/redux_entity.dart';
import 'package:redux_entity/src/local_entity_actions.dart';
import 'package:redux_entity/src/local_entity_reducer.dart';
import 'package:test/test.dart';
import '../fixtures/book.dart';

void main() {
  group(LocalEntityReducer, () {
    final LocalEntityReducer<EntityState<BookModel>, BookModel> reducer =
        LocalEntityReducer<EntityState<BookModel>, BookModel>();

    group(CreateOne, () {
      test('new item should be added to store', () {
        final result = reducer.call(new EntityState<BookModel>(),
            CreateOne<BookModel>(BookModel(id: '2345', title: 'test')));
        expect(result.entities['2345']!.title, 'test');
      });
    });
    group(UpdateOne, () {
      test('item should be added to store', () {
        final result = reducer.call(
            EntityState<BookModel>(
                entities: {'a': BookModel(id: 'a', title: 'asdf')}, ids: ['a']),
            UpdateOne(BookModel(id: 'a', title: 'test')));
        expect(result.entities['a']!.title, 'test');
      });
    });
    group(DeleteOne, () {
      test('item should be removed from store', () {
        final result = reducer.call(
            EntityState<BookModel>(entities: {
              'a': BookModel(id: 'a', title: 'asdf1'),
              'b': BookModel(id: 'b', title: 'asdf2'),
              'c': BookModel(id: 'c', title: 'asdf3')
            }, ids: [
              'a',
              'b',
              'c'
            ]),
            DeleteOne<BookModel>('a'));
        expect(result.entities['a'], null);
      });
    });
  });
}
