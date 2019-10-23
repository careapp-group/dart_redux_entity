class EntityState<T> {
  const EntityState({
    this.entities = const {},
    this.ids = const [],
  });

  EntityState copyWith({
    Map<String, T> entities,
    List<String> ids,
  }) {
    return new EntityState<T>(
      entities: entities ?? this.entities,
      ids: ids ?? this.ids,
    );
  }

  final Map<String, T> entities;
  final List<String> ids;
}
