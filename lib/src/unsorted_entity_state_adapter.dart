import './create_state_operator.dart';
import './typedefs.dart';
import './entity_state.dart';
import './entity_state_adapter.dart';
import './did_mutate.dart';

IdSelector defaultIdSelector = (item) {
  return item.id;
};

class UnsortedEntityStateAdapter<T> implements EntityStateAdapter<T> {
  const UnsortedEntityStateAdapter({
    this.selectId,
  });

  final IdSelector<T>? selectId;

  S addOne<S extends EntityState<T>>(T entity, S state) {
    final op = createStateOperator<T, T>(_addOneMutably);
    return op(entity, state);
  }

  S addMany<S extends EntityState<T>>(List<T> entity, S state) {
    final op = createStateOperator<T, List<T>>(_addManyMutably);
    return op(entity, state);
  }

  S addAll<S extends EntityState<T>>(List<T> entity, S state) {
    final op = createStateOperator<T, List<T>>(_addAllMutably);
    return op(entity, state);
  }

  /// Removes an entity with the specified ID from the store
  S removeOne<S extends EntityState<T>>(String id, S state) {
    final op = createStateOperator<T, String>(_removeOneMutably);
    return op(id, state);
  }

  S removeMany<S extends EntityState<T>>(List<String> ids, S state) {
    final op = createStateOperator<T, List<String>>(_removeManyMutably);
    return op(ids, state);
  }

  S removeAll<S extends EntityState<T>>(S state) {
    return state.copyWith(ids: [], entities: {}) as S;
  }

  S updateOne<S extends EntityState<T>>(T item, S state) {
    final op = createStateOperator<T, T>(_updateOneMutably);
    return op(item, state);
  }

  S updateMany<S extends EntityState<T>>(List<T> items, S state) {
    final op = createStateOperator<T, List<T>>(_updateManyMutably);
    return op(items, state);
  }

  S upsertOne<S extends EntityState<T>>(T item, S state) {
    final op = createStateOperator<T, T>(_upsertOneMutably);
    return op(item, state);
  }

  S upsertMany<S extends EntityState<T>>(List<T> items, S state) {
    final op = createStateOperator<T, List<T>>(_upsertManyMutably);
    return op(items, state);
  }

  DidMutate _addOneMutably(T entity, EntityState<T> state) {
    final key = getId(entity);
    // nothing to be done
    if (state.entities.containsKey(key)) {
      return DidMutate.none;
    }
    state.ids.add(key);
    state.entities[key] = entity;

    return DidMutate.both;
  }

  DidMutate _addManyMutably<S extends EntityState<T>>(
      List<T> entities, S state) {
    bool didMutate = false;
    for (T entity in entities) {
      didMutate = _addOneMutably(entity, state) != DidMutate.none || didMutate;
    }
    return didMutate ? DidMutate.both : DidMutate.none;
  }

  DidMutate _addAllMutably<S extends EntityState<T>>(
      List<T> entities, S state) {
    state.ids.clear();
    state.entities.clear();
    _addManyMutably(entities, state);
    return DidMutate.both;
  }

  DidMutate _removeOneMutably(String key, EntityState<T> state) {
    return _removeManyMutably([key], state);
  }

  DidMutate _removeManyMutably(List<String> keys, EntityState<T> state) {
    final toRemove =
        keys.where((String key) => state.entities.containsKey(key));
    final bool didMutate = toRemove.length > 0;
    for (String key in toRemove) {
      state.entities.remove(key);
    }
    if (didMutate) {
      state.ids.removeWhere((id) => state.entities.containsKey(id) == false);
    }
    return didMutate ? DidMutate.both : DidMutate.none;
  }

  String getId(T item) {
    if (selectId != null) {
      return selectId!(item);
    }
    return (item as dynamic).id;
  }

  DidMutate _updateOneMutably(T changes, EntityState<T> state) {
    return _updateManyMutably([changes], state);
  }

  DidMutate _updateManyMutably(List<T> changes, EntityState<T> state) {
    changes = changes
        .where((item) => state.entities.containsKey(getId(item)))
        .toList();
    if (changes.length == 0) {
      return DidMutate.none;
    }

    for (T item in changes) {
      state.entities[getId(item)] = item;
    }
    return DidMutate.entitiesOnly;
  }

  DidMutate _upsertOneMutably(T entity, EntityState<T> state) {
    return _upsertManyMutably([entity], state);
  }

  DidMutate _upsertManyMutably(List<T> entities, EntityState<T> state) {
    final List<T> added = [];
    final List<T> updated = [];

    for (T entity in entities) {
      final id = getId(entity);
      if (state.entities.containsKey(id)) {
        updated.add(entity);
      } else {
        added.add(entity);
      }
    }

    final didMutateByUpdate = _updateManyMutably(updated, state);
    final didMutateByAdd = _addManyMutably(added, state);

    if (didMutateByAdd == DidMutate.none && didMutateByUpdate == DidMutate.none)
      return DidMutate.none;
    if (didMutateByAdd == DidMutate.both || didMutateByUpdate == DidMutate.both)
      return DidMutate.both;

    return DidMutate.entitiesOnly;
  }
}
