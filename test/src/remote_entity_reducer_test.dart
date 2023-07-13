import 'package:faker/faker.dart';
import 'package:redux_entity/redux_entity.dart';
import 'remote_entity_reducer_tester.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import '../fixtures/book.dart';

void main() {
  group(RemoteEntityReducerTester, () {
    final EntityFactory<BookModel> generator =
        () => BookModel(id: Uuid().v4(), title: faker.lorem.sentence());
    final RemoteEntityReducer<RemoteEntityState<BookModel>, BookModel> reducer =
        RemoteEntityReducer<RemoteEntityState<BookModel>, BookModel>();
    final tester = RemoteEntityReducerTester<
        RemoteEntityReducer<RemoteEntityState<BookModel>, BookModel>,
        RemoteEntityState<BookModel>,
        BookModel>();

    return tester.testAll(reducer, generator, RemoteEntityState<BookModel>());
  });

  group(RemoteEntityReducer, () {
    final RemoteEntityReducer<RemoteEntityState<BookModel>, BookModel> reducer =
        RemoteEntityReducer<RemoteEntityState<BookModel>, BookModel>();

    group(RequestCreateOne, () {
      test('Should set creating true', () {
        final RemoteEntityState<BookModel> result = reducer.call(
            new RemoteEntityState<BookModel>(),
            RequestCreateOne<BookModel>(
              BookModel(title: 'asdf'),
            ));
        expect(result.creating, true);
      });

      test('Should clear error', () {
        final RemoteEntityState<BookModel> result = reducer.call(
            new RemoteEntityState<BookModel>(error: 'some error'),
            RequestCreateOne<BookModel>(
              BookModel(title: 'asdf'),
            ));
        expect(result.error, false);
      });
    });

    group(RequestCreateOneWith, () {
      test('Should set creating true', () {
        final RemoteEntityState<BookModel> result = reducer.call(
            new RemoteEntityState<BookModel>(),
            RequestCreateOneWith<BookModel, String>('Book Name'));
        expect(result.creating, true);
      });
      test('Should ignore actions for other entity types', () {
        final RemoteEntityState<BookModel> result = reducer.call(
            new RemoteEntityState<BookModel>(),
            RequestCreateOneWith<String, String>('Book Name'));
        expect(result.creating, false);
      });

      test('Should clear error', () {
        final RemoteEntityState<BookModel> result = reducer.call(
            new RemoteEntityState<BookModel>(error: 'some error'),
            RequestCreateOneWith<BookModel, String>('Book Name'));
        expect(result.error, false);
      });
    });
    group(SuccessCreateOne, () {
      test('new item should be added to store', () {
        final result = reducer.call(new RemoteEntityState<BookModel>(),
            SuccessCreateOne<BookModel>(BookModel(id: '2345', title: 'test')));
        expect(result.entities['2345']!.title, 'test');
      });

      test('creating should be false', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: true),
            new SuccessCreateOne<BookModel>(
                BookModel(id: '2345', title: 'test')));
        expect(result.creating, false);
      });
    });
    group(FailCreateOne, () {
      test('creating should be false', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: true),
            new FailCreateOne<BookModel>(
                entity: new BookModel(title: 'test'), error: 'Some error'));
        expect(result.creating, false);
      });
      test('sets an error', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: true),
            new FailCreateOne<BookModel>(
                entity: new BookModel(title: 'test'), error: 'Some error'));
        expect(result.error, 'Some error');
      });
    });

    group(RequestCreateMany, () {
      test('Should set creating true', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: false),
            new RequestCreateMany<BookModel>(
                [BookModel(title: 'test'), BookModel(title: 'asdf')]));
        expect(result.creating, true);
      });
      test('Should clear error', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: false),
            new RequestCreateMany<BookModel>(
                [BookModel(title: 'test'), BookModel(title: 'asdf')]));
        expect(result.error, false);
      });
    });
    group(SuccessCreateMany, () {
      test('new items should be added to store', () {
        final result = reducer.call(
            new RemoteEntityState<BookModel>(creating: true),
            new SuccessCreateMany<BookModel>([
              BookModel(id: 'a', title: 'test'),
              BookModel(id: 'b', title: 'asdf')
            ]));
        expect(result.entities['a']!.title, 'test');
        expect(result.entities['b']!.title, 'asdf');
      });
      test('creating should be false', () {
        final result = reducer.call(
          new RemoteEntityState<BookModel>(creating: true),
          new SuccessCreateMany<BookModel>(
            [
              BookModel(id: 'a', title: 'test'),
              BookModel(id: 'b', title: 'asdf')
            ],
          ),
        );
        expect(result.creating, false);
      });
    });
    group(FailCreateMany, () {
      test('creating should be false', () {
        final result = reducer.call(
          new RemoteEntityState<BookModel>(creating: true),
          new FailCreateMany<BookModel>(entities: [
            BookModel(id: 'a', title: 'test'),
            BookModel(id: 'b', title: 'asdf')
          ], error: 'error'),
        );
        expect(result.creating, false);
      });
      test('Should set the error', () {
        final result = reducer.call(
          new RemoteEntityState<BookModel>(creating: true),
          new FailCreateMany<BookModel>(entities: [
            BookModel(id: 'a', title: 'test'),
            BookModel(id: 'b', title: 'asdf')
          ], error: 'error'),
        );
        expect(result.error, 'error');
      });
    });

    group(RequestRetrieveOne, () {
      test('Should set loading for element true', () {
        final result = reducer.call(new RemoteEntityState<BookModel>(),
            new RequestRetrieveOne<BookModel>('asdf'));
        expect(result.loadingIds['asdf'], true);
      });
      test('Should clear error', () {
        final result = reducer.call(new RemoteEntityState<BookModel>(),
            new RequestRetrieveOne<BookModel>('asdf'));
        expect(result.error, false);
      });
    });
    group(SuccessRetrieveOne, () {
      test('item should be added to store', () {
        final result = reducer.call(
            new RemoteEntityState(loadingIds: {'a': true}),
            new SuccessRetrieveOne<BookModel>(
                BookModel(id: 'a', title: 'test')));
        expect(result.entities['a']!.title, 'test');
      });
      test('Should set loading for element false', () {
        final result = reducer.call(
            new RemoteEntityState(loadingIds: {'a': true}),
            new SuccessRetrieveOne<BookModel>(
                BookModel(id: 'a', title: 'test')));
        expect(result.loadingIds['a'], false);
      });
    });
    group(FailRetrieveOne, () {
      test('Should set loading for element false', () {
        final result = reducer.call(
          new RemoteEntityState<BookModel>(loadingIds: {'a': true}),
          new FailRetrieveOne<BookModel>(id: 'a', error: 'error'),
        );
        expect(result.loadingIds['a'], false);
      });
      test('Should set the error', () {
        final result = reducer.call(
          new RemoteEntityState(loadingIds: {'a': true}),
          new FailRetrieveOne<BookModel>(id: 'a', error: 'error'),
        );
        expect(result.error, 'error');
      });
    });

    group(RequestRetrieveAll, () {
      test('Should set loadingAll true', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(), RequestRetrieveAll<BookModel>());
        expect(result.loadingAll, true);
      });
      test('Should clear error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(), RequestRetrieveAll<BookModel>());
        expect(result.error, false);
      });
    });

    group(SuccessRetrieveAll, () {
      test('items should be added to store', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                loadingIds: {'a': true, 'b': true, 'c': true}),
            SuccessRetrieveAll([
              BookModel(id: 'a', title: 'test'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ]));
        expect(result.entities['a']!.title, 'test');
        expect(result.entities['b']!.title, 'testb');
        expect(result.entities['c']!.title, 'testc');
      });
      test('Should set loadingAll false', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                loadingIds: {'a': true, 'b': true, 'c': true}),
            SuccessRetrieveAll([
              BookModel(id: 'a', title: 'test'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ]));
        expect(result.loadingAll, false);
      });
    });
    group(FailRetrieveAll, () {
      test('Should set loadingAll false', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                loadingIds: {'a': true, 'b': true, 'c': true}),
            FailRetrieveAll('error'));
        expect(result.loadingAll, false);
      });
      test('Should set the error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                loadingIds: {'a': true, 'b': true, 'c': true}),
            FailRetrieveAll<BookModel>('error'));
        expect(result.error, 'error');
      });
    });

    group('REQUEST UPDATE ONE', () {
      test('Should set loading for element true', () {
        final result = reducer.call(RemoteEntityState<BookModel>(),
            RequestUpdateOne<BookModel>(BookModel(id: 'a', title: 'test')));
        expect(result.loadingIds['a'], true);
      });
      test('Should clear error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(error: 'testerror'),
            RequestUpdateOne<BookModel>(BookModel(id: 'a', title: 'test')));
        expect(result.error, false);
      });
    });
    group(SuccessUpdateOne, () {
      test('item should be added to store', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {'a': true},
                entities: {'a': BookModel(id: 'a', title: 'asdf')},
                ids: ['a']),
            SuccessUpdateOne(BookModel(id: 'a', title: 'test')));
        expect(result.entities['a']!.title, 'test');
      });
      test('Should set loading for element false', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {'a': true},
                entities: {'a': BookModel(id: 'a', title: 'asdf')},
                ids: ['a']),
            SuccessUpdateOne(BookModel(id: 'a', title: 'test')));
        expect(result.loadingIds['a'], false);
      });
    });
    group(FailUpdateOne, () {
      test('Should set loading for element false', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {'a': true},
                entities: {'a': BookModel(id: 'a', title: 'asdf')},
                ids: ['a']),
            FailUpdateOne<BookModel>(
                entity: BookModel(id: 'a'), error: 'error'));
        expect(result.loadingIds['a'], false);
      });
      test('Should set the error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {'a': true},
                entities: {'a': BookModel(id: 'a', title: 'asdf')},
                ids: ['a']),
            FailUpdateOne<BookModel>(
                entity: BookModel(id: 'a'), error: 'error'));
        expect(result.error, 'error');
      });
    });

    group(RequestUpdateMany, () {
      test('Should set loading for each element true', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(),
            RequestUpdateMany<BookModel>([
              BookModel(id: 'a', title: 'testa'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ]));
        expect(result.loadingIds['a'], true);
        expect(result.loadingIds['b'], true);
        expect(result.loadingIds['c'], true);
      });
      test('Should clear error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(),
            RequestUpdateMany<BookModel>([
              BookModel(id: 'a', title: 'testa'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ]));
        expect(result.error, false);
      });
    });
    group(SuccessUpdateMany, () {
      test('items should be added to store', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true,
                'b': true,
                'c': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          SuccessUpdateMany<BookModel>(
            [
              BookModel(id: 'a', title: 'testa'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ],
          ),
        );
        expect(result.entities['a']!.title, 'testa');
        expect(result.entities['b']!.title, 'testb');
        expect(result.entities['c']!.title, 'testc');
      });
      test('Should set loading for each element false', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true,
                'b': true,
                'c': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          SuccessUpdateMany<BookModel>(
            [
              BookModel(id: 'a', title: 'testa'),
              BookModel(id: 'b', title: 'testb'),
              BookModel(id: 'c', title: 'testc')
            ],
          ),
        );
        expect(result.loadingIds['a'], false);
        expect(result.loadingIds['b'], false);
        expect(result.loadingIds['c'], false);
      });
    });
    group(FailUpdateMany, () {
      test('Should set loading for each element false', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true,
                'b': true,
                'c': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          FailUpdateMany<BookModel>(entities: [
            BookModel(id: 'a'),
            BookModel(id: 'b'),
            BookModel(id: 'c')
          ], error: 'error'),
        );
        expect(result.loadingIds['a'], false);
        expect(result.loadingIds['b'], false);
        expect(result.loadingIds['c'], false);
      });
      test('Should set the error', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true,
                'b': true,
                'c': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          FailUpdateMany<BookModel>(entities: [
            BookModel(id: 'a'),
            BookModel(id: 'b'),
            BookModel(id: 'c')
          ], error: 'error'),
        );
        expect(result.error, 'error');
      });
    });

    group(RequestDeleteOne, () {
      test('Should set loading for element true', () {
        final result =
            reducer.call(RemoteEntityState(), RequestDeleteOne<BookModel>('a'));
        expect(result.loadingIds['a'], true);
      });
      test('Should clear error', () {
        final result = reducer.call(RemoteEntityState(error: 'testerror'),
            RequestDeleteOne<BookModel>('a'));
        expect(result.error, false);
      });
    });
    group('SUCCESS DELETE ONE', () {
      test('item should be removed from store', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {
                  'a': true
                },
                entities: {
                  'a': BookModel(id: 'a', title: 'asdf1'),
                  'b': BookModel(id: 'b', title: 'asdf2'),
                  'c': BookModel(id: 'c', title: 'asdf3')
                },
                ids: [
                  'a',
                  'b',
                  'c'
                ]),
            SuccessDeleteOne<BookModel>('a'));
        expect(result.entities['a'], null);
      });
      test('Should set loading for element false', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          SuccessDeleteOne<BookModel>('a'),
        );
        expect(result.loadingIds['a'], false);
      });
    });
    group(FailDeleteOne, () {
      test('Should set loading for element false', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          FailDeleteOne<BookModel>(id: 'a', error: 'error'),
        );
        expect(result.loadingIds['a'], false);
      });
      test('Should set error', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          FailDeleteOne<BookModel>(id: 'a', error: 'error'),
        );
        expect(result.error, 'error');
      });
    });

    group('REQUEST DELETE MANY', () {
      test('Should set loading for each element true', () {
        final result = reducer.call(RemoteEntityState<BookModel>(),
            RequestDeleteMany<BookModel>(['a', 'b', 'c']));
        expect(result.loadingIds['a'], true);
        expect(result.loadingIds['b'], true);
        expect(result.loadingIds['c'], true);
      });
      test('Should clear error', () {
        final result = reducer.call(RemoteEntityState<BookModel>(),
            RequestDeleteMany<BookModel>(['a', 'b', 'c']));
        expect(result.error, false);
      });
    });
    group('SUCCESS DELETE MANY', () {
      test('items should be removed fromstore', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          SuccessDeleteMany<BookModel>(['a', 'b', 'c']),
        );
        expect(result.entities['a'], null);
        expect(result.entities['d'], null);
        expect(result.entities['c'], null);
      });
      test('Should set loading for each element false', () {
        final result = reducer.call(
          RemoteEntityState<BookModel>(
              creating: false,
              loadingAll: false,
              loadingIds: {
                'a': true
              },
              entities: {
                'a': BookModel(id: 'a', title: 'asdf1'),
                'b': BookModel(id: 'b', title: 'asdf2'),
                'c': BookModel(id: 'c', title: 'asdf3')
              },
              ids: [
                'a',
                'b',
                'c'
              ]),
          SuccessDeleteMany<BookModel>(['a', 'b', 'c']),
        );
        expect(result.loadingIds['a'], false);
        expect(result.loadingIds['b'], false);
        expect(result.loadingIds['c'], false);
      });
    });
    group('FAIL DELETE MANY', () {
      test('Should set loading for each element false', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {
                  'a': true,
                  'b': true,
                  'c': true
                },
                entities: {
                  'a': BookModel(id: 'a', title: 'asdf1'),
                  'b': BookModel(id: 'b', title: 'asdf2'),
                  'c': BookModel(id: 'c', title: 'asdf3')
                },
                ids: [
                  'a',
                  'b',
                  'c'
                ]),
            FailDeleteMany<BookModel>(ids: ['a', 'b', 'c'], error: 'error'));
        expect(result.loadingIds['a'], false);
        expect(result.loadingIds['b'], false);
        expect(result.loadingIds['c'], false);
      });
      test('Should set error', () {
        final result = reducer.call(
            RemoteEntityState<BookModel>(
                creating: false,
                loadingAll: false,
                loadingIds: {
                  'a': true,
                  'b': true,
                  'c': true
                },
                entities: {
                  'a': BookModel(id: 'a', title: 'asdf1'),
                  'b': BookModel(id: 'b', title: 'asdf2'),
                  'c': BookModel(id: 'c', title: 'asdf3')
                },
                ids: [
                  'a',
                  'b',
                  'c'
                ]),
            FailDeleteMany<BookModel>(ids: ['a', 'b', 'c'], error: 'error'));
        expect(result.error, 'error');
      });
    });
  });
}
