import './entity_state.dart';

class RemoteEntityState<T> extends EntityState<T> {
  final bool loadingAll;
  final Map<String, bool> loadingIds;
  final Map<String, DateTime> updateTimes;
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
    Map<String, T> entities = const {},
    List<String> ids = const [],
    this.error,
  })  : assert(loadingIds != null),
        assert(updateTimes != null),
        assert(entities != null),
        assert(ids != null),
        super(ids: ids, entities: entities);

  RemoteEntityState<T> copyWith({
    // EntityState properties
    Map<String, T>? entities,
    List<String>? ids,
    // our properties
    Map<String, DateTime>? updateTimes,
    DateTime? lastFetchAllTime,
    bool? loadingAll,
    Map<String, bool>? loadingIds,
    bool? creating,
    dynamic error,
  }) {
    return RemoteEntityState<T>(
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
        'updateTimes': this.updateTimes.map<String, String>(
            (key, val) => MapEntry<String, String>(key, val.toIso8601String())),
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
        ids: json['ids'] != null ? List<String>.from(json['ids']) : [],
        loadingAll: json['loadingAll'] ?? false,
        loadingIds: Map<String, bool>.from(json['loadingIds']),
        updateTimes: json['updateTimes'].map<String, DateTime>(
            (key, val) => MapEntry<String, DateTime>(key, DateTime.parse(val))),
        lastFetchAllTime: json['lastFetchAllTime'] != null
            ? DateTime.parse(json['lastFetchAllTime'])
            : null,
        creating: json['creating'],
        error: json['error'],
      );
}
