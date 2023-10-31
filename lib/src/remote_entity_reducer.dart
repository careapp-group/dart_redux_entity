import 'package:redux/redux.dart';

import './remote_entity_actions.dart';
import './remote_entity_state.dart';
import './typedefs.dart';
import './unsorted_entity_state_adapter.dart';

class RemoteEntityReducer<S extends RemoteEntityState<K, T>, K, T>
    extends ReducerClass<S> {
  RemoteEntityReducer({
    IdSelector<K, T>? selectId,
  }) : adapter = UnsortedEntityStateAdapter<K, T>(selectId: selectId);

  final UnsortedEntityStateAdapter<K, T> adapter;

  S call(S state, action) {
    if (action is RequestCreateOne<T> ||
        action is RequestCreateMany<T> ||
        action is RequestCreateOneWith<T, dynamic> ||
        action is RequestCreateManyWith<T, dynamic>) {
      return state.copyWith(creating: true, error: false) as S;
    }
    if (action is FailCreateOne<T> || action is FailCreateMany<T>) {
      return state.copyWith(creating: false, error: action.error) as S;
    }
    if (action is SuccessCreateOne<T>) {
      return this.adapter.addOne(
            action.entity,
            state.copyWith(
              creating: false,
              updateTimes: <K, DateTime>{
                ...state.updateTimes,
                adapter.getId(action.entity): DateTime.now()
              },
            ) as S,
          );
    }
    if (action is SuccessCreateMany<T>) {
      return this.adapter.addMany(
          action.entities,
          state.copyWith(
            creating: false,
            updateTimes: <K, DateTime>{
              ...state.updateTimes,
              ...action.entities.asMap().map<K, DateTime>(
                    (key, entity) => MapEntry<K, DateTime>(
                      adapter.getId(entity),
                      DateTime.now(),
                    ),
                  ),
            },
          ) as S);
    }
    if (action is RequestRetrieveOne<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[action.id] = true;
      return state.copyWith(loadingIds: newIds, error: false) as S;
    }
    if (action is RequestUpdateOne<T> ||
        action is RequestUpdateOneWith<T, dynamic>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[adapter.getId(action.entity)] = true;
      return state.copyWith(loadingIds: newIds, error: false) as S;
    }
    if (action is RequestDeleteOne<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[action.id] = true;
      return state.copyWith(loadingIds: newIds, error: false) as S;
    }
    if (action is RequestRetrieveAll<T>) {
      return state.copyWith(loadingAll: true, error: false) as S;
    }
    if (action is FailUpdateOne<T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[adapter.getId(action.entity)] = false;
      return state.copyWith(loadingIds: newIds, error: action.error) as S;
    }
    if (action is FailRetrieveOne<K, T> || action is FailDeleteOne<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[action.id] = false;
      return state.copyWith(loadingIds: newIds, error: action.error) as S;
    }

    if (action is FailRetrieveAll<T>) {
      return state.copyWith(loadingAll: false, error: action.error) as S;
    }

    if (action is SuccessUpdateOne<T> || action is SuccessRetrieveOne<T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[adapter.getId(action.entity)] = false;
      return this.adapter.upsertOne(
          action.entity,
          state.copyWith(
            loadingIds: newIds,
            updateTimes: <K, DateTime>{
              ...state.updateTimes,
              adapter.getId(action.entity): DateTime.now()
            },
          ) as S);
    }
    if (action is SuccessRetrieveOneFromCache<T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[adapter.getId(action.entity)] = false;
      return state.copyWith(
        loadingIds: newIds,
      ) as S;
    }

    if (action is SuccessRetrieveAll<T>) {
      return this.adapter.upsertMany(
            action.entities,
            state.copyWith(
              loadingAll: false,
              entities: {},
              ids: [],
              updateTimes: action.entities.asMap().map<K, DateTime>(
                    (key, entity) => MapEntry<K, DateTime>(
                      adapter.getId(entity),
                      DateTime.now(),
                    ),
                  ),
              lastFetchAllTime: DateTime.now(),
            ) as S,
          );
    }
    if (action is SuccessRetrieveAllFromCache<T>) {
      return state.copyWith(
        loadingAll: false,
      ) as S;
    }
    if (action is RequestUpdateMany<T> ||
        action is RequestUpdateManyWith<T, dynamic>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (T entity in action.entities) {
        newIds[adapter.getId(entity)] = true;
      }
      return state.copyWith(loadingIds: newIds, error: false) as S;
    }
    if (action is RequestDeleteMany<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (K id in action.ids) {
        newIds[id] = true;
      }
      return state.copyWith(loadingIds: newIds, error: false) as S;
    }
    if (action is FailUpdateMany<T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (T entity in action.entities) {
        newIds[adapter.getId(entity)] = false;
      }
      return state.copyWith(loadingIds: newIds, error: action.error) as S;
    }
    if (action is FailDeleteMany<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (K id in action.ids) {
        newIds[id] = false;
      }
      return state.copyWith(loadingIds: newIds, error: action.error) as S;
    }
    if (action is SuccessUpdateMany<T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (T entity in action.entities) {
        newIds[adapter.getId(entity)] = false;
      }
      return adapter.updateMany(
          action.entities,
          state.copyWith(
            loadingIds: newIds,
            updateTimes: <K, DateTime>{
              ...state.updateTimes,
              ...action.entities.asMap().map<K, DateTime>(
                    (key, entity) => MapEntry<K, DateTime>(
                      adapter.getId(entity),
                      DateTime.now(),
                    ),
                  ),
            },
          ) as S);
    }
    if (action is SuccessDeleteOne<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      newIds[action.id] = false;
      return adapter.removeOne(
          action.id, state.copyWith(loadingIds: newIds) as S);
    }
    if (action is SuccessDeleteMany<K, T>) {
      Map<K, bool> newIds = Map<K, bool>.from(state.loadingIds);
      for (K id in action.ids) {
        newIds[id] = false;
      }
      return adapter.removeMany(
          action.ids, state.copyWith(loadingIds: newIds) as S);
    }

    return state;
  }
}
