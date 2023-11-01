/**
 * A function that can deserialize an entity T from the JSON
 * representation
 */
typedef Deserializer<T> = T Function(dynamic);

class EntityState<T> {
  const EntityState({
    this.entities = const {},
    this.ids = const [],
  });

  final Map<String, T> entities;
  final List<String> ids;

  EntityState<T> copyWith({
    Map<String, T>? entities,
    List<String>? ids,
  }) {
    return new EntityState<T>(
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
    Deserializer<T> fromJsonT,
  ) =>
      EntityState(
          entities: (json['entities'] as Map<String, dynamic>).map(
            (key, props) => MapEntry<String, T>(key, fromJsonT(props)),
          ),
          ids: List<String>.from(json['ids']));
}
