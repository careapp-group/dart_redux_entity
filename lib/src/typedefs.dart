import './did_mutate.dart';
import './entity_state.dart';

typedef IdSelector<K, T> = K Function(T value);

typedef Predicate<T> = bool Function(T value);

typedef Mutator<R, K, V> = DidMutate Function(R arg, EntityState<K, V> state);
typedef Operation<K, V, R> = S Function<S extends EntityState<K, V>>(
    R arg, S state);
