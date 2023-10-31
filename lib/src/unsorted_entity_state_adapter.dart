import './create_state_operator.dart';
import './did_mutate.dart';
import './entity_state.dart';
import './entity_state_adapter.dart';
import './typedefs.dart';

IdSelector defaultIdSelector = (item) {
  return item.id;
};

class UnsortedEntityStateAdapter<K, T> implements EntityStateAdapter<K, T> {
  const UnsortedEntityStateAdapter({
    this.selectId,
  });

  final IdSelector<K, T>? selectId;

  S addOne<S extends EntityState<K, T>>(T entity, S state) {
    final op = createStateOperator<K, T, T>(_addOneMutably);
    return op(entity, state);
  }

  S addMany<S extends EntityState<K, T>>(List<T> entity, S state) {
    final op = createStateOperator<K, T, List<T>>(_addManyMutably);
    return op(entity, state);
  }

  S addAll<S extends EntityState<K, T>>(List<T> entity, S state) {
    final op = createStateOperator<K, T, List<T>>(_addAllMutably);
    return op(entity, state);
  }

  /// Removes an entity with the specified ID from the store
  S removeOne<S extends EntityState<K, T>>(K id, S state) {
    final op = createStateOperator<K, T, K>(_removeOneMutably);
    return op(id, state);
  }

  S removeMany<S extends EntityState<K, T>>(List<K> ids, S state) {
    final op = createStateOperator<K, T, List<K>>(_removeManyMutably);
    return op(ids, state);
  }

  S removeAll<S extends EntityState<K, T>>(S state) {
    return state.copyWith(ids: [], entities: {}) as S;
  }

  S updateOne<S extends EntityState<K, T>>(T item, S state) {
    final op = createStateOperator<K, T, T>(_updateOneMutably);
    return op(item, state);
  }

  S updateMany<S extends EntityState<K, T>>(List<T> items, S state) {
    final op = createStateOperator<K, T, List<T>>(_updateManyMutably);
    return op(items, state);
  }

  S upsertOne<S extends EntityState<K, T>>(T item, S state) {
    final op = createStateOperator<K, T, T>(_upsertOneMutably);
    return op(item, state);
  }

  S upsertMany<S extends EntityState<K, T>>(List<T> items, S state) {
    final op = createStateOperator<K, T, List<T>>(_upsertManyMutably);
    return op(items, state);
  }

  DidMutate _addOneMutably(T entity, EntityState<K, T> state) {
    final key = getId(entity);
    // nothing to be done
    if (state.entities.containsKey(key)) {
      return DidMutate.none;
    }
    state.ids.add(key);
    state.entities[key] = entity;

    return DidMutate.both;
  }

  DidMutate _addManyMutably<S extends EntityState<K, T>>(
      List<T> entities, S state) {
    bool didMutate = false;
    for (T entity in entities) {
      didMutate = _addOneMutably(entity, state) != DidMutate.none || didMutate;
    }
    return didMutate ? DidMutate.both : DidMutate.none;
  }

  DidMutate _addAllMutably<S extends EntityState<K, T>>(
      List<T> entities, S state) {
    state.ids.clear();
    state.entities.clear();
    _addManyMutably(entities, state);
    return DidMutate.both;
  }

  DidMutate _removeOneMutably(K key, EntityState<K, T> state) {
    return _removeManyMutably([key], state);
  }

  DidMutate _removeManyMutably(List<K> keys, EntityState<K, T> state) {
    final toRemove = keys.where((K key) => state.entities.containsKey(key));
    final bool didMutate = toRemove.length > 0;
    for (K key in toRemove) {
      state.entities.remove(key);
    }
    if (didMutate) {
      state.ids.removeWhere((id) => state.entities.containsKey(id) == false);
    }
    return didMutate ? DidMutate.both : DidMutate.none;
  }

  K getId(T item) {
    if (selectId != null) {
      return selectId!(item);
    }
    return (item as dynamic).id;
  }

  DidMutate _updateOneMutably(T changes, EntityState<K, T> state) {
    return _updateManyMutably([changes], state);
  }

  DidMutate _updateManyMutably(List<T> changes, EntityState<K, T> state) {
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

  DidMutate _upsertOneMutably(T entity, EntityState<K, T> state) {
    return _upsertManyMutably([entity], state);
  }

  DidMutate _upsertManyMutably(List<T> entities, EntityState<K, T> state) {
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
