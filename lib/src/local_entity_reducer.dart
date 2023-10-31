import 'package:redux/redux.dart';
import 'package:redux_entity/redux_entity.dart';

import './typedefs.dart';

class LocalEntityReducer<S extends EntityState<K, T>, K, T>
    extends ReducerClass<S> {
  LocalEntityReducer({
    IdSelector<K, T>? selectId,
  }) : adapter = UnsortedEntityStateAdapter<K, T>(selectId: selectId);

  final UnsortedEntityStateAdapter<K, T> adapter;

  S call(S state, action) {
    if (action is CreateOne<T>) {
      return this.adapter.addOne(action.entity, state);
    }
    if (action is UpdateOne<T>) {
      return this.adapter.upsertOne(action.entity, state);
    }
    if (action is DeleteOne<K, T>) {
      return adapter.removeOne(action.id, state);
    }

    return state;
  }
}
