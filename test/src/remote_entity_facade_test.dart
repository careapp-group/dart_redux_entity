import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_entity/redux_entity.dart';
import 'package:test/test.dart';

import '../fixtures/book.dart';

class MockStore extends Mock implements Store {}

void main() {
  group(RemoteEntityFacade, () {
    late MockStore store;
    late RemoteEntityFacade<String, BookModel> facade;

    setUp(() {
      store = MockStore();
      facade = RemoteEntityFacade<String, BookModel>(store);
    });

    test('createOne', () {
      facade.createOne(AnimalFarm);
      verify(store.dispatch(argThat(isA<RequestCreateOne<BookModel>>())));
    });
    test('createMany', () {
      facade.createMany(<BookModel>[AnimalFarm, TheGreatGatsby]);
      verify(store.dispatch(argThat(isA<RequestCreateMany<BookModel>>())));
    });
    test('requestOne', () {
      facade.requestOne('id');
      verify(store
          .dispatch(argThat(isA<RequestRetrieveOne<String, BookModel>>())));
    });
    test('requestMany', () {
      facade.requestMany(['id1', 'id2']);
      verify(store
          .dispatch(argThat(isA<RequestRetrieveMany<String, BookModel>>())));
    });
    test('requestAll', () {
      facade.requestAll();
      verify(store.dispatch(argThat(isA<RequestRetrieveAll<BookModel>>())));
    });
    test('updateOne', () {
      facade.updateOne(AnimalFarm);
      verify(store.dispatch(argThat(isA<RequestUpdateOne<BookModel>>())));
    });
    test('updateMany', () {
      facade.updateMany(<BookModel>[AnimalFarm, TheGreatGatsby]);
      verify(store.dispatch(argThat(isA<RequestUpdateMany<BookModel>>())));
    });
    test('deleteOne', () {
      facade.deleteOne('id');
      verify(
          store.dispatch(argThat(isA<RequestDeleteOne<String, BookModel>>())));
    });
    test('deleteMany', () {
      facade.deleteMany(['id1', 'id2']);
      verify(
          store.dispatch(argThat(isA<RequestDeleteMany<String, BookModel>>())));
    });
  });
}
