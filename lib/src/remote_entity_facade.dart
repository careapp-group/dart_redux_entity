import 'package:redux/redux.dart';
import './remote_entity_actions.dart';

class RemoteEntityFacade<K, T> {
  RemoteEntityFacade(this.store);

  // create
  createOne(T entity) {
    store.dispatch(RequestCreateOne<T>(entity));
  }

  createMany(List<T> entities) {
    store.dispatch(RequestCreateMany<T>(entities));
  }

  // retrieve
  requestOne(K id) {
    store.dispatch(RequestRetrieveOne<K, T>(id));
  }

  requestMany(List<K> ids) {
    store.dispatch(RequestRetrieveMany<K, T>(ids));
  }

  requestAll() {
    store.dispatch(RequestRetrieveAll<T>());
  }

  // update
  updateOne(T updates) {
    store.dispatch(RequestUpdateOne<T>(updates));
  }

  updateMany(List<T> updates) {
    store.dispatch(RequestUpdateMany<T>(updates));
  }

  // delete
  deleteOne(K id) {
    store.dispatch(RequestDeleteOne<K, T>(id));
  }

  deleteMany(List<K> ids) {
    store.dispatch(RequestDeleteMany<K, T>(ids));
  }

  final Store store;
}
