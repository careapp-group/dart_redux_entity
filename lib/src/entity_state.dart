/**
 * A function that can deserialize an entity T from the JSON
 * representation
 */
typedef Deserializer<T> = T Function(dynamic);

class EntityState<K, T> {
  const EntityState({
    this.entities = const {},
    this.ids = const [],
  });

  final Map<K, T> entities;
  final List<K> ids;

  EntityState<K, T> copyWith({
    Map<K, T>? entities,
    List<K>? ids,
  }) {
    return new EntityState<K, T>(
      entities: entities ?? this.entities,
      ids: ids ?? this.ids,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entities': this.entities,
      'ids': this.ids,
    };
  }

  factory EntityState.fromJson(
    Map<String, dynamic> json,
    Deserializer<T> deserializer,
  ) =>
      EntityState(
          entities: (json['entities'] as Map<K, dynamic>).map(
            (key, props) => MapEntry<K, T>(key, deserializer(props)),
          ),
          ids: List<K>.from(json['ids']));
}
