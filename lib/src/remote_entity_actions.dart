// Crud

/// Request creating an entity of type T with a request object of type R
class RequestCreateOneWith<T, R> {
  const RequestCreateOneWith(this.entity);
  final R entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

/// Request creating an entity of type T with a T request
class RequestCreateOne<T> extends RequestCreateOneWith<T, T> {
  const RequestCreateOne(T entity) : super(entity);
}

class SuccessCreateOne<T> {
  const SuccessCreateOne(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class FailCreateOne<T> {
  const FailCreateOne({this.entity, this.error});
  final T? entity;
  final dynamic error;
  Map<String, dynamic> toJson() => {'entity': entity, 'error': error};
}

class RequestCreateManyWith<T, R> {
  const RequestCreateManyWith(this.entities);
  final List<R> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

class RequestCreateMany<T> extends RequestCreateManyWith<T, T> {
  const RequestCreateMany(List<T> entities) : super(entities);
}

class SuccessCreateMany<T> {
  const SuccessCreateMany(this.entities);
  final List<T> entities;
  Map<String, dynamic> toJson() => {
        'entites': entities,
      };
}

class FailCreateMany<T> {
  const FailCreateMany({required this.entities, this.error});
  final List<T> entities;
  final dynamic error;
  Map<String, dynamic> toJson() => {'entites': entities, 'error': error};
}

// cRud
class RequestRetrieveOne<T> {
  const RequestRetrieveOne(this.id, {this.forceRefresh = false});

  /// The ID of the entity to fetch
  final String id;

  /// Whether to force a refresh (if you are using a caching mechanism)
  final bool forceRefresh;

  Map<String, dynamic> toJson() => {
        'id': id,
        'forceRefresh': forceRefresh,
      };
}

class SuccessRetrieveOne<T> {
  const SuccessRetrieveOne(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

/// A recent copy of the entity was already in the store
/// so returning with the cached copy
class SuccessRetrieveOneFromCache<T> {
  const SuccessRetrieveOneFromCache(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class FailRetrieveOne<T> {
  const FailRetrieveOne({
    required this.id,
    this.error,
  });
  final String id;
  final dynamic error;
  Map<String, dynamic> toJson() => {'id': id, 'error': error};
}

class RequestRetrieveMany<T> {
  const RequestRetrieveMany(this.ids);
  final List<String> ids;
  Map<String, dynamic> toJson() => {
        'ids': ids,
      };
}

class SuccessRetrieveMany<T> {
  const SuccessRetrieveMany(this.entities);
  final List<T> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

class FailRetrieveMany<T> {
  const FailRetrieveMany(this.ids, this.error);
  final List<String> ids;
  final dynamic error;
  Map<String, dynamic> toJson() => {'ids': ids, 'error': error};
}

class RequestRetrieveAll<T> {
  const RequestRetrieveAll({
    this.forceRefresh = false,
  });

  /// Whether to force a refresh (if you are using a caching mechanism)
  final bool forceRefresh;

  Map<String, dynamic> toJson() => {
        'forceRefresh': forceRefresh,
      };
}

class SuccessRetrieveAll<T> {
  const SuccessRetrieveAll(this.entities);
  final List<T> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

/// A recent copy of the entity was already in the store
/// so returning with the cached copy
class SuccessRetrieveAllFromCache<T> {
  const SuccessRetrieveAllFromCache(this.entities);
  final List<T> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

class FailRetrieveAll<T> {
  const FailRetrieveAll(this.error);
  final dynamic error;
  Map<String, dynamic> toJson() => {
        'error': error,
      };
}

// crUdclass RequestCreateOne<T> {
class RequestUpdateOneWith<T, R> {
  const RequestUpdateOneWith(this.entity);
  final R entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class RequestUpdateOneByIdWith<T, R> {
  const RequestUpdateOneByIdWith(this.id, this.entity);
  final String id;
  final R entity;
  Map<String, dynamic> toJson() => {
        'id': id,
        'entity': entity,
      };
}

class RequestUpdateOne<T> extends RequestUpdateOneWith<T, T> {
  const RequestUpdateOne(T request) : super(request);
}

class SuccessUpdateOne<T> {
  const SuccessUpdateOne(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class FailUpdateOne<T> {
  const FailUpdateOne({required this.entity, this.error});
  final T entity;
  final dynamic error;
  Map<String, dynamic> toJson() => {'entity': entity, 'error': error};
}

class RequestUpdateManyWith<T, R> {
  const RequestUpdateManyWith(this.entities);
  final List<R> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

class RequestUpdateMany<T> extends RequestUpdateManyWith<T, T> {
  const RequestUpdateMany(List<T> entities) : super(entities);
}

class SuccessUpdateMany<T> {
  const SuccessUpdateMany(this.entities);
  final List<T> entities;
  Map<String, dynamic> toJson() => {
        'entities': entities,
      };
}

class FailUpdateMany<T> {
  const FailUpdateMany({required this.entities, this.error});
  final List<T> entities;
  final dynamic error;
  Map<String, dynamic> toJson() => {'entities': entities, 'error': error};
}

// cruD

class RequestDeleteOne<T> {
  const RequestDeleteOne(this.id);
  final String id;
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class SuccessDeleteOne<T> {
  const SuccessDeleteOne(this.id);
  final String id;
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class FailDeleteOne<T> {
  const FailDeleteOne({required this.id, this.error});
  final String id;
  final dynamic error;
  Map<String, dynamic> toJson() => {'id': id, 'error': error};
}

class RequestDeleteMany<T> {
  const RequestDeleteMany(this.ids);
  final List<String> ids;
  Map<String, dynamic> toJson() => {
        'ids': ids,
      };
}

class SuccessDeleteMany<T> {
  const SuccessDeleteMany(this.ids);
  final List<String> ids;
  Map<String, dynamic> toJson() => {
        'ids': ids,
      };
}

class FailDeleteMany<T> {
  const FailDeleteMany({required this.ids, this.error});
  final List<String> ids;
  final dynamic error;
  Map<String, dynamic> toJson() => {
        'ids': ids,
        'error': error,
      };
}
