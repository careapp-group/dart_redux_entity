import 'package:redux_entity/redux_entity.dart';
import 'package:redux_entity/src/local_entity_actions.dart';

import './typedefs.dart';
import './unsorted_entity_state_adapter.dart';
import 'package:redux/redux.dart';

class LocalEntityReducer<S extends EntityState<T>, T> extends ReducerClass<S> {
  LocalEntityReducer({
    IdSelector<T>? selectId,
  }) : adapter = UnsortedEntityStateAdapter<T>(selectId: selectId);

  final UnsortedEntityStateAdapter<T> adapter;

  S call(S state, action) {
    if (action is CreateOne<T>) {
      return this.adapter.addOne(action.entity, state);
    }
    if (action is UpdateOne<T>) {
      return this.adapter.upsertOne(action.entity, state);
    }
    if (action is DeleteOne<T>) {
      return adapter.removeOne(action.id, state);
    }

    return state;
  }
}
