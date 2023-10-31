import 'package:redux_entity/redux_entity.dart';
import 'package:test/test.dart';

import '../fixtures/book.dart';

void main() {
  group(UnsortedEntityStateAdapter, () {
    late EntityStateAdapter<String, BookModel> adapter;
    late EntityState<String, BookModel> state;

    setUp(() {
      adapter = UnsortedEntityStateAdapter<String, BookModel>(
          selectId: (BookModel book) => book.id as String);

      state = EntityState<String, BookModel>();
    });

    test('should let you add one entity to the state', () {
      var withOneEntity = adapter.addOne(TheGreatGatsby, state);
      expect(withOneEntity.ids.length, 1);
      expect(withOneEntity.ids.contains('tgg'), true);
      expect(withOneEntity.entities['tgg'], TheGreatGatsby);
    });

    test('should not change state if you attempt to re-add an entity', () {
      var withOneEntity = adapter.addOne(TheGreatGatsby, state);
      var readded = adapter.addOne(TheGreatGatsby, withOneEntity);
      expect(readded, withOneEntity);
    });

    test('should let you add many entities to the state', () {
      var withOneEntity = adapter.addOne(TheGreatGatsby, state);

      var withManyMore =
          adapter.addMany([AClockworkOrange, AnimalFarm], withOneEntity);

      expect(withManyMore.ids,
          containsAll([TheGreatGatsby.id, AClockworkOrange.id, AnimalFarm.id]));
      expect(withManyMore.entities[TheGreatGatsby.id], TheGreatGatsby);
      expect(withManyMore.entities[AClockworkOrange.id], AClockworkOrange);
      expect(withManyMore.entities[AnimalFarm.id], AnimalFarm);
    });

    test('should let you add all entities to the state', () {
      final withOneEntity = adapter.addOne(TheGreatGatsby, state);

      final withAll =
          adapter.addAll([AClockworkOrange, AnimalFarm], withOneEntity);

      expect(withAll.ids.length, 2);
      expect(withAll.ids, containsAll([AClockworkOrange.id, AnimalFarm.id]));

      expect(withAll.entities[AClockworkOrange.id], AClockworkOrange);
      expect(withAll.entities[AnimalFarm.id], AnimalFarm);
      expect(withAll.entities.containsKey(TheGreatGatsby.id), false);
    });

    test('should let you add remove an entity from the state', () {
      final withOneEntity = adapter.addOne(TheGreatGatsby, state);

      final withoutOne =
          adapter.removeOne(TheGreatGatsby.id as String, withOneEntity);

      expect(withoutOne.ids.length, 0);
      expect(withoutOne.entities.length, 0);
    });

    test('should let you remove many entities by id from the state', () {
      final withAll =
          adapter.addAll([TheGreatGatsby, AClockworkOrange, AnimalFarm], state);

      final withoutMany = adapter.removeMany(
          [TheGreatGatsby.id as String, AClockworkOrange.id as String],
          withAll);

      expect(withoutMany.ids.length, 1);
      expect(withoutMany.entities.length, 1);
      expect(withoutMany.ids, contains(AnimalFarm.id));
      expect(withoutMany.entities[AnimalFarm.id], AnimalFarm);
    });

    //test('should let you remove many entities by a predicate from the state', ()  {
    //  final withAll = adapter.addAll(
    //    [TheGreatGatsby, AClockworkOrange, AnimalFarm],
    //    state
    //  );

    //  final withoutMany = adapter.removeMany(p  p.id.startsWith('a'), withAll);

    //  expect(withoutMany).toEqual({
    //    ids: [TheGreatGatsby.id],
    //    entities: {
    //      [TheGreatGatsby.id]: TheGreatGatsby,
    //    },
    //  });
    //});

    test('should let you remove all entities from the state', () {
      final withAll =
          adapter.addAll([TheGreatGatsby, AClockworkOrange, AnimalFarm], state);

      final withoutAll = adapter.removeAll(withAll);

      expect(withoutAll.ids.length, 0);
      expect(withoutAll.entities.length, 0);
    });

    test('should let you update an entity in the state', () {
      final withOne = adapter.addOne(TheGreatGatsby, state);
      final changes = BookModel(id: TheGreatGatsby.id, title: 'A New Hope');

      final withUpdates = adapter.updateOne(changes, withOne);

      expect(withUpdates.ids, containsAll([TheGreatGatsby.id]));
      expect(withUpdates.entities[TheGreatGatsby.id], changes);
    });

    test(
        'should not change state if you attempt to update an entity that has not been added',
        () {
      final withUpdates = adapter.updateOne(
          BookModel(
            id: TheGreatGatsby.id,
            title: 'A New Title',
          ),
          state);

      expect(withUpdates, state);
    });

    test('should let you update many entities by id in the state', () {
      final firstChange = BookModel(
        id: TheGreatGatsby.id,
        title: 'First Change',
      );
      final secondChange = BookModel(
        id: AClockworkOrange.id,
        title: 'Second Change',
      );

      final withMany =
          adapter.addAll([TheGreatGatsby, AClockworkOrange], state);

      final withUpdates =
          adapter.updateMany([firstChange, secondChange], withMany);

      expect(withUpdates.ids,
          containsAll([TheGreatGatsby.id, AClockworkOrange.id]));
      expect(withUpdates.entities[TheGreatGatsby.id], firstChange);
      expect(withUpdates.entities[AClockworkOrange.id], secondChange);
    });

    test('should let you add one entity to the state with upsert()', () {
      final withOneEntity = adapter.upsertOne(TheGreatGatsby, state);
      expect(withOneEntity.ids.length, 1);
      expect(withOneEntity.ids, containsAll([TheGreatGatsby.id]));
      expect(withOneEntity.entities[TheGreatGatsby.id], TheGreatGatsby);
    });

    test('should let you update an entity in the state with upsert()', () {
      final withOne = adapter.addOne(TheGreatGatsby, state);
      final changes = BookModel(id: TheGreatGatsby.id, title: 'A New Hope');

      final withUpdates = adapter.upsertOne(changes, withOne);
      expect(withUpdates.ids.length, 1);
      expect(withUpdates.ids, containsAll([TheGreatGatsby.id]));
      expect(withUpdates.entities[TheGreatGatsby.id], changes);
    });

    test('should let you upsert many entities in the state', () {
      final firstChange =
          BookModel(id: TheGreatGatsby.id, title: 'First Change');
      final withMany = adapter.addAll([TheGreatGatsby], state);

      final withUpserts =
          adapter.upsertMany([firstChange, AClockworkOrange], withMany);

      expect(withUpserts.ids.length, 2);
      expect(withUpserts.ids,
          containsAll([TheGreatGatsby.id, AClockworkOrange.id]));
      expect(withUpserts.entities[TheGreatGatsby.id], firstChange);
      expect(withUpserts.entities[AClockworkOrange.id], AClockworkOrange);
    });
  });
}
