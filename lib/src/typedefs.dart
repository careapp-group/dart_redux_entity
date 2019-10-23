import './did_mutate.dart';
import './entity_state.dart';

typedef IdSelector<T> = String Function(T value);

typedef Predicate<T> = bool Function(T value);

typedef Mutator<R, V> = DidMutate Function(R arg, EntityState<V> state);
typedef Operation<V, R> = S Function<S extends EntityState<V>>(R arg, S state);
