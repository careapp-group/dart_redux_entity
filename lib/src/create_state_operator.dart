import './typedefs.dart';
import './entity_state.dart';
import './did_mutate.dart';

Operation<V, R> createStateOperator<V, R>(Mutator<R, V> mutator) {
  S operation<S extends EntityState<V>>(R arg, S state) {
    final clone = state.copyWith(
      ids: List<String>.from(state.ids),
      entities: Map<String, V>.from(state.entities),
    );
    final didMutate = mutator(arg, clone);
    if (didMutate == DidMutate.both) {
      return state.copyWith(ids: clone.ids, entities: clone.entities);
    }
    if (didMutate == DidMutate.entitiesOnly) {
      return state.copyWith(entities: clone.entities);
    }
    return state;
  }

  return operation;
}
