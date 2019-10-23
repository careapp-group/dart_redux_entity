// Crud
class RequestCreateOne<T> {
  RequestCreateOne(this.entity);
  final T entity;
}

class SuccessCreateOne<T> {
  SuccessCreateOne(this.entity);
  final T entity;
}

class FailCreateOne<T> {
  FailCreateOne(this.entity, this.error);
  final T entity;
  final dynamic error;
}

class RequestCreateMany<T> {
  RequestCreateMany(this.entities);
  final List<T> entities;
}

class SuccessCreateMany<T> {
  SuccessCreateMany(this.entities);
  final List<T> entities;
}

class FailCreateMany<T> {
  FailCreateMany(this.entities, this.error);
  final List<T> entities;
  final dynamic error;
}

// cRud
class RequestRetrieveOne<T> {
  RequestRetrieveOne(this.id);
  final String id;
}

class SuccessRetrieveOne<T> {
  SuccessRetrieveOne(this.entity);
  final T entity;
}

class FailRetrieveOne<T> {
  FailRetrieveOne(this.id, this.error);
  final String id;
  final dynamic error;
}

class RequestRetrieveMany<T> {
  RequestRetrieveMany(this.ids);
  final List<String> ids;
}

class SuccessRetrieveMany<T> {
  SuccessRetrieveMany(this.entities);
  final List<T> entities;
}

class FailRetrieveMany<T> {
  FailRetrieveMany(this.ids, this.error);
  final List<String> ids;
  final dynamic error;
}

class RequestRetrieveAll<T> {}

class SuccessRetrieveAll<T> {
  SuccessRetrieveAll(this.entities);
  final List<T> entities;
}

class FailRetrieveAll<T> {
  FailRetrieveAll(this.error);
  final dynamic error;
}

// crUdclass RequestCreateOne<T> {
class RequestUpdateOne<T> {
  RequestUpdateOne(this.entity);
  final T entity;
}

class SuccessUpdateOne<T> {
  SuccessUpdateOne(this.entity);
  final T entity;
}

class FailUpdateOne<T> {
  FailUpdateOne(this.entity, this.error);
  final T entity;
  final dynamic error;
}

class RequestUpdateMany<T> {
  RequestUpdateMany(this.entities);
  final List<T> entities;
}

class SuccessUpdateMany<T> {
  SuccessUpdateMany(this.entities);
  final List<T> entities;
}

class FailUpdateMany<T> {
  FailUpdateMany(this.entities, this.error);
  final List<T> entities;
  final dynamic error;
}

// cruD

class RequestDeleteOne<T> {
  RequestDeleteOne(this.id);
  final String id;
}

class SuccessDeleteOne<T> {
  SuccessDeleteOne(this.entity);
  final T entity;
}

class FailDeleteOne<T> {
  FailDeleteOne(this.id, this.error);
  final String id;
  final dynamic error;
}

class RequestDeleteMany<T> {
  RequestDeleteMany(this.ids);
  final List<String> ids;
}

class SuccessDeleteMany<T> {
  SuccessDeleteMany(this.entities);
  final List<T> entities;
}

class FailDeleteMany<T> {
  FailDeleteMany(this.ids, this.error);
  final List<String> ids;
  final dynamic error;
}
