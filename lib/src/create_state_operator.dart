import './typedefs.dart';
import './entity_state.dart';
import './did_mutate.dart';

Operation<K, V, R> createStateOperator<K, V, R>(Mutator<R, K, V> mutator) {
  S operation<S extends EntityState<K, V>>(R arg, S state) {
    final clone = state.copyWith(
      ids: List<K>.from(state.ids),
      entities: Map<K, V>.from(state.entities),
    );
    final didMutate = mutator(arg, clone);
    if (didMutate == DidMutate.both) {
      return state.copyWith(ids: clone.ids, entities: clone.entities) as S;
    }
    if (didMutate == DidMutate.entitiesOnly) {
      return state.copyWith(entities: clone.entities) as S;
    }
    return state;
  }

  return operation;
}
