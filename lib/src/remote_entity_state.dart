import './entity_state.dart';

class RemoteEntityState<T> extends EntityState<T> {
  final bool loadingAll;
  final Map<String, bool> loadingIds;
  final bool creating;
  final dynamic error;

  const RemoteEntityState({
    // our properties
    this.loadingAll = false,
    this.loadingIds = const {},
    this.creating = false,
    // EntityState properties
    Map<String, T> entities = const {},
    List<String> ids = const [],
    this.error,
  }) : super(ids: ids, entities: entities);

  RemoteEntityState<T> copyWith({
    // EntityState properties
    Map<String, T> entities,
    List<String> ids,
    // our properties
    bool loadingAll,
    Map<String, bool> loadingIds,
    bool creating,
    dynamic error,
  }) {
    return RemoteEntityState<T>(
        loadingAll: loadingAll ?? this.loadingAll,
        loadingIds: loadingIds ?? this.loadingIds,
        creating: creating ?? this.creating,
        error: error ?? this.error,
        entities: entities ?? this.entities,
        ids: ids ?? this.ids);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> top = super.toJson();
    return top
      ..addAll({
        'loadingAll': this.loadingAll,
        'loadingIds': this.loadingIds,
        'creating': this.creating,
        'error': this.error,
      });
  }

  factory RemoteEntityState.fromJson(
    Map<String, dynamic> json,
    Deserializer<T> deserializer,
  ) =>
      RemoteEntityState(
        entities: (json['entities'] as Map<String, dynamic>).map(
          (key, props) => MapEntry<String, T>(key, deserializer(props)),
        ),
        ids: List<String>.from(json['ids']),
        loadingAll: json['loadingAll'] ?? false,
        loadingIds: Map<String, bool>.from(json['loadingIds']),
        creating: json['creating'],
        error: json['error'],
      );
}
