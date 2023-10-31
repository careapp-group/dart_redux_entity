import './entity_state.dart';

class RemoteEntityState<K, T> extends EntityState<K, T> {
  final bool loadingAll;
  final Map<K, bool> loadingIds;
  final Map<K, DateTime> updateTimes;
  final DateTime? lastFetchAllTime;
  final bool creating;
  final dynamic error;

  const RemoteEntityState({
    // our properties
    this.loadingAll = false,
    this.loadingIds = const {},
    this.creating = false,
    this.updateTimes = const {},
    this.lastFetchAllTime,
    // EntityState properties
    Map<K, T> entities = const {},
    List<K> ids = const [],
    this.error,
  }) : super(ids: ids, entities: entities);

  RemoteEntityState<K, T> copyWith({
    // EntityState properties
    Map<K, T>? entities,
    List<K>? ids,
    // our properties
    Map<K, DateTime>? updateTimes,
    DateTime? lastFetchAllTime,
    bool? loadingAll,
    Map<K, bool>? loadingIds,
    bool? creating,
    dynamic error,
  }) {
    return RemoteEntityState<K, T>(
        loadingAll: loadingAll ?? this.loadingAll,
        loadingIds: loadingIds ?? this.loadingIds,
        updateTimes: updateTimes ?? this.updateTimes,
        lastFetchAllTime: lastFetchAllTime ?? this.lastFetchAllTime,
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
        'updateTimes': this.updateTimes.map<K, String>(
            (key, val) => MapEntry<K, String>(key, val.toIso8601String())),
        'lastFetchAllTime': this.lastFetchAllTime != null
            ? this.lastFetchAllTime?.toIso8601String()
            : null,
        'creating': this.creating,
        'error': this.error,
      });
  }

  factory RemoteEntityState.fromJson(
    Map<String, dynamic> json,
    Deserializer<T> deserializer,
  ) =>
      RemoteEntityState(
        entities: (json['entities']).map<String, T>(
              (key, props) => MapEntry<String, T>(key, deserializer(props)),
            ) ??
            {},
        ids: json['ids'] != null ? List<K>.from(json['ids']) : [],
        loadingAll: json['loadingAll'] ?? false,
        loadingIds: Map<K, bool>.from(json['loadingIds']),
        updateTimes: json['updateTimes'].map<String, DateTime>(
            (key, val) => MapEntry<String, DateTime>(key, DateTime.parse(val))),
        lastFetchAllTime: json['lastFetchAllTime'] != null
            ? DateTime.parse(json['lastFetchAllTime'])
            : null,
        creating: json['creating'],
        error: json['error'],
      );
}
