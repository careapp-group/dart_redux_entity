// Crud
class RequestCreateOne<T> {
  const RequestCreateOne(this.entity);
  final T entity;
}

class SuccessCreateOne<T> {
  const SuccessCreateOne(this.entity);
  final T entity;
}

class FailCreateOne<T> {
  const FailCreateOne({this.entity, this.error});
  final T entity;
  final dynamic error;
}

class RequestCreateMany<T> {
  const RequestCreateMany(this.entities);
  final List<T> entities;
}

class SuccessCreateMany<T> {
  const SuccessCreateMany(this.entities);
  final List<T> entities;
}

class FailCreateMany<T> {
  const FailCreateMany({this.entities, this.error});
  final List<T> entities;
  final dynamic error;
}

// cRud
class RequestRetrieveOne<T> {
  const RequestRetrieveOne(this.id, {this.forceRefresh = false});

  /// The ID of the entity to fetch
  final String id;

  /// Whether to force a refresh (if you are using a caching mechanism)
  final bool forceRefresh;
}

class SuccessRetrieveOne<T> {
  const SuccessRetrieveOne(this.entity);
  final T entity;
}

/// A recent copy of the entity was already in the store
/// so returning with the cached copy
class SuccessRetrieveOneFromCache<T> {
  const SuccessRetrieveOneFromCache(this.entity);
  final T entity;
}

class FailRetrieveOne<T> {
  const FailRetrieveOne({this.id, this.error});
  final String id;
  final dynamic error;
}

class RequestRetrieveMany<T> {
  const RequestRetrieveMany(this.ids);
  final List<String> ids;
}

class SuccessRetrieveMany<T> {
  const SuccessRetrieveMany(this.entities);
  final List<T> entities;
}

class FailRetrieveMany<T> {
  const FailRetrieveMany(this.ids, this.error);
  final List<String> ids;
  final dynamic error;
}

class RequestRetrieveAll<T> {}

class SuccessRetrieveAll<T> {
  const SuccessRetrieveAll(this.entities);
  final List<T> entities;
}

class FailRetrieveAll<T> {
  const FailRetrieveAll(this.error);
  final dynamic error;
}

// crUdclass RequestCreateOne<T> {
class RequestUpdateOne<T> {
  const RequestUpdateOne(this.entity);
  final T entity;
}

class SuccessUpdateOne<T> {
  const SuccessUpdateOne(this.entity);
  final T entity;
}

class FailUpdateOne<T> {
  const FailUpdateOne({this.entity, this.error});
  final T entity;
  final dynamic error;
}

class RequestUpdateMany<T> {
  const RequestUpdateMany(this.entities);
  final List<T> entities;
}

class SuccessUpdateMany<T> {
  const SuccessUpdateMany(this.entities);
  final List<T> entities;
}

class FailUpdateMany<T> {
  const FailUpdateMany({this.entities, this.error});
  final List<T> entities;
  final dynamic error;
}

// cruD

class RequestDeleteOne<T> {
  const RequestDeleteOne(this.id);
  final String id;
}

class SuccessDeleteOne<T> {
  const SuccessDeleteOne(this.id);
  final String id;
}

class FailDeleteOne<T> {
  const FailDeleteOne({this.id, this.error});
  final String id;
  final dynamic error;
}

class RequestDeleteMany<T> {
  const RequestDeleteMany(this.ids);
  final List<String> ids;
}

class SuccessDeleteMany<T> {
  const SuccessDeleteMany(this.ids);
  final List<String> ids;
}

class FailDeleteMany<T> {
  const FailDeleteMany({this.ids, this.error});
  final List<String> ids;
  final dynamic error;
}
