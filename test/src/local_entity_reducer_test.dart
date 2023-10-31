import 'package:redux_entity/redux_entity.dart';
import 'package:test/test.dart';

import '../fixtures/book.dart';
import '../fixtures/room.dart';

void main() {
  group(LocalEntityReducer, () {
    final bookReducer =
        LocalEntityReducer<EntityState<String, BookModel>, String, BookModel>();
    final roomReducer =
        LocalEntityReducer<EntityState<int, RoomModel>, int, RoomModel>();

    group(CreateOne, () {
      test('new item should be added to store', () {
        final result = bookReducer.call(new EntityState<String, BookModel>(),
            CreateOne<BookModel>(BookModel(id: '2345', title: 'test')));
        expect(result.entities['2345']!.title, 'test');
      });

      test('new item with int id should be added to the store', () {
        final result = roomReducer.call(new EntityState<int, RoomModel>(),
            CreateOne<RoomModel>(RoomModel(id: 2345, name: 'test')));
        expect(result.entities[2345]!.name, 'test');
      });
    });
    group(UpdateOne, () {
      test('item should be added to store', () {
        final result = bookReducer.call(
            EntityState<String, BookModel>(
                entities: {'a': BookModel(id: 'a', title: 'asdf')}, ids: ['a']),
            UpdateOne(BookModel(id: 'a', title: 'test')));
        expect(result.entities['a']!.title, 'test');
      });

      test('item with int id should be added to store', () {
        final result = roomReducer.call(
            EntityState<int, RoomModel>(
                entities: {123: RoomModel(id: 123, name: 'asdf')}, ids: [123]),
            UpdateOne(RoomModel(id: 123, name: 'test')));
        expect(result.entities[123]!.name, 'test');
      });
    });
    group(DeleteOne, () {
      test('item should be removed from store', () {
        final result = bookReducer.call(
            EntityState<String, BookModel>(entities: {
              'a': BookModel(id: 'a', title: 'asdf1'),
              'b': BookModel(id: 'b', title: 'asdf2'),
              'c': BookModel(id: 'c', title: 'asdf3')
            }, ids: [
              'a',
              'b',
              'c'
            ]),
            DeleteOne<String, BookModel>('a'));
        expect(result.entities['a'], null);
      });

      test('item with int id should be removed from store', () {
        final result = roomReducer.call(
            EntityState<int, RoomModel>(entities: {
              1: RoomModel(id: 1, name: 'asdf1'),
              2: RoomModel(id: 2, name: 'asdf2'),
              3: RoomModel(id: 3, name: 'asdf3')
            }, ids: [
              1,
              2,
              3,
            ]),
            DeleteOne<int, RoomModel>(1));
        expect(result.entities[1], null);
      });
    });
  });
}
